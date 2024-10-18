//
//  NSObject+LinkBlock.m
//
//  Created by NOVO on 15/8/12.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import <objc/runtime.h>
#import <CoreData/CoreData.h>
#import "LinkBlock.h"
#import "DynamicLink.h"
#import "LinkHelper.h"
#import "LinkBlockInvocation.h"
#import "NSNil.h"

#ifndef _LB_performSelector
#define _LB_performSelector(target , selector) \
(((void (*)(id, SEL))[target methodForSelector:selector])(target, selector))
#endif

#ifndef _LB_performSelector1
#define _LB_performSelector1(target , selector, object)\
(((void (*)(id, SEL, id))[target methodForSelector:selector])(target, selector, object))
#endif

@implementation NSObject(LinkBlockNSObject)

+ (BOOL)lb_classIsBasic
{
    static NSSet *_baseDataClasses;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _baseDataClasses =
        [NSSet setWithObjects:NSClassFromString(@"NSBlock")
         , [NSNull class],[NSProxy class]
         , [NSString class],[NSValue class]
         , [NSArray class],[NSDictionary class]
         , [NSSet class],[NSOrderedSet class]
         , [NSMapTable class],[NSHashTable class]
         , [NSPointerArray class],[NSPointerFunctions class]
         , [NSIndexSet class],[NSCharacterSet class]
         , [NSURL class],[NSIndexPath class]
         , [NSAttributedString class],[NSParagraphStyle class]
         , [NSData class],[NSCoder class]
         , [NSFormatter class]
         , nil];
    });
    
    ///Root
    if(self == [NSObject class] || self == [NSManagedObject class]) return YES;
    
    id object = nil;
    NSEnumerator* enumertor = [_baseDataClasses objectEnumerator];
    while ((object = enumertor.nextObject)) {
        
        if([self isSubclassOfClass:object])
            return YES;
    }
    
    object = NSStringFromClass(self);
    if([object length] > 1){
        
        object = [object substringToIndex:2];
        
        if([self superclass] == [NSObject class]       ||
           [self superclass] == [UIResponder class]    ||
           [self superclass] == [UIView class]         ||
           [self superclass] == [CALayer class]        ||
           [self superclass] == [CAAnimation class]
           ){
            
            if(([object isEqualToString:@"NS"])     ||
               ([object isEqualToString:@"UI"])     ||
               ([object isEqualToString:@"CA"])
               ) return YES;
        }
    }
    
    return NO;
}

+ (BOOL)lb_classContainProperty:(NSString*)property
{
    unsigned int outCount, i;
    objc_property_t* properties = class_copyPropertyList([self class], &outCount);
    for(i=0 ; i< outCount; i++){
        if([property isEqualToString:[NSString stringWithUTF8String:property_getName(properties[i])]]){
            free(properties);
            return YES;
        }
    }
    free(properties);
    return NO;
}

+ (BOOL)lb_classContainIvar:(NSString*)ivarName
{
    unsigned int outCout ,i ;
    Ivar* ivars = class_copyIvarList([self class], &outCout);
    for(i=0;i< outCout;i++){
        if([ivarName isEqualToString:[NSString stringWithUTF8String:ivar_getName(ivars[i])]]){
            free(ivars);
            return YES;
        }
    }
    free(ivars);
    return NO;
}

+ (NSArray<NSString*>*)lb_classGetIvarList
{
    unsigned int outCount , i;
    Ivar* ivars = class_copyIvarList([self class], &outCount);
    NSMutableArray* ret = [NSMutableArray new];
    for(i=0 ; i< outCount; i++)
        [ret addObject:[NSString stringWithUTF8String:ivar_getName(ivars[i])]];
    free(ivars);
    return ret.copy;
}
+ (NSArray<NSString*>*)lb_classGetPropertyList
{
    unsigned int outCount, i;
    objc_property_t* properties = class_copyPropertyList([self class], &outCount);
    
    NSMutableArray* ret = [NSMutableArray new];
    
    for(i=0 ; i< outCount; i++){
        [ret addObject:[NSString stringWithUTF8String:property_getName(properties[i])]];
    }
    free(properties);
    return ret.copy;
}

+ (NSString *)lb_classGetPropertyType:(NSString *)key
{
    NSString *code = nil;
    unsigned int outCount, i;
    objc_property_t* properties = class_copyPropertyList([self class], &outCount);
    
    for(i=0 ; i< outCount; i++){
        
        NSString* pName = @(property_getName(properties[i]));
        if([pName isEqualToString:key]){
            
            NSString *attrs = @(property_getAttributes(properties[i]));
            NSUInteger dotLoc = [attrs rangeOfString:@","].location;
            NSUInteger loc = 1;
            if (dotLoc == NSNotFound) {
                code = [attrs substringFromIndex:loc];
            } else {
                code = [attrs substringWithRange:NSMakeRange(loc, dotLoc - loc)];
            }
            return code;
        }
    }
    free(properties);
    return code;
}

+ (NSArray<NSString*>*)lb_classGetAllPropertyList:(BOOL)includeFoundation
{
    NSMutableArray* ret = [NSMutableArray new];
    [self lb_classEnumerateUsingBlock:^(__unsafe_unretained Class clazz, BOOL *stop) {
        if(clazz == [NSObject class]) return;
        [ret addObjectsFromArray:[clazz lb_classGetPropertyList]];
    } includeBasic:includeFoundation];
    return ret.copy;
}

+ (NSArray<NSString*>*)lb_classGetClassMethodList
{
    unsigned int outCount;
    Method* methods = class_copyMethodList(object_getClass(self), &outCount);
    NSMutableArray* ret = [NSMutableArray new];
    for (int i = 0; i < outCount; i++) {
        SEL name = method_getName(methods[i]);
        NSString* methodName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        [ret addObject:methodName];
    }
    free(methods);
    return ret.copy;
}

- (NSArray<NSString*>*)lb_objGetInstanceMethodList
{
    unsigned int outCount;
    Method* methods = class_copyMethodList([self class], &outCount);
    NSMutableArray* ret = [NSMutableArray new];
    for (int i = 0; i < outCount; i++) {
        SEL name = method_getName(methods[i]);
        NSString* methodName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        [ret addObject:methodName];
    }
    free(methods);
    return ret.copy;
}

+ (NSArray<NSString*>*)lb_classGetProtocolList
{
    unsigned int outCount;
    NSMutableArray* ret = [NSMutableArray new];
    
    __unsafe_unretained Protocol **protocols = class_copyProtocolList(self, &outCount);
    
    for (int i = 0; i < outCount; i++) {
        
        NSString* protocolName= [NSString stringWithCString:protocol_getName(protocols[i]) encoding:NSUTF8StringEncoding];
        [ret addObject:protocolName];
    }
    free(protocols);
    return ret.copy;
}

+ (void)lb_classEnumerateUsingBlock:(void (^)(__unsafe_unretained Class, BOOL *))block
               includeBasic:(BOOL)includeFoundation
{
    if(!block)  return;
    BOOL stop = NO;
    Class clazz = self;
    while (clazz && !stop) {
        
        block(clazz, &stop);
        clazz = class_getSuperclass(clazz);
        if(!includeFoundation && [clazz lb_classIsBasic]) break;
    }
}

+ (void)lb_classPropertysEnumerateUsingBlock:(void (^)(__unsafe_unretained Class, NSString *, NSString *, BOOL *))block includeBasic:(BOOL)includeFoundation
{
    if(!block)  return;
    BOOL stop = NO;
    Class clazz = self;
    while (clazz && !stop) {
        
        NSString *code = nil;
        unsigned int outCount, i;
        objc_property_t* properties = class_copyPropertyList(clazz, &outCount);
        for(i=0 ; i< outCount; i++){
            
            NSString* pName = [NSString stringWithUTF8String:property_getName(properties[i])];
            NSString *attrs = @(property_getAttributes(properties[i]));
            NSUInteger dotLoc = [attrs rangeOfString:@","].location;
            NSUInteger loc = 1;
            if (dotLoc == NSNotFound) {
                code = [attrs substringFromIndex:loc];
            } else {
                code = [attrs substringWithRange:NSMakeRange(loc, dotLoc - loc)];
            }
            
            if (code.length > 3 && [code hasPrefix:@"@\""]) {//对象
                // 去掉@"和"，截取中间的类型名称
                code = [code substringWithRange:NSMakeRange(2, code.length - 3)];
            }
            block(clazz,pName,code,&stop);
        }
        free(properties);
        
        clazz = class_getSuperclass(clazz);
        if(!includeFoundation && [clazz lb_classIsBasic]) break;
    }
}

+ (NSString *(^)(NSString*))classProgrammingTypeForKey
{
    return ^id(NSString* key){
        
        LinkHandle_REF(NSObject)
        
        BOOL                stop    =   NO;
        Class               clazz   =   self;
        unsigned int        outCount   ,   i;
        objc_property_t*    properties;
        
        while (clazz && !stop) {
            
            properties = class_copyPropertyList(clazz, &outCount);
            for(i=0 ; i< outCount; i++){
                
                NSString* pName = @(property_getName(properties[i]));
                
                if([pName isEqualToString:key] == NO) continue;
                
                
                NSString *attrs = @(property_getAttributes(properties[i]));
                NSUInteger dotLoc = [attrs rangeOfString:@","].location;
                NSString *code = nil;
                NSUInteger loc = 1;
                
                if (dotLoc == NSNotFound) {
                    code = [attrs substringFromIndex:loc];
                } else {
                    code = [attrs substringWithRange:NSMakeRange(loc, dotLoc - loc)];
                }

                if ([code isEqualToString:@"@"]) {
                    
                    return @"id";
                } else if (code.length == 0) {
                    
                    return nil;
                } else if (code.length > 3 && [code hasPrefix:@"@\""]) {
                    //对象
                    // 去掉@"和"，截取中间的类型名称
                    code = [code substringWithRange:NSMakeRange(2, code.length - 3)];
                    NSUInteger protocolLoc = [code rangeOfString:@"<"].location;
                    if(protocolLoc != NSNotFound
                       &&
                       [code characterAtIndex:code.length-1] == '>'
                       ){
                        //?<AProtocol>
                        if(protocolLoc == 0)    return @"id";
                        return [code substringToIndex:protocolLoc];
                    }
                    //Class
                    return code;
                } else if ([code isEqualToString:@"^{objc_ivar=}"]
                           ) {
                    
                    return @"objc_ivar";
                }else if([code isEqualToString:@"^{objc_method=}"]){
                    
                    return @"objc_method";
                }else if([code isEqualToString:@"@?"]){
                    
                    return @"NSBlock";
                }else if([code isEqualToString:@":"]){
                    
                    return @"SEL";
                }
                else if(code.length > 3                                 &&
                         [code characterAtIndex:0] == '{'               &&
                         [code characterAtIndex:code.length-1] == '}'   &&
                         [code containsString:@"="]
                         ){
                    //Other structual
                    code = [[code substringFromIndex:1] componentsSeparatedByString:@"="].firstObject;
                    return code;
                }else if ([code isEqualToString:@"c"]){
                    return @"char";
                }else if ([code isEqualToString:@"C"]){
                    return @"unsigned char";
                }else if ([code isEqualToString:@"i"]){
                    return @"int";
                }else if ([code isEqualToString:@"I"]){
                    return @"unsigned int";
                }else if ([code isEqualToString:@"s"]){
                    return @"short";
                }else if ([code isEqualToString:@"S"]){
                    return @"unsigned short";
                }else if ([code isEqualToString:@"l"]){
                    return @"long";
                }else if ([code isEqualToString:@"L"]){
                    return @"unsigned long";
                }else if ([code isEqualToString:@"q"]){
                    return @"long long";
                }else if ([code isEqualToString:@"Q"]){
                    return @"unsigned long long";
                }else if ([code isEqualToString:@"f"]){
                    return @"float";
                }else if ([code isEqualToString:@"d"]){
                    return @"double";
                }else if ([code isEqualToString:@"B"]){
                    return @"bool";
                }
                return nil;
            }
            
            free(properties);
            clazz = class_getSuperclass(clazz);
        }
        
        return nil;
    };
}

