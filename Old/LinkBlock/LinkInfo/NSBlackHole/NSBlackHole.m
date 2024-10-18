//
//  NSBlackHole.m
//  LinkBlockProgram
//
//  Created by NOVO on 2017/12/28.
//  Copyright © 2017年 NOVO. All rights reserved.
//

#import "NSBlackHole.h"
#import <os/lock.h>
#import <objc/runtime.h>

//系统结构体objc_method_description定义
typedef struct {
    SEL name;
    const char *types;
} bh_methodDescription;

Class *bh_copyClassList (unsigned *count) {
    //获取runtime注册的类的数目
    int classCount = objc_getClassList(NULL, 0);
    if (!classCount) {
        if (count)
            *count = 0;
        
        return NULL;
    }
    
    //为所有类分配空间，包括NULL
    Class *allClasses = (Class *)malloc(sizeof(Class) * (classCount + 1));
    if (!allClasses) {
        fprintf(stderr, "NSBlackHole ERROR: 内存不足\n");
        if (count)
            *count = 0;
        
        return NULL;
    }
    
    //填充
    classCount = objc_getClassList(allClasses, classCount);
    allClasses[classCount] = NULL;
    
    @autoreleasepool {
        //排除不符合的类
        for (int i = 0;i < classCount;) {
            Class class = allClasses[i];
            BOOL keep = YES;
            
            if (keep)
                keep &= class_respondsToSelector(class, @selector(methodSignatureForSelector:));
            
            if (keep) {
                if (class_respondsToSelector(class, @selector(isProxy)))
                    keep &= ![class isProxy];
            }
            
            if (!keep) {
                if (--classCount > i) {
                    memmove(allClasses + i, allClasses + i + 1, (classCount - i) * sizeof(*allClasses));
                }
                
                continue;
            }
            
            ++i;
        }
    }
    
    if (count)
        *count = (unsigned)classCount;
    
    return allClasses;
}

NSMethodSignature *bh_globalMethodSignatureForSelector (SEL aSelector) {
    NSCParameterAssert(aSelector != NULL);
    
    //创建缓存散列
    static const size_t selectorCacheLength = 1 << 8;
    static const uintptr_t selectorCacheMask = (selectorCacheLength - 1);
    static bh_methodDescription volatile methodDescriptionCache[selectorCacheLength];
    
    uintptr_t hash = (uintptr_t)((void *)aSelector) & selectorCacheMask;
    bh_methodDescription methodDesc;
    
    //读和写需要原子性,这里会将非常快
    static os_unfair_lock lock = OS_UNFAIR_LOCK_INIT;
    
    os_unfair_lock_lock(&lock);
    methodDesc = methodDescriptionCache[hash];
    os_unfair_lock_unlock(&lock);
    
    //缓存命中
    if (methodDesc.name == aSelector) {
        return [NSMethodSignature signatureWithObjCTypes:methodDesc.types];
    }
    
    methodDesc = (bh_methodDescription){.name = NULL, .types = NULL};
    
    uint classCount = 0;
    Class *classes = bh_copyClassList(&classCount);
    
    if (classes) {
        @autoreleasepool {
            //autorelease防止所有Cocoa类执行+initialize
            for (uint i = 0;i < classCount;++i) {
                Class cls = classes[i];
                
                Method method = class_getInstanceMethod(cls, aSelector);
                if (!method)
                    method = class_getClassMethod(cls, aSelector);
                
                if (method) {
                    methodDesc = (bh_methodDescription){.name = aSelector, .types = method_getTypeEncoding(method)};
                    break;
                }
            }
        }
        free(classes);
    }
    
    //如果没有找到,通过protocol optional去找
    if (!methodDesc.name) {
        uint protocolCount = 0;
        Protocol * __unsafe_unretained *protocols = objc_copyProtocolList(&protocolCount);
        if (protocols) {
            struct objc_method_description objcMethodDesc;
            for (uint i = 0;i < protocolCount;++i) {
                objcMethodDesc = protocol_getMethodDescription(protocols[i], aSelector, NO, YES);
                if (!objcMethodDesc.name)
                    objcMethodDesc = protocol_getMethodDescription(protocols[i], aSelector, NO, NO);
                
                if (objcMethodDesc.name) {
                    methodDesc = (bh_methodDescription){.name = objcMethodDesc.name, .types = objcMethodDesc.types};
                    break;
                }
            }
            free(protocols);
        }
    }
    
    if (methodDesc.name) {
        
        //如果不能上锁,立刻缓存这个值
        if (os_unfair_lock_trylock(&lock)) {
            methodDescriptionCache[hash] = methodDesc;
            os_unfair_lock_unlock(&lock);
        }
        
        /*
         有一些复杂的系统类型编码会导致-signatureWithObjCTypes:调用失败。
         例如：-[NSDecimalNumber -initWithDecimal:]
        */
        return [NSMethodSignature signatureWithObjCTypes:methodDesc.types];
    } else {
        return nil;
    }
}

@implementation NSBlackHole

static id _self = nil;

+ (void)initialize
{
    if(self == [NSBlackHole class]){
        if(!_self){
            _self = [self alloc];
        }
    }
}

+ (id)value
{
    return _self;
}

+ (id)new
{
    return nil;
}

- (id)init
{
    return nil;
}

- (NSString *)description
{
    return nil;
}

- (NSString *)debugDescription
{
    return nil;
}

#pragma mark 消息转发

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    return bh_globalMethodSignatureForSelector(selector);
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSUInteger returnLength = [[anInvocation methodSignature] methodReturnLength];
    if (!returnLength) {
        return;
    }
    
    //返回值填充0
    char buffer[returnLength];
    memset(buffer, 0, returnLength);
    
    [anInvocation setReturnValue:buffer];
}

- (BOOL)respondsToSelector:(SEL)selector
{
    return NO;
}
#pragma mark NSObject protocol

- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    return NO;
}

- (NSUInteger)hash
{
    return 0;
}

- (BOOL)isEqual:(id)obj
{
    return obj == nil || obj == _self ;
}

- (BOOL)isKindOfClass:(Class)class
{
    return NO;
}

- (BOOL)isMemberOfClass:(Class)class
{
    return NO;
}

- (BOOL)isProxy
{
    return NO;
}

#pragma mark 特别的
- (instancetype)initWithDecimal:(NSDecimal)dcm
{
    return nil;
}
@end
