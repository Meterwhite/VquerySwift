//
//  LinkBlockInvocation.h
//  LinkBlockProgram
//
//  Created by NOVO on 2017/12/16.
//  Copyright © 2017年 NOVO. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN


/**
 NSInvocation object in block form
 block形式的NSInvocation对象
 */
@interface LinkBlockInvocation : NSObject

/**
 Construction method/构造方法
 */
+ (instancetype)invocationWithBlock:(id)block;
@property (nonatomic,readonly,copy) id block;
/**
 The signature of the method that exactly matches the block\
 完全匹配block的方法的签名
 - Block type method signature `NSString *(^)(int)`
 - Block Function definition `NSString *(*)(id, int)`
 - Block signature : `"@@?i"`
 - Method signature : `"@:i"` or `"@i"`
 */
///@property (readonly) NSMethodSignature *methodSignatureOfFunction;

/**
 The caller of the signature of the method that exactly matches the block\
 完全匹配block的方法的签名的调用者
 */
///- (NSInvocation*)invocationOfFunction;

#pragma mark - override NSInvocation
@property (nonatomic , readonly) NSMethodSignature *methodSignature;
///Manual management of memory does not require setting\手动管理内存不需要设置
- (void)retainArguments;
@property (readonly) BOOL argumentsRetained;

@property (nullable, assign) id target;
@property SEL selector;

- (void)getReturnValue:(void *)retLoc;
- (void)setReturnValue:(void *)retLoc;
/**
 @param argumentLocation block signature does not has`self` (`'@'`)
 and `_cmd` (`':'`) just have (`'@?'`),So the parameter is not set from 2 but from 1
 */
- (void)getArgument:(void *)argumentLocation atIndex:(NSInteger)idx;

/**
 Refer to getArgument:atIndex:
 */
- (void)setArgument:(void *)argumentLocation atIndex:(NSInteger)idx;

- (void)invoke;
- (void)invokeWithTarget:(id)target;
@end

NS_ASSUME_NONNULL_END