- (NSObject *(^)(id))objInitializeValueForKey
{
    return ^id(id asKey){
        
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objInitializeValueForKey , asKey)
        
        NSInteger count = 1;
        NSString* key   = asKey;
        if(![asKey isKindOfClass:NSArray.class]){
            
            goto CALL_SET_VALUE;
        }
        
        count = [asKey count];
        
    CALL_FOR:
        
        if(count == 0) return self;
        key = [asKey objectAtIndex:count];
        
        
    CALL_SET_VALUE:
        {
            BOOL                stop    =   NO;
            Class               clazz   =   self.class;
            unsigned int        outCount   ,   i;
            objc_property_t*    properties;
            
            while (clazz && !stop)
            {
                
                properties = class_copyPropertyList(clazz, &outCount);
                for(i = 0 ; i < outCount; i++)
                {
                    
                    NSString* pName = @(property_getName(properties[i]));
                    
                    if([pName isEqualToString:key] == NO)
                        
                        continue;
                    
                    NSString   *attrs = @(property_getAttributes(properties[i]));
                    NSUInteger  dotLoc = [attrs rangeOfString:@","].location;
                    NSArray    *attrInfos = [attrs componentsSeparatedByString:@","];
                    NSString   *code = nil;
                    NSUInteger  loc = 1;
                    
                    if (dotLoc == NSNotFound) {
                        code = [attrs substringFromIndex:loc];
                    } else {
                        code = [attrs substringWithRange:NSMakeRange(loc, dotLoc - loc)];
                    }
                    
                    if (code.length == 0)
                    {
                        stop = YES; break;
                    }
                    
                    if([attrInfos containsObject:@"R"]){
                        //只读属性
                        stop = YES; break;
                    }else if (![[attrInfos.lastObject substringToIndex:1] isEqualToString:@"V"]){
                        //无成员变量
                        stop = YES; break;
                    }
                    
                    
                    
                    if (code.length > 3 && [code hasPrefix:@"@\""])
                    {
                        //Object
                        //Get class type
                        code = [code substringWithRange:NSMakeRange(2, code.length - 3)];
                        if([code characterAtIndex:0] == '<'){
                            //'id<AProtocol>'
                            stop = YES; break;
                        }
                        
                        Class clz = NSClassFromString(code);
                        if(clz == nil)
                        {
                            stop = YES; break;
                        }
                        
                        if([clz isSubclassOfClass:NSNumber.class]){
                            
                            [_self setValue:@0 forKey:pName];
                        }
                        
                        [_self setValue:[clz new] forKey:pName];
                    }
                    else if ([code isEqualToString:@(@encode(CGRect))]){
                        [_self setValue:[NSValue valueWithCGRect:CGRectZero] forKey:pName];
                    }else if ([code isEqualToString:@(@encode(CGSize))]){
                        [_self setValue:[NSValue valueWithCGSize:CGSizeZero] forKey:pName];}
                    else if ([code isEqualToString:@(@encode(CGPoint))]){
                        [_self setValue:[NSValue valueWithCGPoint:CGPointZero] forKey:pName];}
                    else if ([code isEqualToString:@(@encode(UIEdgeInsets))]){
                        [_self setValue:[NSValue valueWithUIEdgeInsets:UIEdgeInsetsZero] forKey:pName];
                    }else if ([code isEqualToString:@(@encode(NSRange))]){
                        [_self setValue:[NSValue valueWithRange:NSMakeRange(0, 0)] forKey:pName];
                    }else if ([code isEqualToString:@(@encode(CGVector))]){
                        [_self setValue:[NSValue valueWithCGVector:CGVectorMake(0.0, 0.0)] forKey:pName];
                    }else if ([code isEqualToString:@(@encode(UIOffset))]){
                        [_self setValue:[NSValue valueWithUIOffset:UIOffsetZero] forKey:pName];
                    }else if ([code isEqualToString:@(@encode(UIOffset))]){
                        [_self setValue:[NSValue valueWithCATransform3D:CATransform3DIdentity] forKey:pName];
                    }else if(code.length > 3                               &&
                            [code characterAtIndex:0] == '{'               &&
                            [code characterAtIndex:code.length-1] == '}'   &&
                            [code containsString:@"="])
                    {
                        //Other structual
                        NSValue* structValue = [[_self.class new] valueForKey:pName];
                        if(structValue) [_self setValue:structValue forKey:pName];
                    }else if ([code isEqualToString:@"c"]){
                        [_self setValue:[NSNumber numberWithChar:0] forKey:pName];
                    }else if ([code isEqualToString:@"C"]){
                        [_self setValue:[NSNumber numberWithUnsignedChar:0] forKey:pName];
                    }else if ([code isEqualToString:@"i"]){
                        [_self setValue:[NSNumber numberWithInt:0] forKey:pName];
                    }else if ([code isEqualToString:@"I"]){
                        [_self setValue:[NSNumber numberWithUnsignedInt:0] forKey:pName];
                    }else if ([code isEqualToString:@"s"]){
                        [_self setValue:[NSNumber numberWithShort:0] forKey:pName];
                    }else if ([code isEqualToString:@"S"]){
                        [_self setValue:[NSNumber numberWithUnsignedShort:0] forKey:pName];
                    }else if ([code isEqualToString:@"l"]){
                        [_self setValue:[NSNumber numberWithLong:0] forKey:pName];
                    }else if ([code isEqualToString:@"L"]){
                        [_self setValue:[NSNumber numberWithUnsignedLong:0] forKey:pName];
                    }else if ([code isEqualToString:@"q"]){
                        [_self setValue:[NSNumber numberWithLongLong:0] forKey:pName];
                    }else if ([code isEqualToString:@"Q"]){
                        [_self setValue:[NSNumber numberWithUnsignedLongLong:0] forKey:pName];
                    }else if ([code isEqualToString:@"f"]){
                        [_self setValue:[NSNumber numberWithFloat:0.0] forKey:pName];
                    }else if ([code isEqualToString:@"d"]){
                        [_self setValue:[NSNumber numberWithDouble:0.0] forKey:pName];
                    }else if ([code isEqualToString:@"B"]){
                        [_self setValue:[NSNumber numberWithBool:NO] forKey:pName];
                    }
                    
                    stop = YES; break;
                }
                
                free(properties);
                clazz = class_getSuperclass(clazz);
            }
        }
        
        --count;
        
        goto CALL_FOR;
    };
}

- (NSObject *(^)(id))objAdd
{
    return ^id(id obj){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objAdd , obj)
        
        //NSNull means not to check
        NSArray* infos = @[
                          @[LB_SELAsString(addObject:),NSNull.class],
                          @[LB_SELAsString(addEntriesFromDictionary:),NSDictionary.class],
                          @[LB_SELAsString(appendAttributedString:),NSAttributedString.class],
                          @[LB_SELAsString(addSubview:),UIView.class],
                          @[LB_SELAsString(addSublayer:),CALayer.class],
                          @[LB_SELAsString(appendData:),NSData.class],
                          @[LB_SELAsString(appendPath:),UIBezierPath.class],
                          @[LB_SELAsString(addIndex:),NSNumber.class],
                        ];
        SEL sel;    Class clazzNeed;
        
        
        if ([_self isKindOfClass:[NSString class]]){
            
            if(!_self.objIsMutable()){
                _self = [_self mutableCopy];
            }
            _self.strAppend(obj);
            
            goto CALL_RET;
        }
        
        for (int i=0; i<infos.count; i++) {
            
            sel = NSSelectorFromString(infos[i][0]);
            clazzNeed = infos[i][1];
            
            if([_self respondsToSelector:sel]){
                
                if(clazzNeed == NSNull.class    ||
                   [obj isKindOfClass:clazzNeed]){
                    
                    _LB_performSelector1(_self, sel, obj);
                }
                goto CALL_RET;
            }
        }
        
    CALL_RET:
        
        return _self;
    };
}

- (NSObject *(^)(id))objAddTo
{
    return ^id(id obj){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objAddTo , obj)
        
        if(!obj) return _self;
        
        //NSNull means not to check
        NSArray* infos = @[
                           @[LB_SELAsString(addObject:),NSNull.class],
                           @[LB_SELAsString(addEntriesFromDictionary:),NSDictionary.class],
                           @[LB_SELAsString(appendAttributedString:),NSAttributedString.class],
                           @[LB_SELAsString(addSubview:),UIView.class],
                           @[LB_SELAsString(addSublayer:),CALayer.class],
                           @[LB_SELAsString(appendData:),NSData.class],
                           @[LB_SELAsString(appendPath:),UIBezierPath.class],
                           @[LB_SELAsString(addIndex:),NSNumber.class],
                           ];
        SEL sel;    Class clazzNeed;
        
        
        if ([obj respondsToSelector:@selector(appendString:)]){
            
            if([obj objIsMutable]())
                [obj appendString:_self];
            goto CALL_RET;
        }
        
        for (int i=0; i<infos.count; i++) {
            
            sel = NSSelectorFromString(infos[i][0]);
            clazzNeed = infos[i][1];
            
            if([obj respondsToSelector:sel]){
                
                if(clazzNeed == NSNull.class    ||
                   [_self isKindOfClass:clazzNeed]){
                    
                    _LB_performSelector1(obj, sel, _self);
                }
                goto CALL_RET;
            }
        }
        
    CALL_RET:
        
        return _self;
    };
}

- (NSObject *(^)(id))objAddToAsWhatSet
{
    return ^id(id obj){
        
        if(!obj) return NSNull.null;
        
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objAddToAsWhatSet , obj)
        
        self.objAddTo(obj);
        return linkObj(obj);
    };
}

- (NSObject *(^)(id, NSUInteger))objInsert
{
    return ^id(id obj , NSUInteger idx){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objInsert , obj , idx)
        
        if(!obj) return _self;
        
        //NSNull means not to check
        NSArray* infos = @[
                           @[LB_SELAsString(insertObject:atIndex:),NSNull.class],
                           @[LB_SELAsString(insertSubview:atIndex:),UIView.class],
                           @[LB_SELAsString(insertSublayer:atIndex:),CALayer.class],
                           ];
        SEL sel;    Class clazzNeed;
        
        
        if([_self isKindOfClass:NSString.class]){
            
            if(!_self.strIsMutableAs().boolValue)
                _self = _self.mutableCopy;
            
            [_self insertString:obj atIndex:idx];
            goto CALL_RET;
        }
        
        for (int i=0; i<infos.count; i++) {
            
            sel = NSSelectorFromString(infos[i][0]);
            clazzNeed = infos[i][1];
            
            if([_self respondsToSelector:sel]){
                
                if(clazzNeed == NSNull.class    ||
                   [obj isKindOfClass:clazzNeed]){
                    
                    _LB_performSelector1(_self, sel, obj);
                }
                goto CALL_RET;
            }
        }
        
    CALL_RET:
        
        return _self;
    };
}

- (NSObject *(^)(id, NSUInteger))objInsertTo
{
    return ^id(id obj , NSUInteger idx){
        
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objInsertTo , obj , idx)
        
        if(!obj) return _self;
        
        //NSNull means not to check
        NSArray* infos = @[
                           @[LB_SELAsString(insertObject:atIndex:),NSNull.class],
                           @[LB_SELAsString(insertSubview:atIndex:),UIView.class],
                           @[LB_SELAsString(insertSublayer:atIndex:),CALayer.class],
                           ];
        SEL sel;    Class clazzNeed;
        
        
        if([obj isKindOfClass:NSString.class]){
            
            if([obj objIsMutable]())
                [_self insertString:obj atIndex:idx];
            goto CALL_RET;
        }
        
        for (int i=0; i<infos.count; i++) {
            
            sel = NSSelectorFromString(infos[i][0]);
            clazzNeed = infos[i][1];
            
            if([obj respondsToSelector:sel]){
                
                if(clazzNeed == NSNull.class    ||
                   [_self isKindOfClass:clazzNeed]){
                    
                    _LB_performSelector1(obj, sel, _self);
                }
                goto CALL_RET;
            }
        }
        
    CALL_RET:
        
        return _self;
    };
}

- (NSObject *(^)(id, NSUInteger))objInsertToAsWhatSet
{
    return ^id(id obj , NSUInteger idx){
        
        if(!obj) return NSNull.null;
        
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objInsertToAsWhatSet , obj , idx)
        
        self.objInsertTo(obj, idx);
        return linkObj(obj);
    };
}

- (NSObject *(^)(void))objRemoveAll
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objRemoveAll)
        
        //NSNull means not to check
        NSArray* infos = @[
                           LB_SELAsString(removeAllObjects),
                           LB_SELAsString(removeAllIndexes),
                           LB_SELAsString(removeAllPoints),
                           LB_SELAsString(removeAllSegments),
                           ];
        
        SEL sel;
        for (int i=0; i<infos.count; i++) {
            
            sel = NSSelectorFromString(infos[i]);
            
            if([_self respondsToSelector:sel]){
                
                _LB_performSelector(_self, sel);
                goto CALL_RET;
            }
        }
        
        
        if([_self respondsToSelector:@selector(setText:)]){
            
            [_self setText:@""];
        }else if ([_self isKindOfClass:[NSString class]]){
            
            if([_self objIsMutable]()){
                
                [_self setString:@""];
            }else{
                
                _self = @"";
            }
        }else if ([_self isKindOfClass:[UIView class]]){
            
            [[_self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        }else if ([_self isKindOfClass:[CALayer class]]){
            
            [[_self sublayers] makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        }
        
    CALL_RET:
        
        return _self;
    };
}

- (NSNumber *(^)(void))objLengthAs
{
    return ^id(void){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objLengthAs)
        
        if([_self respondsToSelector:@selector(count)]){
            return @([(id)_self count]);
        }
        
        if([_self respondsToSelector:@selector(length)]){
            return @([(id)_self length]);
        }
        
        return @(NSNotFound);
    };
}
- (NSUInteger (^)(void))objLength
{
    return ^NSUInteger(void){
        return self.objLengthAs().unsignedIntegerValue;
    };
}
- (NSUInteger (^)(void))objCount
{
    return self.objLength;
}

- (NSObject<NSFastEnumeration> *(^)(NSString *, BOOL))objsSortByKey
{
    return ^id(NSString* key,BOOL ascending){
        
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objsSortByKey,key,ascending)
        
        NSSortDescriptor* sort = [NSSortDescriptor sortDescriptorWithKey:key ascending:ascending];
        
        if([_self respondsToSelector:@selector(sortUsingDescriptors:)]){
            [_self sortUsingDescriptors:@[sort]];
        }else if ([_self respondsToSelector:@selector(sortedArrayUsingDescriptors:)]){
            return [_self sortedArrayUsingDescriptors:@[sort]];
        }
        return _self;
    };
}
- (NSObject<NSFastEnumeration> *(^)(NSString *))objsSortByKeyAscending
{
    return ^id(NSString* key){
        
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objsSortByKeyAscending,key)
        
        NSSortDescriptor* sort = [NSSortDescriptor sortDescriptorWithKey:key ascending:YES];
        
        if([_self respondsToSelector:@selector(sortUsingDescriptors:)]){
            [_self sortUsingDescriptors:@[sort]];
        }else if ([_self respondsToSelector:@selector(sortedArrayUsingDescriptors:)]){
            return [_self sortedArrayUsingDescriptors:@[sort]];
        }
        return _self;
    };
}
- (NSObject<NSFastEnumeration> *(^)(NSString *))objsSortByKeyDescending
{
    return ^id(NSString* key){
        
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objsSortByKeyDescending,key)
        
        NSSortDescriptor* sort = [NSSortDescriptor sortDescriptorWithKey:key ascending:NO];
        
        if([_self respondsToSelector:@selector(sortUsingDescriptors:)]){
            [_self sortUsingDescriptors:@[sort]];
        }else if ([_self respondsToSelector:@selector(sortedArrayUsingDescriptors:)]){
            return [_self sortedArrayUsingDescriptors:@[sort]];
        }
        return _self;
    };
}

- (NSObject<NSFastEnumeration> *(^)(NSPredicate *))objsFilterByPredicate
{
    return ^id(NSPredicate* pred){
        
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objsFilterByPredicate,pred)
        
        if([_self respondsToSelector:@selector(filterUsingPredicate:)]){
            [_self filterUsingPredicate:pred];
        }else if([_self respondsToSelector:@selector(filteredArrayUsingPredicate:)]){
            return [_self filteredArrayUsingPredicate:pred];
        }else if([_self respondsToSelector:@selector(filteredSetUsingPredicate:)]){
            return [_self filteredSetUsingPredicate:pred];
        }else if([_self respondsToSelector:@selector(filteredOrderedSetUsingPredicate:)]){
            return [_self filteredOrderedSetUsingPredicate:pred];
        }
        return _self;
    };
}

- (NSObject<NSFastEnumeration> *(^)(NSPredicate *))objsSelectByPredicate
{
    return ^id(NSPredicate* pred){
        
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objsFilterByPredicate,pred)
        
        if([_self respondsToSelector:@selector(filterUsingPredicate:)]){
            _self = _self.copy;
        }
        if([_self respondsToSelector:@selector(filteredArrayUsingPredicate:)]){
            return [_self filteredArrayUsingPredicate:pred];
        }else if([_self respondsToSelector:@selector(filteredSetUsingPredicate:)]){
            return [_self filteredSetUsingPredicate:pred];
        }else if([_self respondsToSelector:@selector(filteredOrderedSetUsingPredicate:)]){
            return [_self filteredOrderedSetUsingPredicate:pred];
        }
        return _self;
    };
}

- (NSObject<NSFastEnumeration> *(^)(NSString *))objsSelectByPredicateString
{
    return ^id(NSString* predString){
        
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objsSelectByPredicateString,predString)
        
        if([_self respondsToSelector:@selector(filterUsingPredicate:)]){
            _self = _self.copy;
        }
        NSPredicate* pred = [NSPredicate predicateWithFormat:predString];
        if([_self respondsToSelector:@selector(filteredArrayUsingPredicate:)]){
            return [_self filteredArrayUsingPredicate:pred];
        }else if([_self respondsToSelector:@selector(filteredSetUsingPredicate:)]){
            return [_self filteredSetUsingPredicate:pred];
        }else if([_self respondsToSelector:@selector(filteredOrderedSetUsingPredicate:)]){
            return [_self filteredOrderedSetUsingPredicate:pred];
        }
        return _self;
    };
}

