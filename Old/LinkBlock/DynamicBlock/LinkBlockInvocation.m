//
//  LinkBlockInvocation.m
//  LinkBlockProgram
//
//  Created by NOVO on 2017/12/16.
//  Copyright © 2017年 NOVO. All rights reserved.
//

#import "LinkBlockInvocation.h"

typedef NS_OPTIONS(int, LBBlockFlags) {
    LBBlockFlagsHasCopyDisposeHelpers   = (1 << 25),
    LBBlockFlagsHasCtroHelpers          = (1 << 26), // helpers have C++ code
    LBBlockFlagsIsGlobal                = (1 << 28),
    LBBlockFlagsHasStret                = (1 << 29),// IFF BLOCK_HAS_SIGNATURE
    LBBlockFlagsHasSignature            = (1 << 30)
};

/**
 block结构体
 */
typedef struct _lb_block_literal {
    __unused Class isa;
    LBBlockFlags flags;
    __unused int reserved;
    void (__unused *invoke)(struct _lb_block_literal *block, ...);
    struct {
        unsigned long int reserved;     // NULL
        unsigned long int size;         // sizeof(struct Block_literal_1)
        // requires BKBlockFlagsHasCopyDisposeHelpers
        void (*copy)(void *dst, const void *src);
        void (*dispose)(const void *);
        // requires BKBlockFlagsHasSignature
        const char *signature;
        const char *layout;
    } *descriptor;
    // imported variables
} *LBBlockRef;


/**
 比较objcType
 */
NS_INLINE BOOL LBTypesCompatible(const char *a, const char *b) {
    if (a[0] == b[0]) { return YES; }
    NSUInteger aSize, aAlign, bSize, bAlign;
    NSGetSizeAndAlignment(a, &aSize, &aAlign);
    NSGetSizeAndAlignment(a, &bSize, &bAlign);
    if (aSize == bSize && aAlign == bAlign) { return YES; }
    return !!strcmp(a, b);
}

@interface LinkBlockInvocation()

@property (nonatomic,strong) NSInvocation* invocation;

@end

@implementation LinkBlockInvocation


/**
 比较方法签名
 */
+ (BOOL)isSignature:(NSMethodSignature *)signatureA compatibleWithSignature:(NSMethodSignature *)signatureB __attribute__((pure))
{
    if (!signatureA || !signatureB) return NO;
    
    if ([signatureA isEqual:signatureB]) return YES;
    //类型比较
    if (!LBTypesCompatible(signatureA.methodReturnType, signatureB.methodReturnType)) return NO;
    
    //'方法形式的调用者'和'block形式的调用者'相比较
    //参数多的为方法形式的调用者
    NSMethodSignature *methodSignature = nil, *blockSignature = nil;
    if (signatureA.numberOfArguments > signatureB.numberOfArguments) {
        methodSignature = signatureA;
        blockSignature = signatureB;
    } else if (signatureB.numberOfArguments > signatureA.numberOfArguments) {
        methodSignature = signatureB;
        blockSignature = signatureA;
    } else {
        return NO;
    }
    //比较每一个参数类型
    NSUInteger numberOfArguments = methodSignature.numberOfArguments;
    for (NSUInteger i = 2; i < numberOfArguments; i++) {
        if (!LBTypesCompatible([methodSignature getArgumentTypeAtIndex:i]
                               ,
                               [blockSignature getArgumentTypeAtIndex:i - 1])){
            return NO;
        }
    }
    return YES;
}

/**
 从block获取方法签名
 */
+ (NSMethodSignature *)signatureFromBlock:(id)block __attribute__((pure, nonnull(1)))
{
    LBBlockRef layout = (__bridge void *)block;
    
    if (!(layout->flags & LBBlockFlagsHasSignature))
        return nil;
    
    void *desc = layout->descriptor;
    desc += 2 * sizeof(unsigned long int);
    
    if (layout->flags & LBBlockFlagsHasCopyDisposeHelpers)
        desc += 2 * sizeof(void *);
    
    if (!desc)
        return nil;
    
    const char *signature = (*(const char **)desc);
    
    return [NSMethodSignature signatureWithObjCTypes:signature];
}


