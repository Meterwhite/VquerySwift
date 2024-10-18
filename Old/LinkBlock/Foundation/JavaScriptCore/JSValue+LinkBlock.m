//
//  JSValue+LinkBlock.m
//  LinkBlockProgram
//
//  Created by NOVO on 16/6/21.
//  Copyright © 2016年 NOVO. All rights reserved.
//

#import "LinkBlock.h"

@implementation NSObject(JSValueLinkBlock)
- (JSManagedValue *(^)(id))jsValueToManagedValue
{
    return ^id(id owner){
        LinkHandle_REF(JSValue)
        LinkGroupHandle_REF(jsValueToManagedValue,owner)
        if(owner){
            return [JSManagedValue managedValueWithValue:_self andOwner:owner];
        }else{
            return [JSManagedValue managedValueWithValue:_self];
        }
    };
}

- (JSValue *(^)(id))jsValueAddToSelfManagedRef
{
    return ^id(id owner){
        LinkHandle_REF(JSValue)
        LinkGroupHandle_REF(jsValueAddToSelfManagedRef,owner)
        JSManagedValue* value = [JSManagedValue managedValueWithValue:_self];
        [_self.context.virtualMachine addManagedReference:value withOwner:owner];
        return _self;
    };
}

- (JSValue *(^)(NSArray *))jsValueCallFunc
{
    return ^id(NSArray* args){
        LinkHandle_REF(JSValue)
        LinkGroupHandle_REF(jsValueCallFunc,args)
        return [_self callWithArguments:args];
    };
}


@end