- (NSObject *(^)(id))objsAddItem
{
    return ^id(id obj){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objsAddItem,obj)
        
        if(LB_RespondsToSEL(_self, addObject:)){
            [_self addObject:obj];
        }
        return _self;
    };
}
- (NSObject *(^)(void))objsRemoveAllItem
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objsRemoveAllItem)
        
        if(LB_RespondsToSEL(_self, removeAllObjects)){
            [_self removeAllObjects];
        }else if(LB_RespondsToSEL(_self, removeAllIndexes)){
            [_self removeAllIndexes];
        }
        return _self;
    };
}

- (NSObject *(^)(NSUInteger))objsItemAt
{
    return ^id(NSUInteger idx){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objsItemAt,idx)
        
        if(LB_RespondsToSEL(_self, objectAtIndex:)){
            return [_self objectAtIndex:idx];
        }
        else if(LB_RespondsToSEL(_self, indexAtPosition:)){
            return @([_self indexAtPosition:idx]);
        }
        
        return NSNull.null;
    };
}
- (NSNumber *(^)(id))objsIndexOfItemAs
{
    return ^id(id item){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objsIndexOfItemAs,item)
        
        if(LB_RespondsToSEL(_self, indexOfObject:)){
            return @([_self indexOfObject:item]);
        }
        return @(NSNotFound);
    };
}

- (NSObject *(^)(void))objsLastItem
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objsLastItem)
        
        if(LB_RespondsToSEL(_self, lastObject)){
            return [_self lastObject];
        }
        return NSNull.null;
    };
}
- (NSObject *(^)(void))objsFirstItem
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objsFirstItem)
        
        if(LB_RespondsToSEL(_self, firstObject)){
            [_self firstObject];
        }
        return NSNull.null;
    };
}
-(NSObject *(^)(id))objsItemForKey
{
    return ^id(id key){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objsItemForKey,key)
        
        if(LB_RespondsToSEL(_self, objectForKey:)){
            return [_self objectForKey:key];
        }
        return NSNull.null;
    };
}
- (NSObject *(^)(id, id))objsSetItemForKey
{
    return ^id(id item,id key){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objsSetItemForKey,item,key)
        
        if(LB_RespondsToSEL(_self, setObject:forKey:)){
            [_self setObject:item forKey:key];
        }
        return _self;
    };
}

- (NSObject *(^)(NSString *))objValueForFullPath
{
    return ^id(NSString* fullPath){
        
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objValueForFullPath,fullPath)
        
        if(!fullPath){
            
        CALL_RET_NSNULL:
            
            return NSNull.null;
        }
        
        if(![fullPath containsString:@"->"]){
            
        CALL_RET_NORMAL_KVC:
            ///Are you confusing '.' and '->'?
            return linkObjNotNil([_self valueForKeyPath:fullPath]);
        }
        
        ///separete struct path from full path
        NSUInteger opIdx = [fullPath rangeOfString:@"->"].location;
        NSString* keyPath = [fullPath substringToIndex:opIdx];
        if(opIdx + 1 == fullPath.length-1) goto CALL_RET_NORMAL_KVC;//wrong struct path like @"...->"
        NSString* structPath = [fullPath substringFromIndex:opIdx+2];
        
        
        NSValue* keyPathValue = [self valueForKeyPath:keyPath];
        if(![keyPathValue isKindOfClass:NSValue.class]) goto CALL_RET_NSNULL;//wrong keypath befor structPath
        
        ///Adjust oprator : @"->" => @"."
        structPath = [structPath stringByReplacingOccurrencesOfString:@"->" withString:@"."];
        return keyPathValue.valueStructValueForKeyPath(structPath);
    };
}

- (NSObject *(^)(id, NSString *))objSetValueForFullPath
{
    return ^id(id value , NSString* fullPath){
        
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objSetValueForFullPath,value,fullPath)
        
        if(!fullPath){
            
            return _self;
        }
        
        if(![fullPath containsString:@"->"]){
            
            if([_self isKindOfClass:NSValue.class]){
                
                if(_self.valueIsStructAs().boolValue){
                    return _self.valueStructSetValueForKeyPath(value, fullPath);
                }
            }else{
                
                ///Are you confusing '.' and '->'?
                [_self setValue:value forKeyPath:fullPath];
            }

            return _self;
        }
        
        ///separete struct path from full path
        NSUInteger opIdx = [fullPath rangeOfString:@"->"].location;
        NSString* keyPath = [fullPath substringToIndex:opIdx];
        if(opIdx + 1 == fullPath.length-1) return _self;//wrong struct path like @"...->"
        NSString* structPath = [fullPath substringFromIndex:opIdx+2];
        
        ///Find new value
        NSValue* keyPathValue = [self valueForKeyPath:keyPath];
        if(![keyPathValue isKindOfClass:NSValue.class]) return _self;//wrong
        ///Adjust oprator : @"->" => @"."
        structPath = [structPath stringByReplacingOccurrencesOfString:@"->" withString:@"."];
        NSValue* newKeyPathValue = keyPathValue.valueStructSetValueForKeyPath(value,structPath);
        [_self setValue:newKeyPathValue forKeyPath:keyPath];
        return _self;
    };
}

- (NSObject *(^)(id, NSString*))objSetValueForRegexKey
{
    return ^id(id value, NSString* regexKey){
        
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objSetValueForRegexKey, value ,regexKey)
        
        [self _lb_setValue:value forKey:regexKey option:NSRegularExpressionSearch];
        return _self;
    };
}
- (NSObject *(^)(id, NSString *))objSetValueForSubkey
{
    return ^id(id value, NSString* subkey){
        
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objSetValueForRegexKey, value ,subkey)
        
        [self _lb_setValue:value forKey:subkey option:NSCaseInsensitiveSearch];
        return _self;
    };
}

- (void)_lb_setValue:(id)value forKey:(NSString*)key option:(NSStringCompareOptions)option
{
    __block objc_property_t* properties;
    @try {
        
        [self.class lb_classEnumerateUsingBlock:^(Class clazz, BOOL *stop) {
            
            unsigned int outCount, i;
            properties = class_copyPropertyList(clazz, &outCount);
            for(i=0 ; i< outCount; i++){
                
                NSString* pName = @(property_getName(properties[i]));
                
                if(![pName rangeOfString:key options:option].length) continue;
                
                NSString *attrs = @(property_getAttributes(properties[i]));
                NSUInteger dotLoc = [attrs rangeOfString:@","].location;
                NSArray* attrInfos = [attrs componentsSeparatedByString:@","];
                NSString *code = nil;
                NSUInteger loc = 1;
                if (dotLoc == NSNotFound) { // 没有
                    code = [attrs substringFromIndex:loc];
                } else {
                    code = [attrs substringWithRange:NSMakeRange(loc, dotLoc - loc)];
                }
                
                if([attrInfos containsObject:@"R"]){
                    //只读属性
                    continue;
                }else if (![[attrInfos.lastObject substringToIndex:1] isEqualToString:@"V"]){
                    //无值
                    continue;
                }
                
                //KVCDisabled
                if (code.length == 0) {
                    continue;
                }else if (
                          [code isEqualToString:@":"] ||//SEL
                          [code isEqualToString:@"^{objc_ivar=}"] ||//ivar
                          [code isEqualToString:@"^{objc_method=}"]//Method
                          ) {
                    continue;
                }
                
                [self setValue:value forKey:pName];
            }
            free(properties);
        } includeBasic:NO];
        
    } @catch (NSException *exception) {
        
        free(properties);
        NSLog(@"Error from :%s;NSException=%@;",__func__,[exception description]);
    }
}

- (NSNumber *(^)(id<NSFastEnumeration>))objEachValueIsTrueForKeyPathsAs
{
    return ^id(id keyPaths){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objEachValueIsTrueForKeyPathsAs,keyPaths)
        
        if(![keyPaths conformsToProtocol:@protocol(NSFastEnumeration)])
            return @NO;
        
        for (id keyPath in keyPaths) {
            
            if([[_self valueForKeyPath:keyPath] boolValue]) continue;
            return @NO;
        }
        return @YES;
    };
}
- (NSNumber *(^)(id<NSFastEnumeration>))objSomeValueIsTrueForKeyPathsAs
{
    return ^id(id keyPaths){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objSomeValueIsTrueForKeyPathsAs,keyPaths)
        
        if(![keyPaths conformsToProtocol:@protocol(NSFastEnumeration)])
            return @NO;
        
        for (id keyPath in keyPaths) {
            
            if([[_self valueForKeyPath:keyPath] boolValue]) return @YES;
        }
        return @NO;
    };
}

- (BOOL (^)(void))objIsBlank
{
    
    if ([self isKindOfClass:[NSString class]]){
        return self.strIsBlank;
    }
    
    if([self isKindOfClass:[NSValue class]]){
        return self.valueIsBlank;
    }
    
    return ^BOOL(){
        LinkHandle_VAL_IFNOT(NSObject)
        LinkGroupHandle_VAL(objIsBlank)
        //collection
        if([self isKindOfClass:[NSMutableArray class]] ||
           [self isKindOfClass:[NSMutableDictionary class]] ||
           [self isKindOfClass:[NSMutableSet class]] ||
           [self isKindOfClass:[NSHashTable class]] ||
           [self isKindOfClass:[NSMutableOrderedSet class]] ||
           [self isKindOfClass:[NSMapTable class]]){
            
            return [_self count];
        }else if ([self isKindOfClass:[UIView class]]){
            
            return [_self subviews].count;
        }else if ([self isKindOfClass:[CALayer class]]){
            
            return [_self sublayers].count;
        }
        
        //customer`s model
        //Obj⊆NSObject || Obj⊆...⊆NSObject
        if(self.superclass == [NSObject class] || ![self.class lb_classIsBasic]){
            
            unsigned int outCount, i;
            objc_property_t* properties = class_copyPropertyList([self class], &outCount);
            
            for(i=0 ; i< outCount; i++){
                
                NSString* pName = @(property_getName(properties[i]));
                NSString *attrs = @(property_getAttributes(properties[i]));
                NSUInteger dotLoc = [attrs rangeOfString:@","].location;
                NSArray* attrInfos = [attrs componentsSeparatedByString:@","];
                NSString *code = nil;
                NSUInteger loc = 1;
                if (dotLoc == NSNotFound) { // 没有
                    code = [attrs substringFromIndex:loc];
                } else {
                    code = [attrs substringWithRange:NSMakeRange(loc, dotLoc - loc)];
                }
                
                if([attrInfos containsObject:@"R"]){//readonly
                    continue;
                }
                else if (![[attrInfos.lastObject substringToIndex:1] isEqualToString:@"V"]){//void
                    continue;
                }
                
                if ([code isEqualToString:@"@"]) {//id对象
                    
                    if([self valueForKey:pName]) goto CALL_RETURN_NO;
                    continue;
                } else if (code.length == 0) {
                    //KVCDisabled
                    continue;
                } else if (code.length > 3 && [code hasPrefix:@"@\""]) {//对象
                    
                    if([self valueForKey:pName]) goto CALL_RETURN_NO;
                    continue;
                } else if ([code isEqualToString:@":"] ||//SEL
                           [code isEqualToString:@"^{objc_ivar=}"] ||//ivar
                           [code isEqualToString:@"^{objc_method=}"] ||//Method
                           [code isEqualToString:@"@?"]) {//block
                    //KVCDisabled
                    continue;
                }
                else if([code isEqualToString:@(@encode(CGRect))]){
                    CGRect val = [[self valueForKey:pName] CGRectValue];
                    if(!CGRectEqualToRect(val, CGRectZero)) goto CALL_RETURN_NO;
                    continue;
                }else if([code isEqualToString:@(@encode(CGPoint))]){
                    CGPoint val = [[self valueForKey:pName] CGPointValue];
                    if(!CGPointEqualToPoint(val, CGPointZero)) goto CALL_RETURN_NO;
                    continue;
                }else if([code isEqualToString:@(@encode(CGSize))]){
                    CGSize val = [[self valueForKey:pName] CGSizeValue];
                    if(!CGSizeEqualToSize(val, CGSizeZero)) goto CALL_RETURN_NO;
                    continue;
                }else if([code isEqualToString:@(@encode(NSRange))]){
                    NSRange val = [[self valueForKey:pName] rangeValue];
                    if(!NSEqualRanges(val, NSMakeRange(0, 0))) goto CALL_RETURN_NO;
                    continue;
                }else if([code isEqualToString:@(@encode(UIEdgeInsets))]){
                    UIEdgeInsets val = [[self valueForKey:pName] UIEdgeInsetsValue];
                    if(!UIEdgeInsetsEqualToEdgeInsets(val, UIEdgeInsetsZero)) goto CALL_RETURN_NO;
                    continue;
                }else if([code isEqualToString:@(@encode(UIOffset))]){
                    UIOffset val = [[self valueForKey:pName] UIOffsetValue];
                    if(!UIOffsetEqualToOffset(val, UIOffsetZero)) goto CALL_RETURN_NO;
                    continue;
                }else if([code isEqualToString:@(@encode(CGVector))]){
                    CGVector val = [[self valueForKey:pName] CGVectorValue];
                    if(val.dx==0.0 && val.dy==0.0) goto CALL_RETURN_NO;
                    continue;
                }
                
                // 是否为数字类型
                NSString *lowerCode = code.lowercaseString;
                NSArray *numberTypes = @[@"i", @"s", @"c", @"b", @"f", @"d", @"l", @"q", @"c"];
                if ([numberTypes containsObject:lowerCode]) {
                    
                    NSNumber* number = [self valueForKey:pName];
                    if(![NSDecimalNumber.zero isEqualToNumber:number])
                        goto CALL_RETURN_NO;
                    continue;

                }
            }//for_end
            
            
            free(properties);
            return YES;
            
            CALL_RETURN_NO:
            free(properties);
                return NO;
        }
        
        return NO;
    };
}

- (NSObject *(^)(id))objRemove
{
    return ^id(id obj){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objRemove , obj)
        
        if([_self respondsToSelector:@selector(removeObject:)]){
            
            [_self removeObject:obj];
        }else if ([_self isKindOfClass:[NSString class]] &&
                  [obj isKindOfClass:[NSString class]]){
            
            if(!_self.objIsMutable()){
                
                _self = [_self mutableCopy];
            }
            
            [_self replaceOccurrencesOfString:obj
                                   withString:@""
                                      options:0
                                        range:NSMakeRange(0, [_self length])];
        }else if ([self isKindOfClass:[UIView class]] &&
                  [obj isKindOfClass:[UIView class]]){
            
            if([obj superview] == _self){
                
                [obj removeFromSuperview];
            }
        }else if ([self isKindOfClass:[CALayer class]] &&
                  [obj isKindOfClass:[CALayer class]]){
            
            if( [obj superlayer] == _self){
                
                [obj removeFromSuperlayer];
            }
        }else if ([self isKindOfClass:[NSMutableDictionary class]]){
            
            [_self removeObjectForKey:obj];
        }else if([_self respondsToSelector:@selector(removeFromParentViewController)]){
            
            if([[obj parentViewController] isEqual:_self]){
                [obj removeFromParentViewController];
            }
        }else if([_self respondsToSelector:@selector(removeIndex:)]){
            
            if([obj isKindOfClass:NSNumber.class]){
                
                [_self removeIndex:[obj unsignedIntegerValue]];
            }
        }
        
        return _self;
    };
}