/**
 block形式签名转方法形式签名
 */
+ (NSMethodSignature *)methodSignatureFromBlockSignature:(NSMethodSignature *)blockSignature
{
    if (!blockSignature) return nil;
    
    if (blockSignature.numberOfArguments < 1) {
        return nil;
    }
    
    if (blockSignature.numberOfArguments >= 2 && strcmp(@encode(SEL), [blockSignature getArgumentTypeAtIndex:1]) == 0) {
        return blockSignature;
    }
    
    //容量num.arguments - 1 (@? -> @) + 1 (:) + 1 (ret type)
    //大部分方法方法签名部分在[1]
    NSMutableString *signature = [[NSMutableString alloc] initWithCapacity:blockSignature.numberOfArguments + 1];
    
    const char *retTypeStr = blockSignature.methodReturnType;
    [signature appendFormat:@"%s%s%s", retTypeStr, @encode(id), @encode(SEL)];
    
    for (NSUInteger i = 1; i < blockSignature.numberOfArguments; i++) {
        const char *typeStr = [blockSignature getArgumentTypeAtIndex:i];
        NSString *type = [[NSString alloc] initWithBytesNoCopy:(void *)typeStr length:strlen(typeStr) encoding:NSUTF8StringEncoding freeWhenDone:NO];
        [signature appendString:type];
    }
    
    return [NSMethodSignature signatureWithObjCTypes:signature.UTF8String];
}

+ (NSMethodSignature *)methodSignatureForBlock:(id)block
{
    NSMethodSignature *blockSignature = [self signatureFromBlock:block];
    if (!blockSignature) return nil;
//    return [self methodSignatureFromBlockSignature:original];
    return blockSignature;//使用原生block方法签名
}


- (instancetype)initWithBlock:(id)block
{
    self = [super init];
    if (self) {
        self.invocation = [NSInvocation invocationWithMethodSignature:
                           [self.class methodSignatureForBlock:block]];
        self.invocation.target = block;
        _block = [_block copy];
    }
    return self;
}

+ (instancetype)invocationWithBlock:(id)block
{
    return [[self alloc] initWithBlock:block];
}

- (NSMethodSignature *)methodSignatureOfFunction
{
    return [self.class methodSignatureFromBlockSignature:self.methodSignature];
}

- (NSInvocation *)invocationOfFunction
{
    return [NSInvocation invocationWithMethodSignature:self.methodSignatureOfFunction];
}

#pragma mark - override
- (NSMethodSignature *)methodSignature
{
    return self.invocation.methodSignature;
}
- (BOOL)argumentsRetained
{
    return self.argumentsRetained;
}
- (id)target
{
    return self.invocation.target;
}
- (void)setTarget:(id)target
{
    self.invocation.target = target;
}
- (SEL)selector
{
    return self.invocation.selector;
}
- (void)setSelector:(SEL)selector
{
    self.invocation.selector = selector;
}
- (void)retainArguments
{
    [self.invocation retainArguments];
}
- (void)getReturnValue:(void *)retLoc
{
    [self.invocation getReturnValue:retLoc];
}
- (void)setReturnValue:(void *)retLoc
{
    [self.invocation setReturnValue:retLoc];
}
- (void)getArgument:(void *)argumentLocation atIndex:(NSInteger)idx
{
    [self.invocation getArgument:argumentLocation atIndex:idx];
}
- (void)setArgument:(void *)argumentLocation atIndex:(NSInteger)idx
{
    [self.invocation setArgument:argumentLocation atIndex:idx];
}
- (void)invoke
{
    [self.invocation invoke];
}
- (void)invokeWithTarget:(id)target
{
    [self.invocation invokeWithTarget:target];
}

@end