- (NSObject *(^)(id))objRemoveFrom
{
    return ^id(id obj){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objRemoveFrom , obj)
        if(NSEqualNil(obj)) return _self;
        
        if([obj respondsToSelector:@selector(removeObject:)]){
            
            [obj removeObject:_self];
        }else if ([_self isKindOfClass:[NSString class]] &&
                  [obj objIsMutable]()){
            
            [obj replaceOccurrencesOfString:_self
                                 withString:@""
                                    options:0
                                      range:NSMakeRange(0, [obj length])];
        }else if ([_self respondsToSelector:@selector(removeFromSuperview)]){
            
            if([_self superview] == obj){
                
                [_self removeFromSuperview];
            }
        }else if ([_self respondsToSelector:@selector(removeFromSuperlayer)]){
            
            if([_self superlayer] == obj){
                
                [_self removeFromSuperlayer];
            }
        }else if ([obj respondsToSelector:@selector(removeObjectForKey:)]){
            
            [obj removeObjectForKey:_self];
        }else if ([obj respondsToSelector:@selector(removeFromParentViewController)]){
            
            if([_self parentViewController] == obj){
                [_self removeFromParentViewController];
            }
        }
        else if ([obj respondsToSelector:@selector(removeIndex:)]){
            
            if([_self isKindOfClass:NSNumber.class]){
                [obj removeIndex:[_self unsignedIntegerValue]];
            }
        }
        
        return _self;
    };
}

- (NSObject *(^)(id))objRemoveFromAsWhatSet
{
    return ^id(id obj){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objRemoveFromAsWhatSet , obj)
        
        if([obj isKindOfClass:[NSMutableArray class]] ||
           [obj isKindOfClass:[NSMutableSet class]] ||
           [obj isKindOfClass:[NSHashTable class]] ||
           [obj isKindOfClass:[NSMutableOrderedSet class]]){
            
            [obj removeObject:_self];
        }else if ([self isKindOfClass:[NSString class]] &&
                  [obj isKindOfClass:[NSString class]]){
            
            if(![obj objIsMutable]()){
                
                obj = [obj mutableCopy];
            }
            [obj replaceOccurrencesOfString:_self
                                 withString:@""
                                    options:0
                                      range:NSMakeRange(0, [obj length])];
        }else if ([self isKindOfClass:[UIView class]] &&
                  [obj isKindOfClass:[UIView class]]){
            
            if([_self superview] == obj){
                
                [_self removeFromSuperview];
            }
        }else if ([self isKindOfClass:[CALayer class]] &&
                  [obj isKindOfClass:[CALayer class]]){
            
            if([_self superlayer] == obj){
                
                [_self removeFromSuperlayer];
            }
        }else if ([obj isKindOfClass:[NSMutableDictionary class]]){
            
            [obj removeObjectForKey:_self];
        }
        
        return linkObj(obj);
    };
}

- (NSObject *(^)(void))objCopy
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objCopy)
        return _self.copy;
    };
}

- (NSObject *(^)(void))objMutableCopy
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objMutableCopy)
        return _self.mutableCopy;
    };
}

- (NSObject *(^)(void))objNeedMutable
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objNeedMutable)
        
        if([_self conformsToProtocol:@protocol(NSMutableCopying)] &&
           [_self copy] == _self){
            
            return [_self mutableCopy];
        }
        return _self;
    };
}

- (NSObject *(^)(void))objCopyByArchive
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objCopyByArchive)
        if(![self conformsToProtocol:@protocol(NSCoding)]){
            return [[LinkError errorWithCustomDescription:[NSString stringWithFormat:@"%@必须实现NSCoding协议",_self]] logError];
        }
        NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:self];
        return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
    };
}

- (BOOL (^)(void))objIsMutable
{
    return ^BOOL(){
        return self.objIsMutableAs().boolValue;
    };
}
- (NSNumber *(^)(void))objIsMutableAs
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objIsMutableAs)
        return @([_self copy] != _self);
    };
}

#ifndef DefineKindOfClassAs
#define DefineKindOfClassAs(className) \
- (NSNumber* (^)(void))objIsKindOf##className##As\
{\
    return ^id(){\
        LinkHandle_REF(NSObject)\
        LinkGroupHandle_REF(objIsKindOf##className##As)\
        return @([_self isKindOfClass:[className class]]);\
    };\
}
#endif

DefineKindOfClassAs(NSString)
DefineKindOfClassAs(NSArray)
DefineKindOfClassAs(NSDictionary)
DefineKindOfClassAs(UIView)
DefineKindOfClassAs(NSValue)
DefineKindOfClassAs(NSNumber)

- (NSNumber *(^)(void))objIsNumberAs
{
    if([self isKindOfClass:[NSString class]]){
        return self.strIsNumberAs;
    }
    
    return self.valueIsNumberAs;
}

- (NSObject *(^)(void))objMutableCopyEnumerate
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objMutableCopyEnumerate)
        
        //not collection and immutable object
        if(![_self conformsToProtocol:@protocol(NSMutableCopying)] &&
           ![_self conformsToProtocol:@protocol(NSFastEnumeration)])
            return _self;
        
        BOOL isImmutable = !_self.objIsMutable();
        
        //mutable enable and single.(NSString,NSURLRequest,NSAttributeString...)
        if(![_self conformsToProtocol:@protocol(NSFastEnumeration)]){
            
            return isImmutable?[_self mutableCopy]:_self;
        }
        
        //collection that content can be modified
        if(![_self conformsToProtocol:@protocol(NSMutableCopying)]){
            
            id collection = _self;
            if([collection isKindOfClass:[NSMapTable class]]){
                
                id content = [collection dictionaryRepresentation].objMutableCopyEnumerate();
                [collection removeAllObjects];
                [content enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    [collection setObject:obj forKey:key];
                }];
            }else if([collection isKindOfClass:[NSHashTable class]]){
                
                id content = [collection allObjects];
                [collection removeAllObjects];
                [content enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    [collection addObject:obj];
                }];
            }
            
            //unknown
            return collection;
        }
        
        id mutableSelf = isImmutable?[_self mutableCopy]:_self;
        if ([_self isKindOfClass:[NSArray class]] ||
            [_self isKindOfClass:[NSSet class]] ||
            [_self isKindOfClass:[NSOrderedSet class]]){
            
            //content can from array
            NSMutableArray* content = NSMutableArrayNew;
            [((id)_self) enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
                
                [content addObject:[obj objNeedMutable]()];
            }];
            [mutableSelf removeAllObjects];//hold *
            [mutableSelf addObjectsFromArray:content];
            
        }else if ([_self isKindOfClass:[NSDictionary class]]){
            
            //immutable dictionary
            NSMutableDictionary* content = NSMutableDictionaryNew;
            [(id)_self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL * stop) {
                
                [content setObject:[obj objNeedMutable]() forKey:key];
            }];
            [mutableSelf removeAllObjects];
            [mutableSelf addEntriesFromDictionary:content];
        }
        
        return mutableSelf;
    };
}

- (NSNumber *(^)(void))objIsCollectionAs
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objIsCollectionAs)
        
        if([_self conformsToProtocol:@protocol(NSFastEnumeration)]) return @YES;
        if([_self isKindOfClass:NSIndexSet.class]) return @YES;
        if([_self isKindOfClass:NSIndexPath.class]) return @YES;
        return @NO;
    };
}

- (NSNumber *(^)(void))objIsIndexableAs
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objIsIndexableAs)
        
        if(LB_RespondsToSEL(_self, objectAtIndex:)) return @YES;
        if(LB_RespondsToSEL(_self, characterAtIndex:)) return @YES;
        if(LB_RespondsToSEL(_self, indexAtPosition:)) return @YES;
        if(LB_RespondsToSEL(_self, pointerAtIndex:)) return @YES;
        if(LB_RespondsToSEL(_self, resultAtIndex:)) return @YES;
        if(LB_RespondsToSEL(_self, rangeAtIndex:)) return @YES;
        if(LB_RespondsToSEL(_self, valueAtIndex:)) return @YES;
        if(LB_RespondsToSEL(_self, glyphAtIndex:)) return @YES;
        return @NO;
    };
}

- (NSNumber *(^)(void))objIsKeyableAs
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objIsIndexableAs)
        
        if(LB_RespondsToSEL(_self, objectForKey:)) return @YES;
        if(LB_RespondsToSEL(_self, propertyForKey:)) return @YES;
        return @NO;
    };
}

- (NSNumber *(^)(void))objIsDictionaryableAs
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objIsDictionaryableAs)
        
        if(LB_IsKindOfClass(_self, NSDictionary)) return @YES;
        if(LB_RespondsToSEL(_self, dictionaryRepresentation)) return @YES;
        return @NO;
    };
}

- (NSNumber *(^)(void))objIsArrayableAs
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objIsArrayableAs)
        
        if(LB_IsKindOfClass(_self, NSArray)) return @YES;
        if(LB_RespondsToSEL(_self, allObjects)) return @YES;
        if(LB_RespondsToSEL(_self, array)) return @YES;
        return @NO;
    };
}

- (BOOL (^)(void))objIsNSNull
{
    return ^BOOL(){
        return self.objIsNSNullAs().boolValue;
    };
}
- (NSNumber *(^)(void))objIsNSNullAs
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objIsNSNullAs)
        return @(self == [NSNull null]);
    };
}

- (BOOL (^)(id))objIsEqual
{
    return ^BOOL(id obj){
        return self.objIsEqualAs(obj).boolValue;
    };
}

- (NSNumber *(^)(id))objIsEqualAs
{
    return ^id(id obj){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objIsEqualAs,obj)
        
        return [NSNumber numberWithBool:[_self isEqual:obj]];
        
//        BOOL (^blockCompare)(id obj1, id obj2);
//        if([_self isKindOfClass:[NSString class]]){
//            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToString:obj2];};
//        }else if ([_self isKindOfClass:[NSNumber class]]){
//            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToNumber:obj2];};
//        }else if ([_self isKindOfClass:[NSValue class]]){
//            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToValue:obj2];};
//        }else if ([_self isKindOfClass:[NSDate class]]){
//            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToDate:obj2];};
//        }else if ([_self isKindOfClass:[NSData class]]){
//            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToData:obj2];};
//        }else if ([_self isKindOfClass:[NSArray class]]){
//            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToArray:obj2];};
//        }else if ([_self isKindOfClass:[NSDictionary class]]){
//            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToDictionary:obj2];};
//        }else if ([_self isKindOfClass:[NSSet class]]){
//            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToSet:obj2];};
//        }else if ([_self isKindOfClass:[NSIndexSet class]]){
//            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToIndexSet:obj2];};
//        }else if ([_self isKindOfClass:[NSAttributedString class]]){
//            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToAttributedString:obj2];};
//        }else if ([_self isKindOfClass:[NSTimeZone class]]){
//            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToTimeZone:obj2];};
//        }else if ([_self isKindOfClass:[NSHashTable class]]){
//            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToHashTable:obj2];};
//        }else if ([_self isKindOfClass:[NSOrderedSet class]]){
//            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToOrderedSet:obj2];};
//        }else{
//            blockCompare = ^(id obj1, id obj2){return [obj1 isEqual:obj2];};
//        }
        
//        return @(blockCompare(_self,obj));
    };
}

- (BOOL (^)(id,...))objIsEqualToEach
{
    return ^(id obj ,...){
        LinkHandle_VAL_IFNOT(NSObject){
            return NO;
        }
        
        NSMutableArray* objs = [NSMutableArray new];
        [objs addObject:obj];
        va_list args;
        va_start(args, obj);
        id parmObj;
        
        while ((parmObj = va_arg(args, id) )) {
            [objs addObject:parmObj];
        }
        va_end(args);
        
        ///////////////////////
        //LinkGroupHandle_VAL
        if([self isKindOfClass:[LinkGroup class]]){
            LinkGroup* group = self.thisLinkObjs;
            return [group.linkObjects firstObject].objIsEqualToEachInArray(objs);
        }
        //LinkGroupHandle_VAL
        ///////////////////////
        
        return _self.objIsEqualToEachInArray(objs);
    };
}

- (NSNumber* (^)(id,...))objIsEqualToEachAs
{
    return ^id(id obj ,...){
        LinkHandle_REF(NSObject)
        
        NSMutableArray* objs = [NSMutableArray new];
        [objs addObject:obj];
        va_list args;
        va_start(args, obj);
        id parmObj;
        
        while ((parmObj = va_arg(args, id) )) {
            [objs addObject:parmObj];
        }
        va_end(args);
        
        ///////////////////////
        //LinkGroupHandle_VAL
        if([self isKindOfClass:[LinkGroup class]]){
            LinkGroup* group = self.thisLinkObjs;
            NSMutableArray* newObjs = [NSMutableArray new];
            [group.linkObjects enumerateObjectsUsingBlock:^(NSObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [newObjs addObject: @(obj.objIsEqualToEachInArray(objs))];
            }];
            group.linkObjects = newObjs;
            return group;
        }
        //LinkGroupHandle_VAL
        ///////////////////////
        
        return @(_self.objIsEqualToEachInArray(objs));
    };
}

- (BOOL (^)(NSArray *))objIsEqualToEachInArray
{
    return ^BOOL(NSArray * objs){
        return self.objIsEqualToEachInArrayAs(objs).boolValue;
    };
}

- (NSNumber *(^)(NSArray *))objIsEqualToEachInArrayAs
{
    return ^id(NSArray * objs){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objIsEqualToEachInArrayAs,objs)
        
        if(![objs isKindOfClass:[NSArray class]])
            return @(NO);
        
        BOOL (^blockCompare)(id obj1, id obj2);
        if([_self isKindOfClass:[NSString class]]){
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToString:obj2];};
        }else if ([_self isKindOfClass:[NSNumber class]]){
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToNumber:obj2];};
        }else if ([_self isKindOfClass:[NSValue class]]){
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToValue:obj2];};
        }else if ([_self isKindOfClass:[NSDate class]]){
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToDate:obj2];};
        }else if ([_self isKindOfClass:[NSData class]]){
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToData:obj2];};
        }else if ([_self isKindOfClass:[NSArray class]]){
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToArray:obj2];};
        }else if ([_self isKindOfClass:[NSDictionary class]]){
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToDictionary:obj2];};
        }else if ([_self isKindOfClass:[NSSet class]]){
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToSet:obj2];};
        }else if ([_self isKindOfClass:[NSIndexSet class]]){
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToIndexSet:obj2];};
        }else if ([_self isKindOfClass:[NSAttributedString class]]){
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToAttributedString:obj2];};
        }else if ([_self isKindOfClass:[NSTimeZone class]]){
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToTimeZone:obj2];};
        }else if ([_self isKindOfClass:[NSHashTable class]]){
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToHashTable:obj2];};
        }else if ([_self isKindOfClass:[NSOrderedSet class]]){
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToOrderedSet:obj2];};
        }else{
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqual:obj2];};
        }
        
        for (id obj in objs) {
            if(blockCompare(_self, obj)){
                return @NO;
            }
        }
        return @YES;
    };
}

- (BOOL (^)(id, ...))objIsEqualToSomeone
{
    return ^(id obj , ...){
        LinkHandle_VAL_IFNOT(NSObject){
            return NO;
        }
        NSMutableArray* objs = [NSMutableArray new];
        [objs addObject:obj];
        va_list args;
        va_start(args, obj);
        id parmObj;
        while ((parmObj = va_arg(args, id))) {
            [objs addObject:parmObj];
        }
        va_end(args);
        
        ///////////////////////
        //LinkGroupHandle_VAL
        if([self isKindOfClass:[LinkGroup class]]){
            LinkGroup* group = self.thisLinkObjs;
            return [group.linkObjects firstObject].objIsEqualToSomeoneInArray(objs);
        }
        //LinkGroupHandle_VAL
        ///////////////////////
        
        return _self.objIsEqualToSomeoneInArray(objs);
    };
}

- (NSNumber* (^)(id, ...))objIsEqualToSomeoneAs
{
    return ^id(id obj , ...){
        LinkHandle_REF(NSObject)
        NSMutableArray* objs = [NSMutableArray new];
        [objs addObject:obj];
        va_list args;
        va_start(args, obj);
        id parmObj;
        while ((parmObj = va_arg(args, id))) {
            [objs addObject:parmObj];
        }
        va_end(args);
        
        ///////////////////////
        //LinkGroupHandle_VAL
        if([self isKindOfClass:[LinkGroup class]]){
            LinkGroup* group = self.thisLinkObjs;
            NSMutableArray* newObjs = [NSMutableArray new];
            [group.linkObjects enumerateObjectsUsingBlock:^(NSObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [newObjs addObject: @(obj.objIsEqualToSomeoneInArray(objs))];
            }];
            group.linkObjects = newObjs;
            return group;
        }
        //LinkGroupHandle_VAL
        ///////////////////////
        
        return @(_self.objIsEqualToSomeoneInArray(objs));
    };
}

- (BOOL (^)(NSArray *))objIsEqualToSomeoneInArray
{
    return ^(NSArray * objs){
        return self.objIsEqualToSomeoneInArrayAs(objs).boolValue;
    };
}

- (NSNumber* (^)(NSArray *))objIsEqualToSomeoneInArrayAs
{
    return ^id(NSArray * objs){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objIsEqualToSomeoneInArrayAs,objs)
        
        if(![objs isKindOfClass:[NSArray class]])
            return @NO;
        
        BOOL (^blockCompare)(id obj1, id obj2);
        if([_self isKindOfClass:[NSString class]]){
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToString:obj2];};
        }else if ([_self isKindOfClass:[NSNumber class]]){
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToNumber:obj2];};
        }else if ([_self isKindOfClass:[NSValue class]]){
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToValue:obj2];};
        }else if ([_self isKindOfClass:[NSDate class]]){
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToDate:obj2];};
        }else if ([_self isKindOfClass:[NSData class]]){
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToData:obj2];};
        }else if ([_self isKindOfClass:[NSArray class]]){
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToArray:obj2];};
        }else if ([_self isKindOfClass:[NSDictionary class]]){
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToDictionary:obj2];};
        }else if ([_self isKindOfClass:[NSSet class]]){
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToSet:obj2];};
        }else if ([_self isKindOfClass:[NSIndexSet class]]){
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToIndexSet:obj2];};
        }else if ([_self isKindOfClass:[NSAttributedString class]]){
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToAttributedString:obj2];};
        }else if ([_self isKindOfClass:[NSTimeZone class]]){
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToTimeZone:obj2];};
        }else if ([_self isKindOfClass:[NSHashTable class]]){
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToHashTable:obj2];};
        }else if ([_self isKindOfClass:[NSOrderedSet class]]){
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqualToOrderedSet:obj2];};
        }else{
            blockCompare = ^(id obj1, id obj2){return [obj1 isEqual:obj2];};
        }
        
        for (id obj in objs) {
            if(blockCompare(_self , obj)){
                return @YES;
            }
        }
        return @NO;
    };
}

- (BOOL (^)( __unsafe_unretained Class))objIsKindOf
{
    return ^BOOL(Class clazz){
        return self.objIsKindOfAs(clazz).boolValue;
    };
}

- (NSNumber *(^)(__unsafe_unretained Class))objIsKindOfAs
{
    return ^id(Class clazz){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objIsKindOfAs,clazz)
        if(!clazz) return @NO;
        return @([_self.linkEnd isKindOfClass:clazz]);
    };
}

- (BOOL (^)( __unsafe_unretained Class))objIsMemberOfClass
{
    return ^(Class clazz){
        return self.objIsMemberOfClassAs(clazz).boolValue;
    };
}

- (NSNumber *(^)(__unsafe_unretained Class))objIsMemberOfClassAs
{
    return ^id(Class clazz){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objIsMemberOfClassAs,clazz)
        if(!clazz) return @NO;
        return @([_self.linkEnd isMemberOfClass:clazz]);
    };
}

- (BOOL (^)(__unsafe_unretained Class))objIsSubClassOf
{
    return ^(Class clazz){
        LinkHandle_VAL_IFNOT(NSObject){
            return NO;
        }
        LinkGroupHandle_VAL(objIsSubClassOf,clazz)
        if(!clazz) return NO;
        return [[_self.linkEnd class] isSubclassOfClass:clazz];
    };
}

- (NSNumber *(^)(__unsafe_unretained Class))objIsSubClassOfAs
{
    return ^id(Class clazz){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objIsSubClassOfAs,clazz)
        if(!clazz)
            return @NO;
        return @([[_self.linkEnd class] isSubclassOfClass:clazz]);
    };
}

- (NSObject *(^)(NSString *))objReverseValueForKey
{
    return ^id(NSString* key){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objReverseValueForKey,key)
        
        //collection object
        if([_self conformsToProtocol:@protocol(NSFastEnumeration)]){
            
            if(
               [_self isKindOfClass:NSArray.class]      ||
               [_self isKindOfClass:NSMutableDictionary.class] ||
               [_self isKindOfClass:NSSet.class]        ||
               [_self isKindOfClass:NSOrderedSet.class] ){
                
                NSObject* temp = [NSObject new];
                temp.accessibilityValue = [_self valueForKey:key];
                if([temp.accessibilityValue isKindOfClass:NSArray.class]){
                    temp.accessibilityValue = [(id)temp.accessibilityValue firstObject];
                }
                temp.objReverseValueForKey(@"accessibilityValue");
                [_self setValue:temp.accessibilityValue forKey:key];
            }
            return _self;
        }
        
        // single object
        id value = [_self valueForKey:key];
        const char* objcType = [_self.class lb_classGetPropertyType:key].UTF8String;
        
        [LinkHelper helpSwitchObjcType:objcType caseVoid:nil caseId:^{
            
            if([value isKindOfClass:[NSNumber class]]){
                
                [_self setValue:[value numReverse]() forKey:key];
            }else if ([value isKindOfClass:[NSString class]]){
                
                [_self setValue:[value strReversed]().mutableCopy forKey:key];
            }else if ([value isKindOfClass:[NSArray class]] ||
                      [value isKindOfClass:[NSOrderedSet class]]){
                
                id rValue = [value reverseObjectEnumerator].allObjects;
                if([value conformsToProtocol:@protocol(NSMutableCopying) ]){
                    rValue = [rValue mutableCopy];
                }
                [_self setValue:rValue forKey:key];
            }
        } caseClass:nil caseIMP:nil caseSEL:nil caseDouble:^{
            
            [_self setValue:@(-[value doubleValue]) forKey:key];
        } caseFloat:^{
            
            [_self setValue:@(-[value floatValue]) forKey:key];
        } casePointer:nil caseCharPointer:nil caseUnsignedLong:nil caseUnsignedLongLong:nil caseLong:^{
            
            [_self setValue:@(-[value longValue]) forKey:key];
        } caseLongLong:^{
            
            [_self setValue:@(-[value longLongValue]) forKey:key];
        } caseInt:^{
            
            [_self setValue:@(-[value intValue]) forKey:key];
        } caseUnsignedInt:nil caseBOOL_Char_xyShort:^{
            
            [_self setValue:@(![value boolValue]) forKey:key];
        } caseCGRect:^{
            
            CGRect rect = [value CGRectValue];
            CGSize size = rect.size;
            //exchange w and h
            size.width = size.width + size.height;
            size.height = size.width - size.height;
            size.width = size.width - size.height;
            rect.size = size;
            [_self setValue:[NSValue valueWithCGRect:rect] forKey:key];
        } caseNSRange:nil caseCGSize:^{
            
            CGSize size = [value CGSizeValue];
            //exchange w and h
            size.width = size.width + size.height;
            size.height = size.width - size.height;
            size.width = size.width - size.height;
            [_self setValue:[NSValue valueWithCGSize:size] forKey:key];
        } caseCGPoint:^{
            
            CGPoint point = [value CGPointValue];
            //exchange x and y
            point.x = point.x + point.y;
            point.y = point.x - point.y;
            point.x = point.x - point.y;
            [_self setValue:[NSValue valueWithCGPoint:point] forKey:key];
        } caseCGVector:^{
            
            CGVector v = [value CGVectorValue];
            //exchange dx and dy
            v.dx = v.dx + v.dy;
            v.dy = v.dx - v.dy;
            v.dx = v.dx - v.dy;
            [_self setValue:[NSValue valueWithCGVector:v] forKey:key];
        } caseUIEdgeInsets:^{
            
            UIEdgeInsets edge = [value UIEdgeInsetsValue];
            edge.top = edge.top + edge.bottom;
            edge.bottom = edge.top - edge.bottom;
            edge.top = edge.top - edge.bottom;
            edge.left = edge.left + edge.right;
            edge.right = edge.left - edge.right;
            edge.left = edge.left - edge.right;
            [_self setValue:[NSValue valueWithUIEdgeInsets:edge] forKey:key];
        } caseUIOffset:^{
            
            UIOffset offset = [value UIOffsetValue];
            //exchange x and y
            offset.horizontal = offset.horizontal + offset.vertical;
            offset.vertical   = offset.horizontal - offset.vertical;
            offset.horizontal = offset.horizontal - offset.vertical;
            [_self setValue:[NSValue valueWithUIOffset:offset] forKey:key];
        } caseCATransform3D:nil caseCGAffineTransform:nil caseNSDirectionalEdgeInsets:^{
            
            if (@available(iOS 11.0, *)) {
                NSDirectionalEdgeInsets edge = [value directionalEdgeInsetsValue];
                edge.top        = edge.top      + edge.bottom;
                edge.bottom     = edge.top      - edge.bottom;
                edge.top        = edge.top      - edge.bottom;
                edge.leading    = edge.leading  + edge.trailing;
                edge.trailing   = edge.leading  - edge.trailing;
                edge.leading    = edge.leading  - edge.trailing;
                [_self setValue:[NSValue valueWithDirectionalEdgeInsets:edge] forKey:key];
            }
        } defaule:nil];
        
        return _self;
    };
}

- (BOOL (^)(SEL))objIsRespondsSEL
{
    return ^(SEL theSEL){
        LinkHandle_VAL_IFNOT(NSObject){
            return NO;
        }
        LinkGroupHandle_VAL(objIsRespondsSEL,theSEL)
        if(theSEL){
            if([_self respondsToSelector:theSEL])
                return YES;
        }
        return NO;
    };
}

- (NSNumber *(^)(SEL))objIsRespondsSELAs
{
    return ^id(SEL theSEL){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objIsRespondsSELAs,theSEL)
        if(theSEL && [_self respondsToSelector:theSEL]) return @YES;
        return @NO;
    };
}

- (NSString *(^)(void))objToJsonString
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objToJsonString)
        if(![NSJSONSerialization isValidJSONObject:_self])
            return @"";
        NSError* error;
        NSData * jsonData;
        if([self isKindOfClass:[NSString class]]){
            
            jsonData = [NSJSONSerialization JSONObjectWithData:[((id)_self) dataUsingEncoding:NSUTF8StringEncoding]
                                                       options:kNilOptions
                                                         error:&error];
        } else{
            
            jsonData = [NSJSONSerialization dataWithJSONObject:_self
                                                       options:kNilOptions
                                                         error:&error];
        }
        return error?[NSString new]:[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    };
}

- (NSNumber *(^)(void))objToNSNumber
{
    if ([self isKindOfClass:[NSString class]]){
        return self.strToNSNumber;
    }
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objToNSNumber)
        
        if([_self isKindOfClass:[NSNumber class]]){
            return _self;
        }else if ([_self isKindOfClass:[JSValue class]]){
            return [(JSValue*)_self toNumber];
        }
        return @0;
    };
}

- (NSArray *(^)(void))objsArrayRepresentation
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objsArrayRepresentation)
        
        if(LB_IsKindOfClass(_self, NSArray))
            return self;
        if(LB_IsKindOfClass(_self, NSOrderedSet))
            return [(NSOrderedSet*)_self array];
        if(LB_RespondsToSEL(_self, allObjects))
            return [(id)_self allObjects];
        
        return NSNull.null;
    };
}

- (NSDictionary *(^)(void))objsDictionaryRepresentation
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objsDictionaryRepresentation)
        
        if(LB_IsKindOfClass(_self, NSDictionary))
            return self;
        
        if(LB_RespondsToSEL(_self, dictionaryRepresentation)){
            return [(id)_self dictionaryRepresentation];
        }
        
        return NSNull.null;
    };
}

- (BOOL (^)(id))objIsKeyOfObjs
{
    return ^BOOL(id objs){
        return self.objIsKeyOfObjsAs(objs).boolValue;
    };
}
- (NSNumber* (^)(id))objIsKeyOfObjsAs
{
    return ^id(id objs){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objIsKeyOfObjsAs,objs)
        
        if(![_self respondsToSelector:@selector(keyEnumerator)]) return @NO;
        
        NSEnumerator* enumerator = [objs keyEnumerator];
        while ([enumerator.nextObject isEqual:_self]) return @YES;
        return @NO;
    };
}

- (NSObject *(^)(void))objToNSJsonObject
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objToNSJsonObject)
        
        return linkObjNotNil([_self _lb_obj2JsonValueDepth:NO includeFoundation:NO]);
    };
}

- (NSObject *(^)(void))objToNSJsonObjectDepth
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objToNSJsonObjectDepth)
        
        return linkObjNotNil([_self _lb_obj2JsonValueDepth:YES includeFoundation:NO]);
    };
}

- (NSObject *(^)(void))objToNSJsonObjectFoundation
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objToNSJsonObjectFoundation)
        
        return linkObjNotNil([_self _lb_obj2JsonValueDepth:NO includeFoundation:YES]);
    };
}

- (NSObject *(^)(void))objToNSJsonObjectDepthAndFoundation
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objToNSJsonObjectDepthAndFoundation)
        
        return linkObjNotNil([_self _lb_obj2JsonValueDepth:YES includeFoundation:YES]);
    };
}

- (NSDictionary *(^)(void))objToNSDictionary
{
    
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objToNSDictionary)
        
        if([_self isKindOfClass:NSDictionary.class]) return _self;

        //collection object but unable to dictionary
        //avoid to enumerate
        if([self respondsToSelector:@selector(dictionaryRepresentation)] == NO
           &&  self.objIsCollectionAs().boolValue){
            return [NSDictionary new];
        }
        //single object
        id value = [_self _lb_obj2JsonValueDepth:NO includeFoundation:NO];
        if([value isKindOfClass:NSDictionary.class]) return value;
        return [NSDictionary new];
    };
}


/**
 转json value对象

 @param depth 深度遍历
 @param includeFoundation 解析Foundation属性（不安全的）
 @return ret∈{
                NSMutableDictionary,
                NSMutableArray,
                NSString,
                NSNumber,
                NSNull
            }
 */
- (id)_lb_obj2JsonValueDepth:(BOOL)depth
         includeFoundation:(BOOL)includeFoundation
{
    id _self = self;
    //direct foundation value
    if([self isKindOfClass:NSString.class]  ||
       [self isKindOfClass:NSNumber.class]  ||
       self == NSNull.null
       ){
        return _self;
    }
    //array able object so convert is to array
    if([self isKindOfClass:NSIndexPath.class]){
        return self.idxPathToNSArray();
    }
    if([self isKindOfClass:NSIndexSet.class]){
        
        _self = NSMutableArrayNew;
        [(NSIndexSet*)self enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
            [_self addObject:@(idx)];
        }];
        return _self;
    }
    
    //dictionary able collection then convert is to dictionary
    if([self isKindOfClass:NSDictionary.class]                      ||
       [self respondsToSelector:@selector(dictionaryRepresentation)]){
        
        id content;
        if([self respondsToSelector:@selector(dictionaryRepresentation)]){
            content = [_self dictionaryRepresentation];
        }else{
            content = [_self copy];
        }
        
        if(![self isKindOfClass:NSMutableDictionary.class])
            _self = NSMutableDictionaryNew;
        
        [content enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop) {
            
            key = (depth==NO)
            ?obj
            :[obj _lb_obj2JsonValueDepth:depth includeFoundation:includeFoundation];
            [_self setObject:key forKey:key];
        }];
        
        return _self;
    }
    
    //array collection so convert is to array
    if([_self respondsToSelector:@selector(objectEnumerator)]){
        
        NSArray* content = [_self copy];
        if(![self isKindOfClass:NSMutableArray.class]){
            _self = NSMutableArrayNew;
        }else{
            [_self removeAllObjects];
        }
        
        NSEnumerator* enumerator = [content objectEnumerator];
        id item;
        while ((item = enumerator.nextObject)) {
            
            item = (depth==NO)
            ?item
            :[item _lb_obj2JsonValueDepth:depth includeFoundation:includeFoundation];
            [_self addObject:item];
        }
        return _self;
    }
    
    if(includeFoundation == NO && [[self class] lb_classIsBasic])
        return _self;
    
    //single object!so convert is to a dictionary
    NSMutableDictionary* dictionary = NSMutableDictionaryNew;
    NSArray<NSString*>* properties = [[_self class] lb_classGetAllPropertyList:includeFoundation];
    @try {
        
        [properties enumerateObjectsUsingBlock:^(NSString* property, NSUInteger idx, BOOL * stop) {
            
            id value = [_self valueForKey:property];
            
            //nil , NSNull, custom Null has no key-value
            if(value == nil || [value isKindOfClass:NSNull.class])  return;
            
            //direct foundation value
            if([value isKindOfClass:NSString.class]  ||
               [value isKindOfClass:NSNumber.class]
               ){
                dictionary[property] = value;
                return;
            }
            
            BOOL valueIsFoundation = [[value class] lb_classIsBasic];
            if([value respondsToSelector:@selector(objectEnumerator)]           ||
               [value respondsToSelector:@selector(dictionaryRepresentation)]   ||
               [value isKindOfClass:NSIndexPath.class]                          ||
               [value isKindOfClass:NSIndexSet.class]                           ||
               valueIsFoundation == NO
               ){
                //collection type or custom object
                value = (depth==NO)
                ?value
                :[value _lb_obj2JsonValueDepth:depth includeFoundation:includeFoundation];
            }else if(valueIsFoundation && includeFoundation){
                
                //foundation type,such as UIView,NSError...
                value = [value description];
            } else{
                //is foundation but not include foundation
                return;
            }
            dictionary[property] = value;
        }];
    }@catch (NSException *exception) {
        
        NSLog(@"Error from :%s,process of convert json value has been interrupted;NSException=%@;",__func__,[exception description]);
    }@finally {
        
        return dictionary;
    }
}

- (NSDictionary *(^)(NSArray *))objToNSDictionaryWithKeys
{
    return self.objKeyValueWithKeys;
}

- (NSNumber *(^)(NSString *, NSString *, ...))objEvaluateValueForKeyPathAs
{
    return ^id(NSString *key ,NSString *predicateFormat, ...){
        
        BOOL ret = NO;
        
        va_list args;
        va_start(args, predicateFormat);
        NSPredicate* predicate = [NSPredicate predicateWithFormat:predicateFormat arguments:args];
        va_end(args);
        
        ///////////////////////
        //LinkGroupHandle_REF
        if([self isKindOfClass:[LinkGroup class]]){
            LinkGroup* group = self.thisLinkObjs;
            NSMutableArray* returnObjs = [NSMutableArray new];
            for (int i=0; i<group.linkObjects.count; i++) {
                ret = [predicate evaluateWithObject:[group.linkObjects[i] valueForKeyPath:key]];
                [returnObjs addObject:@(ret)];
            }
            [group.linkObjects setArray:returnObjs];
            return group;
        }
        //LinkGroupHandle_VAL
        ///////////////////////
        
        if([predicateFormat isKindOfClass:[NSString class]]){
            ret = [predicate evaluateWithObject:[self valueForKeyPath:key]];
        }
        return @(ret);
    };
}

- (NSNumber *(^)(NSString *, ...))objEvaluatePredicateAs
{
    return ^id(NSString *predicateFormat, ...){
        
        BOOL ret = NO;
        
        va_list args;
        va_start(args, predicateFormat);
        NSPredicate* predicate = [NSPredicate predicateWithFormat:predicateFormat arguments:args];
        va_end(args);
        
        ///////////////////////
        //LinkGroupHandle_REF
        if([self isKindOfClass:[LinkGroup class]]){
            LinkGroup* group = self.thisLinkObjs;
            NSMutableArray* returnObjs = [NSMutableArray new];
            for (int i=0; i<group.linkObjects.count; i++) {
                ret = [predicate evaluateWithObject:group.linkObjects[i]];
                [returnObjs addObject:@(ret)];
            }
            [group.linkObjects setArray:returnObjs];
            return group;
        }
        //LinkGroupHandle_VAL
        ///////////////////////
        
        if([predicateFormat isKindOfClass:[NSString class]]){
            ret = [predicate evaluateWithObject:self];
        }
        return @(ret);
    };
}
- (BOOL (^)(NSString *, ...))objEvaluatePredicate
{
    return ^BOOL(NSString *predicateFormat, ...){
        
        BOOL ret = NO;
        id _self = self;
        
        va_list args;
        va_start(args, predicateFormat);
        NSPredicate* predicate = [NSPredicate predicateWithFormat:predicateFormat arguments:args];
        va_end(args);
        
        ///////////////////////
        //LinkGroupHandle_VAL
        if([self isKindOfClass:[LinkGroup class]]){
            LinkGroup* group = self.thisLinkObjs;
            _self = group.linkObjects.firstObject;
        }
        //LinkGroupHandle_VAL
        ///////////////////////
        
        if([predicateFormat isKindOfClass:[NSString class]]){
            ret = [predicate evaluateWithObject:_self];
        }
        return ret;
    };
}
- (BOOL (^)(NSString *, NSString *, ...))objEvaluateValueForKeyPath
{
    return ^BOOL(NSString * key,NSString *predicateFormat, ...){
        
        BOOL ret = NO;
        id _self = self;
        
        va_list args;
        va_start(args, predicateFormat);
        NSPredicate* predicate = [NSPredicate predicateWithFormat:predicateFormat arguments:args];
        va_end(args);
        
        ///////////////////////
        //LinkGroupHandle_VAL
        if([self isKindOfClass:[LinkGroup class]]){
            LinkGroup* group = self.thisLinkObjs;
            _self = group.linkObjects.firstObject;
        }
        //LinkGroupHandle_VAL
        ///////////////////////
        
        if([predicateFormat isKindOfClass:[NSString class]]){
            ret = [predicate evaluateWithObject:[_self valueForKeyPath:key]];
        }
        return ret;
    };
}

- (NSObject *(^)(id, NSString *, NSString *, ...))objSetValueForKeyPathWhenEvaluated
{
    return ^id(id value, NSString *keyPath,NSString *predicateFormat, ...){
        
        va_list args;
        va_start(args, predicateFormat);
        NSPredicate* predicate = [NSPredicate predicateWithFormat:predicateFormat arguments:args];
        va_end(args);
        
        ///////////////////////
        //LinkGroupHandle_REF
        if([self isKindOfClass:[LinkGroup class]]){
            LinkGroup* group = self.thisLinkObjs;
            for (int i=0; i<group.linkObjects.count; i++) {
                
                if([predicate evaluateWithObject:group.linkObjects[i]]){
                    [group.linkObjects[i] setValue:value forKeyPath:keyPath];
                }
            }
            return self;
        }
        //LinkGroupHandle_VAL
        ///////////////////////
        
        if([predicate evaluateWithObject:self]){
            
            [self setValue:value forKeyPath:keyPath];
        }
        
        return self;
    };
}

- (NSObject *(^)(NSString *))objSetScreenValueForFullPath
{
    return ^id(NSString* fullPath){
        
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objSetScreenValueForFullPath, fullPath)
        
        //'...width' > 'frame.size'
        NSUInteger lastSTIdx = [fullPath rangeOfString:@"->" options:NSBackwardsSearch].location;
        NSUInteger lastDotIdx = [fullPath rangeOfString:@"." options:NSBackwardsSearch].location;

        if(lastSTIdx  == 0 || lastSTIdx  == fullPath.length-1 ||
           lastDotIdx == 0 || lastDotIdx == fullPath.length-1 ){
            //wrong path
            return _self;
        }

        NSString* keyPath;
        NSString* structPath;
        NSString* lastPath;
        NSValue* screenValue;
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        
        if(lastSTIdx == NSNotFound){
            
            if(lastDotIdx == NSNotFound){
                //'key'
                lastPath = fullPath;
                keyPath = fullPath;
            }else{
                //'.'...
                lastPath = [fullPath substringFromIndex:lastDotIdx+1];
                keyPath = [fullPath substringToIndex:lastDotIdx];
            }
            
            if([@[@"height",@"vertical",@"top",@"bottom"] containsObject:lastPath.lowercaseString]
               ||
               [lastPath.lowercaseString isEqualToString:@"y"]){
                
                screenValue = [NSNumber numberWithDouble:screenSize.height];
            }else if (![lastPath.lowercaseString containsString:@"width"] &&
                      [lastPath.lowercaseString containsString:@"size"]){
                
                screenValue = [NSValue valueWithCGSize:screenSize];
            }else{
                screenValue = [NSNumber numberWithDouble:screenSize.width];
            }
        }else{
            
            //'->'...
            NSUInteger firstSTIdx = [fullPath rangeOfString:@"->"].location;
            keyPath = [fullPath substringToIndex:firstSTIdx];
            structPath = [fullPath substringFromIndex:firstSTIdx+2];
            lastPath = [fullPath substringFromIndex:lastSTIdx+2];
            
            if([lastPath isEqualToString:@"size"]){
                
                screenValue = [NSValue valueWithCGSize:screenSize];
            }else if([@[@"height",@"y",@"vertical",@"top",@"bottom"] containsObject:lastPath]){
                
                screenValue = [NSNumber numberWithDouble:screenSize.height];
            }else{
                
                screenValue = [NSNumber numberWithDouble:screenSize.width];
            }
        }
        
        
        if(structPath){
            ///Means value is from modify old value.
            NSValue* toModifyValue = [_self valueForKeyPath:keyPath];
            structPath = [structPath stringByReplacingOccurrencesOfString:@"->" withString:@"."];
            screenValue = toModifyValue.valueStructSetValueForKeyPath(screenValue, structPath);
        }
        
        [_self setValue:screenValue forKeyPath:keyPath];
        
        return _self;
    };
}

- (NSObject *(^)(id, id))objCopyValueFromObjectByFullPath
{
    return ^id(id srcObj,id asFullPath){
        
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objCopyValueFromObjectByFullPath,srcObj,asFullPath)
        if(!srcObj) return _self;
        
        NSUInteger count = 1;
        id aFullPath = asFullPath;
        if(![asFullPath isKindOfClass:NSArray.class]){
            
            goto CALL_SET_VALUE;
        }
        
        count = [asFullPath count];
        
    CALL_FOR:
        
        if(count == 0) return self;
        aFullPath = [asFullPath objectAtIndex:count];
        
    CALL_SET_VALUE:
        self.objSetValueForFullPath([srcObj objValueForFullPath](aFullPath).linkEnd,aFullPath);
        --count;
        
        goto CALL_FOR;
    };
}



- (BOOL (^)(void))objIsKindOfNSBlock
{
    return ^BOOL(){
        LinkHandle_VAL_IFNOT(NSObject){
            return NO;
        }
        LinkGroupHandle_VAL(objIsKindOfNSBlock)
        return [_self isKindOfClass:NSClassFromString(@"NSBlock")];
    };
}

- (NSUInteger (^)(void))blockArgsCount
{
    return ^NSUInteger(){
        
        if(![self isKindOfClass:NSClassFromString(@"NSBlock")])
            return 0;
        
        LinkGroupHandle_VAL(blockArgsCount)
        
        LinkBlockInvocation* invocation = [LinkBlockInvocation invocationWithBlock:self];
        NSUInteger all = invocation.methodSignature.numberOfArguments;
        if(all < 2) return 0;
        return all - 1;
    };
}

- (const char *(^)(void))blockReturnType
{
    return ^const char *(){
        
        if(![self isKindOfClass:NSClassFromString(@"NSBlock")])
            return nil;
        
        LinkGroupHandle_VAL(blockReturnType)
        
        LinkBlockInvocation* invocation = [LinkBlockInvocation invocationWithBlock:self];
        return invocation.methodSignature.methodReturnType;
    };
}

- (Class (^)(void))objClass
{
    return ^id(){
        LinkHandle_VAL_IFNOT(NSObject){
            return nil;
        }
        LinkGroupHandle_VAL(objClass)
        return [_self.linkEnd class];
    };
}

- (NSString *(^)(void))objClassName
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objClassName)
        return linkObjDefault(NSStringFromClass([_self class]) , @"");
    };
}

- (NSString *(^)(void))objSuperclassName
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objSuperclassName)
        return linkObjDefault(NSStringFromClass([_self superclass]),@"");
    };
}

- (NSObject *(^)(void))nslog
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(nslog)
        NSLog(@"%@",_self);
        return _self;
    };
}

- (NSObject *)logRetainCount
{
    NSLog(@"%@",[self valueForKey:@"retainCount"]);
    return self;
}

- (NSObject *(^)(void))poDetail
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(poDetail)
        
        NSLog(@"%@",[self _lb_obj2JsonValueDepth:YES includeFoundation:NO]);
        return _self;
    };
}

- (NSObject *(^)(void))po
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(po)
        NSLog(@"%@",[self _lb_obj2JsonValueDepth:NO includeFoundation:NO]);
        return _self;
    };
}

- (NSObject *(^)(NSString *))nslogValueForKeyPath
{
    return ^id(NSString* key){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(nslogValueForKeyPath,key)
        NSLog(@"%@",[_self valueForKeyPath:key]);
        return _self;
    };
}


- (NSObject* (^)(NSString*))objValueForKey
{
    return ^id(NSString* key){
        LinkHandle_VAL_IFNOT(NSObject){
            return NSNull.null;
        }
        LinkGroupHandle_VAL(objValueForKey,key)
        return linkObjNotNil([_self valueForKey:key]);
    };
}

- (NSObject *(^)(id, NSString* ))objSetValueForKey
{
    return ^id(id value, NSString* key){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objSetValueForKey,value,key)
        [_self setValue:value forKey:key];
        return _self;
    };
}

- (NSObject *(^)(NSString *))objValueForKeyPath
{
    return ^id(NSString* key){
        LinkHandle_VAL_IFNOT(NSObject){
            return NSNull.null;
        }
        LinkGroupHandle_VAL(objValueForKeyPath,key)
        return linkObjNotNil([_self valueForKeyPath:key]);
    };
}

- (NSObject *(^)(id , NSString* ))objSetValueForKeyPath
{
    return ^id(id value, NSString* key){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objSetValueForKeyPath,value,key)
        [_self setValue:value forKeyPath:key];
        return self;
    };
}

- (NSObject *(^)(NSDictionary<NSString *,id> *))objSetValuesWithKeyValues
{
    return ^id(NSDictionary<NSString *,id> * kvs){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objSetValuesWithKeyValues,kvs)
        [_self setValuesForKeysWithDictionary:kvs];
        return self;
    };
}

- (NSDictionary *(^)(NSArray<NSString *> *))objKeyValueWithKeys
{
    return ^id(NSArray<NSString *> * keys){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objKeyValueWithKeys,keys)
        
        return linkObjNotNil([_self dictionaryWithValuesForKeys:keys]);
    };
}

- (NSObject *(^)(id))objSetNilForKey
{
    return ^id(id asKey){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objSetNilForKey,asKey)
        
        if([asKey isKindOfClass:NSArray.class]){
            [asKey enumerateObjectsUsingBlock:^(id  obj,NSUInteger idx, BOOL* stop) {
                [_self setValue:nil forKey:asKey];
            }];
        }else{
            [_self setValue:nil forKey:asKey];
        }
        return _self;
    };
}

- (NSObject *(^)(id,NSUInteger))objSetRandomStringForKeyPath
{
    return ^id(id key,NSUInteger len){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objSetRandomStringForKeyPath,key,len)
        
        int count;
        id aKey;
        NSMutableString* text = [NSMutableString new];
        
        if([key isKindOfClass:[NSArray class]]){
            
            count = (int)[key count];
        }else{
            
            count = 1;
            aKey = key;
            goto CALL_SETVALUE;
        }
        
    CALL_FOR:
        
        if(count < 1) return _self;
        
        aKey = key[count-1];
        
    CALL_SETVALUE://in:count,aKey
        
        --count;
        NSUInteger pageCount = (len+32-1)/32;
        NSUInteger lastPageLen = len%32;
        
        for (NSUInteger i=0; i<pageCount; i++) {
            
            id newStr = [[NSUUID UUID].UUIDString stringByReplacingOccurrencesOfString:@"-" withString:@""];
            
            if(lastPageLen!=0 && i==pageCount-1){//last
                
                [text appendString:[newStr substringToIndex:len%32]];
                break;
            }
            [text appendString:newStr];
        }
        
        [_self setValue:[text mutableCopy] forKeyPath:aKey];
        [text deleteCharactersInRange:NSMakeRange(0, text.length)];//clean
        goto CALL_FOR;
    };
}

- (NSObject *(^)(id,NSUInteger))objSetRandomStringzh_CNForKeyPath
{
    return ^id(id key,NSUInteger len){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objSetRandomStringzh_CNForKeyPath,key,len)
        
        int count;
        id aKey;
        NSMutableString* text = [NSMutableString new];
        
        if([key isKindOfClass:[NSArray class]]){
            
            count = (int)[key count];
        }else{
            
            count = 1;
            aKey = key;
            goto CALL_SETVALUE;
        }
        
    CALL_FOR:
        
        if(count < 1) return _self;
        
        aKey = key[count-1];
        
    CALL_SETVALUE://in:count,aKey
        
        --count;
        
        NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSInteger randomH,randomL,number;
        for(NSInteger i =0; i < len; i++){
            
            randomH = 0xA1 + arc4random()%((0xFE)-(0xA1)+1);//高位
            randomL =0xB0 + arc4random()%(0xF7-0xB0+1);//低位
            number = (randomH<<8)+randomL;//组合
            [text appendString:[[NSString alloc]initWithData:[NSData dataWithBytes:&number length:2]
                                                    encoding:gbkEncoding]];
        }
        
        [_self setValue:text forKeyPath:aKey];
        [text deleteCharactersInRange:NSMakeRange(0, text.length)];//clean
        
        goto CALL_FOR;
    };
}

- (NSObject *(^)(id,NSUInteger))objSetRandomStringNumberForKeyPath
{
    return ^id(id key,NSUInteger len){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objSetRandomStringNumberForKeyPath,key,len)
        
        int count;
        id aKey;
        NSMutableString* text = [NSMutableString new];
        
        NSArray* charNums = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
        
        if([key isKindOfClass:[NSArray class]]){
            
            count = (int)[key count];
        }else{
            
            count = 1;
            aKey = key;
            goto CALL_SETVALUE;
        }
        
    CALL_FOR:
        
        if(count < 1) return _self;
        
        aKey = key[count-1];
        
    CALL_SETVALUE://in:count,aKey
        
        --count;
        uint32_t idx = 0;
        for(NSInteger i=0; i < len; i++){
            
            idx = arc4random_uniform(10);
            if(i==0 && idx==0){
                --i;
                continue;
            }
            [text appendString:charNums[idx]];
        }
        
        [_self setValue:text forKeyPath:aKey];
        [text deleteCharactersInRange:NSMakeRange(0, text.length)];//clean
        
        goto CALL_FOR;
    };
}

- (NSObject *(^)(id, uint32_t))objSetRandomNumberForKeyPath
{
    return ^id(id key , uint32_t max){
        
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objSetRandomNumberForKeyPath,key,max)
        
        int count;
        id aKey;
        NSNumber* number;
        
        if([key isKindOfClass:[NSArray class]]){
            
            count = (int)[key count];
        }else{
            
            count = 1;
            aKey = key;
            goto CALL_SETVALUE;
        }
        
    CALL_FOR:
        
        if(count < 1) return _self;
        
        aKey = key[count-1];
        
    CALL_SETVALUE://in:count,aKey
        
        --count;
        number = [NSNumber numberWithInteger:arc4random_uniform(max)];
        [_self setValue:number forKeyPath:aKey];
        
        goto CALL_FOR;
    };
}

- (NSObject *(^)(id, id))objSetRandomDateForKeyPath
{
    return ^id(id key, id days){
        
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objSetRandomDateForKeyPath,key,days)
        
        double lOffset = 0,rOffset = 0;
        
        if ([days isKindOfClass:NSArray.class] && [days count] == 2){
            
            lOffset = [[days firstObject] doubleValue];
            rOffset = [[days lastObject] doubleValue];
        }else{
            
            NSTimeInterval ds = 0;
            if([days isKindOfClass:NSArray.class] && [days count] == 1){
                
                ds = [[days firstObject] doubleValue];
            }else if([days isKindOfClass:NSNumber.class]){
                
                ds = [days doubleValue];
            }
            //jump ds == 0
            lOffset = ds<0?ds:0;
            rOffset = ds>0?ds:0;
        }
        
        NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
        int count;
        id aKey;
        
        if([key isKindOfClass:[NSArray class]]){
            
            count = (int)[key count];
        }else{
            
            count = 1;
            aKey = key;
            goto CALL_SETVALUE;
        }
        
    CALL_FOR:
        
        if(count < 1) return _self;
        
        aKey = key[count-1];
        
    CALL_SETVALUE://in:count,aKey
        
        --count;
        //left~right -> 0~offset-left
        
        double offset = arc4random_uniform((rOffset - lOffset)*86400.0) + lOffset*86400.0;
        offset = offset?offset:(-(double)arc4random_uniform(86400));
        [_self setValue:[NSDate dateWithTimeIntervalSince1970:now+offset]
                 forKeyPath:aKey];
        
        goto CALL_FOR;
    };
}

- (NSObject *(^)(id, uint32_t, NSUInteger))objSetRandomDoubleForKeyPath
{
    return ^id(id key, uint32_t max, NSUInteger rightLen){
        
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objSetRandomDoubleForKeyPath,key,max,rightLen)
        
        int count;
        id aKey;
        NSDecimalNumber* number;
        
        if([key isKindOfClass:[NSArray class]]){
            
            count = (int)[key count];
        }else{
            
            count = 1;
            aKey = key;
            goto CALL_SETVALUE;
        }
        
    CALL_FOR:
        
        if(count < 1) return _self;
        
        aKey = key[count-1];
        
    CALL_SETVALUE://in:count,aKey
        
        --count;
        uint32_t integer = arc4random_uniform(max);
        uint32_t decimal = arc4random_uniform(pow(10, rightLen));
        number = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d.%d",integer,decimal]];
        [_self setValue:number forKeyPath:aKey];
        
        goto CALL_FOR;
    };
}


- (NSObject *(^)(id))objGetPrevItemFromObjs
{
    return ^id(id objs){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objGetPrevItemFromObjs,objs)
        
        if([objs isKindOfClass:NSArray.class]   ||
           [objs isKindOfClass:NSOrderedSet.class]) {
            
            NSInteger idx = [objs indexOfObject:_self];
            if(idx != NSNotFound && idx-1 >= 0){
                return [objs objectAtIndex:idx-1];
            }
            goto CALL_RET;
        }else if([_self isKindOfClass:NSNumber.class]   &&
                 [objs isKindOfClass:NSIndexSet.class]){
            
                return @([objs indexLessThanIndex:[(id)_self unsignedIntegerValue]]);
        }
        
    CALL_RET:
        return [NSNull null];
    };
}

- (NSObject *(^)(id))objGetNextItemFromObjs
{
    return ^id(id objs){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objGetNextItemFromObjs,objs)

        if([objs isKindOfClass:NSArray.class]   ||
           [objs isKindOfClass:NSOrderedSet.class]) {
            
            NSUInteger idx = [objs indexOfObject:_self];
            if(idx != NSNotFound && idx+1 <= [objs count]-1){
                return [objs objectAtIndex:idx+1];
            }
            goto CALL_RET;
        }else if([_self isKindOfClass:NSNumber.class]   &&
                 [objs isKindOfClass:NSIndexSet.class]){
            
            return @([objs indexGreaterThanIndex:[(id)_self unsignedIntegerValue]]);
        }
        
    CALL_RET:
        return [NSNull null];
    };
}

- (BOOL (^)(id))objIsSubitemOfObjs
{
    return ^BOOL(id objs){
        return self.objIsSubitemOfObjsAs(objs).boolValue;
    };
}
- (NSNumber* (^)(id))objIsSubitemOfObjsAs
{
    return ^id(id objs){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objIsSubitemOfObjsAs, objs)
        
        //content that have collection
        
        if([objs respondsToSelector:@selector(objectEnumerator)]){
            
            NSEnumerator* enumerator = [objs objectEnumerator];
            while([_self isEqual:enumerator.nextObject])
                return @YES;
        }
        
        //indexSet
        if([_self isKindOfClass:NSNumber.class]){
            
            if([objs isKindOfClass:NSIndexSet.class]){
                return @([objs containsIndex:[(id)_self unsignedIntegerValue]]);
            }
        }
        
        return @NO;
    };
}

- (NSNumber *(^)(id))objIsSubitemOfObjAs
{
        return ^id(id obj){
            
            LinkHandle_REF(NSObject)
            LinkGroupHandle_REF(objIsSubitemOfObjAs, obj)
            
            id objs;
            //string content
            if([obj isKindOfClass:NSAttributedString.class]     ||
               [obj isKindOfClass:UIPasteboard.class]           ||
               [obj isKindOfClass:NSScanner.class]
               ){
                obj = [obj string];
            }
            if([obj isKindOfClass:NSString.class]){
                
                if([(id)_self isKindOfClass:NSAttributedString.class]   ||
                   [(id)_self isKindOfClass:UIPasteboard.class]         ||
                   [(id)_self isKindOfClass:NSScanner.class]){
                    _self = [(id)_self string];
                }
                
                if([_self isKindOfClass:NSString.class])
                    return @([obj containsString:(id)_self]);
                
                return @NO;
            }
            else if([obj isKindOfClass:UIView.class])
                objs = [(id)_self subviews];
            else if([obj isKindOfClass:UIViewController.class])
                objs = [(id)_self childViewControllers];
            else if([obj isKindOfClass:CALayer.class])
                objs = [(id)_self sublayers];
            
            return self.objIsSubitemOfObjsAs(objs);
        };
}

#define Link_objSetValueForK(key) \
- (NSObject *(^)(id))objSetValueForK##key\
{\
    return ^id(id value){\
        LinkHandle_REF(NSObject)\
        LinkGroupHandle_REF(objSetValueForK##key, value)\
        [_self setValue:value forKey:@""#key""];\
        return _self;\
    };\
}

Link_objSetValueForK(delegate)
Link_objSetValueForK(dataSource)
Link_objSetValueForK(text)

- (NSObject *(^)(void))objSetAllValuesBlank
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objSetAllValuesBlank)
        
        [self.class lb_classEnumerateUsingBlock:^(__unsafe_unretained Class clazz, BOOL *stop) {
            
            unsigned int outCount, i;
            objc_property_t* properties = class_copyPropertyList(clazz, &outCount);
            for(i=0 ; i< outCount; i++){
                
                NSString* pName = @(property_getName(properties[i]));
                NSString *attrs = @(property_getAttributes(properties[i]));
                NSUInteger dotLoc = [attrs rangeOfString:@","].location;
                NSArray* attrInfos = [attrs componentsSeparatedByString:@","];
                NSString *code = nil;
                NSUInteger loc = 1;
                if (dotLoc == NSNotFound) { // 没有
                    code = [attrs substringFromIndex:loc];
                } else {
                    code = [attrs substringWithRange:NSMakeRange(loc, dotLoc - loc)];
                }
                if (code.length > 3 && [code hasPrefix:@"@\""]) {//对象
                    // 去掉@"和"，截取中间的类型名称
                    code = [code substringWithRange:NSMakeRange(2, code.length - 3)];
                }
                
                if([attrInfos containsObject:@"R"]){//只读属性
                    continue;
                }
                else if (![[attrInfos.lastObject substringToIndex:1] isEqualToString:@"V"]){//无值
                    continue;
                }
                
                if ([code isEqualToString:@"@"]) {
                    //id
                    [_self setValue:nil forKey:pName];
                    continue;
                } else if (code.length == 0) {
                    //KVCDisabled
                    continue;
                } else if (code.length > 3 && [code hasPrefix:@"@\""]) {//对象
                    [_self setValue:nil forKey:pName];
                } else if ([code isEqualToString:@":"] ||//SEL
                           [code isEqualToString:@"^{objc_ivar=}"] ||//ivar
                           [code isEqualToString:@"^{objc_method=}"] ||//Method
                           [code isEqualToString:@"@?"]) {//block
                    //KVCDisabled
                    continue;
                }else if([code isEqualToString:@(@encode(CGRect))]){
                    [_self setValue:[NSValue valueWithCGRect:CGRectZero] forKey:pName];
                    continue;
                }else if([code isEqualToString:@(@encode(CGPoint))]){
                    [_self setValue:[NSValue valueWithCGPoint:CGPointZero] forKey:pName];
                    continue;
                }else if([code isEqualToString:@(@encode(CGSize))]){
                    [_self setValue:[NSValue valueWithCGSize:CGSizeZero] forKey:pName];
                    continue;
                }else if([code isEqualToString:@(@encode(NSRange))]){
                    [_self setValue:[NSValue valueWithRange:NSMakeRange(0, 0)] forKey:pName];
                    continue;
                }else if([code isEqualToString:@(@encode(UIEdgeInsets))]){
                    [_self setValue:[NSValue valueWithUIEdgeInsets:UIEdgeInsetsZero] forKey:pName];
                    continue;
                }else if([code isEqualToString:@(@encode(UIOffset))]){
                    [_self setValue:[NSValue valueWithUIOffset:UIOffsetZero] forKey:pName];
                    continue;
                }else if([code isEqualToString:@(@encode(CGVector))]){
                    [_self setValue:[NSValue valueWithCGVector:CGVectorMake(0, 0)] forKey:pName];
                    continue;
                }
                
                
                // 是否为数字类型
                NSString *lowerCode = code.lowercaseString;
                NSArray *numberTypes = @[@"i", @"s", @"c", @"b", @"f", @"d", @"l", @"q", @"c"];
                if ([numberTypes containsObject:lowerCode]) {
                    //numberType
                    [_self setValue:@0 forKey:pName];
                    if ([lowerCode isEqualToString:@"c"]  || [lowerCode isEqualToString:@"b"]) {
                        //boolType
                        [_self setValue:@NO forKey:pName];
                    }
                }
            }
            
            free(properties);
            
        } includeBasic:NO];
        
        
        return _self;
    };
}

- (NSObject *(^)(SEL sel))objPerformSelector
{
    return ^id(SEL sel){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objPerformSelector, sel)
        if([_self respondsToSelector:sel]){
            
            _LB_performSelector(_self, sel);
        }else{
            NSLog(@"LinkBlock:%@未能找到方法:%@",self,NSStringFromSelector(sel));
        }
        return _self;
    };
}

- (NSObject *(^)(SEL))objPerformSelectorAsWhatReturn
{
    return ^id(SEL sel){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objPerformSelectorAsWhatReturn, sel)
        if(![_self respondsToSelector:sel]){
            [[LinkError errorWithCustomDescription:[NSString stringWithFormat:@"%@ not response to sel:%@",_self,NSStringFromSelector(sel)]] logError];
            return NSNull.null;
        }
        return LBObjcValue([_self _lb_performSelector:sel withArg:nil]);
    };
}

- (NSObject *(^)(SEL, id))objPerformSelectorArgument
{
    return ^id(SEL sel , id obj){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objPerformSelectorArgument, sel , obj)
        if(![_self respondsToSelector:sel]){
            [[LinkError errorWithCustomDescription:[NSString stringWithFormat:@"%@ not response to sel:%@",_self,NSStringFromSelector(sel)]] logError];
            return NSNull.null;
        }
        
        _LB_performSelector1(_self, sel, obj);
        return _self;
    };
}

- (NSObject *(^)(SEL, id))objPerformSelectorArgumentAsWhatReturn
{
    return ^id(SEL sel , id obj){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objPerformSelectorArgumentAsWhatReturn, sel , obj)
        if(![_self respondsToSelector:sel]){
            [[LinkError errorWithCustomDescription:[NSString stringWithFormat:@"%@ not response to sel:%@",_self,NSStringFromSelector(sel)]] logError];
        }
        return LBObjcValue([_self _lb_performSelector:sel withArg:obj]);
    };
}

- (NSObject *(^)(SEL , ...))objPerformSelectors
{
    return ^id(SEL sel , ...){
        LinkHandle_REF(NSObject)
        ///////////////////////
        //LinkGroupHandle_REF
        if([self isKindOfClass:[LinkGroup class]]){
            LinkGroup* group = self.thisLinkObjs;
            if([group.linkObjects.firstObject respondsToSelector:sel]){
                
                _LB_performSelector(group.linkObjects.firstObject, sel);
            }else{
                [[LinkError errorWithCustomDescription:[NSString stringWithFormat:@"%@ not response to sel:%@",group.linkObjects.firstObject,NSStringFromSelector(sel)]] logError];
            }
            va_list args;
            va_start(args, sel);
            SEL parm;
            while ((parm = va_arg(args, SEL))) {
                for (int i=1; i<group.linkObjects.count; i++) {
                    if([group.linkObjects[i] respondsToSelector:parm]){
                        
                        _LB_performSelector(group.linkObjects[i] , parm);
                    }else{
                        [[LinkError errorWithCustomDescription:[NSString stringWithFormat:@"%@ not response to sel:%@",group.linkObjects[i],NSStringFromSelector(sel)]] logError];
                    }
                }
            }
            va_end(args);
            return group;
        }
        //LinkGroupHandle_VAL
        ///////////////////////
        if([_self respondsToSelector:sel]){
            
            _LB_performSelector(_self, sel);
        }else{
            [[LinkError errorWithCustomDescription:[NSString stringWithFormat:@"%@ not response to sel:%@",self,NSStringFromSelector(sel)]] logError];
        }
        va_list args;
        va_start(args, sel);
        SEL parm;
        while ((parm = va_arg(args, SEL))) {
            if([_self respondsToSelector:parm]){
                
                _LB_performSelector(_self, parm);
            }else{
                [[LinkError errorWithCustomDescription:[NSString stringWithFormat:@"%@ not response to sel:%@",self,NSStringFromSelector(sel)]] logError];
            }
        }
        va_end(args);
        
        return _self;
    };
}

- (NSArray *(^)(SEL, ...))objPerformSelectorsAsWhatReturns
{
    return ^id(SEL sel , ...){
        LinkHandle_REF(NSObject)
        NSMutableArray* results = NSMutableArrayNew;
        ///////////////////////
        //LinkGroupHandle_REF
        if([self isKindOfClass:[LinkGroup class]]){
            LinkGroup* group = self.thisLinkObjs;
            [results addObject: LBObjcValue([group.linkObjects.firstObject _lb_performSelector:sel withArg:nil])];
            va_list args;
            va_start(args, sel);
            SEL parm;
            while ((parm = va_arg(args, SEL))) {
                for (int i=1; i<group.linkObjects.count; i++) {
                    [results addObject: LBObjcValue([group.linkObjects[i] _lb_performSelector:parm withArg:nil])];
                }
            }
            va_end(args);
            [group.linkObjects setArray:results];
            return group;
        }
        //LinkGroupHandle_VAL
        ///////////////////////
        
        [results addObject: LBObjcValue([_self _lb_performSelector:sel withArg:nil])];
        va_list args;
        va_start(args, sel);
        SEL parm;
        while ((parm = va_arg(args, SEL))) {
            [results addObject: LBObjcValue([_self _lb_performSelector:parm withArg:nil])];
        }
        va_end(args);
        
        return results;
    };
}

- (NSObject *(^)(SEL , NSArray* , ...))objPerformsSelectorArguments
{
    return ^id(SEL sel0 , NSArray* args0 , ...){
        LinkHandle_REF(NSObject)
        SEL currentSEL;
        NSArray* currentArgs;
        ///////////////////////
        //LinkGroupHandle_REF
        if([self isKindOfClass:[LinkGroup class]]){
            LinkGroup* group = self.thisLinkObjs;
            currentSEL = sel0; currentArgs = args0;
            [group.linkObjects.firstObject _lb_performSelector:currentSEL withArgs:currentArgs];
            currentSEL = nil; currentArgs = nil;
            for (int idx=1 ; idx<group.linkObjects.count; idx++) {
                
                va_list args;
                va_start(args , args0);
                int i = 0;
                while (true) {
                    
                    if(i%2 == 0){//偶数取方法
                        
                        if(currentSEL && currentArgs){
                            [group.linkObjects[i] _lb_performSelector:currentSEL withArgs:currentArgs];
                            currentArgs = nil;
                        }
                        currentSEL = va_arg(args, SEL);
                        if(!currentSEL) break;
                    }else{//取参数
                        
                        currentArgs = va_arg(args, NSArray*);
                        if(!currentArgs) break;
                    }
                    ++i;
                }
                va_end(args);
            }
            return group;
        }
        //LinkGroupHandle_VAL
        ///////////////////////
        
        currentSEL = sel0; currentArgs = args0;
        [_self _lb_performSelector:currentSEL withArgs:currentArgs];
        currentSEL = nil; currentArgs = nil;
        
        va_list args;
        va_start(args , args0);
        int i = 0;
        while (true) {
            
            if(i%2 == 0){//偶数取方法
                
                if(currentSEL && currentArgs){
                    [_self _lb_performSelector:currentSEL withArgs:currentArgs];
                    currentArgs = nil;
                }
                currentSEL = va_arg(args, SEL);
                if(!currentSEL) break;
            }else{//取参数
                
                currentArgs = va_arg(args, NSArray*);
                if(!currentArgs) break;
            }
            ++i;
        }
        va_end(args);
        return self;
    };
}

- (NSArray *(^)(SEL , NSArray* , ...))objPerformsSelectorArgumentsAsWhatReturns
{
    return ^id(SEL sel0 , NSArray* args0 , ...){
        
        LinkHandle_REF(NSObject)
        NSMutableArray* result = NSMutableArrayNew;
        SEL currentSEL;
        NSArray* currentArgs;
        ///////////////////////
        //LinkGroupHandle_REF
        if([self isKindOfClass:[LinkGroup class]]){
            LinkGroup* group = self.thisLinkObjs;
            currentSEL = sel0; currentArgs = args0;
            [group.linkObjects.firstObject _lb_performSelector:currentSEL withArgs:currentArgs];
            currentSEL = nil; currentArgs = nil;
            for (int idx=1 ; idx<group.linkObjects.count; idx++) {
                
                va_list args;
                va_start(args , args0);
                int i = 0;
                while (true) {
                    
                    if(i%2 == 0){//偶数取方法
                        
                        if(currentSEL && currentArgs){
                            [result addObject: LBObjcValue([group.linkObjects[i] _lb_performSelector:currentSEL withArgs:currentArgs])];
                            currentArgs = nil;
                        }
                        currentSEL = va_arg(args, SEL);
                        if(!currentSEL) break;
                    }else{//取参数
                        
                        currentArgs = va_arg(args, NSArray*);
                        if(!currentArgs) break;
                    }
                    ++i;
                }
                va_end(args);
            }
            [group.linkObjects setArray:result];
            return group;
        }
        //LinkGroupHandle_VAL
        ///////////////////////
        
        currentSEL = sel0; currentArgs = args0;
        [result addObject: LBObjcValue([_self _lb_performSelector:currentSEL withArgs:currentArgs])];
        currentSEL = nil; currentArgs = nil;
        
        va_list args;
        va_start(args , args0);
        int i = 0;
        while (true) {
            
            if(i%2 == 0){//偶数取方法
                
                if(currentSEL && currentArgs){
                    [result addObject: LBObjcValue([_self _lb_performSelector:currentSEL withArgs:currentArgs])];
                    currentArgs = nil;
                }
                currentSEL = va_arg(args, SEL);
                if(!currentSEL) break;
            }else{//奇数取参数
                
                currentArgs = va_arg(args, NSArray*);
                if(!currentArgs) break;
            }
            ++i;
        }
        va_end(args);
        return result;
    };
}

- (CFIndex)objRetainCount
{
    return [[self valueForKey:@"retainCount"] longValue];
    
}

- (id)_lb_performSelector:(SEL)aSelector withArg:(id)arg
{
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    if (signature == nil) {
        return [[LinkError errorWithCustomDescription:[NSString stringWithFormat:@"%@未能找到方法:%@",self,NSStringFromSelector(aSelector)]] logError];
    }
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = aSelector;
    if(signature.numberOfArguments>2)
        [invocation setArgument:&arg atIndex:2];//去掉self,_cmd所以从2开始
    [invocation invoke];
    id __unsafe_unretained returnValue;
    if (signature.methodReturnLength) {
        [invocation getReturnValue:&returnValue];
    }
    return returnValue;
}

- (id)_lb_performSelector:(SEL)aSelector withArgs:(NSArray*)args
{
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    if (signature == nil) {
        return [[LinkError errorWithCustomDescription:[NSString stringWithFormat:@"%@未能找到方法:%@",self,NSStringFromSelector(aSelector)]] logError];
    }
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = aSelector;
    NSInteger paramsCount = signature.numberOfArguments - 2;// 获取除去self、_cmd以外的参数个数
    for (NSInteger idx = 0; idx < paramsCount; idx++) {
        if(idx >= paramsCount) break ;//越界检测
        id arg = nil;
        if(args.count && idx<args.count && args[idx] != [NSNull null]){
            arg = args[idx];
        }
        [invocation setArgument:&arg atIndex:idx+2];// 去掉self、_cmd所以从2开始
        [invocation retainArguments];
    }
    [invocation invoke];
    id __unsafe_unretained returnValue;
    if (signature.methodReturnLength) {
        [invocation getReturnValue:&returnValue];
    }
    return returnValue;
}
@end
