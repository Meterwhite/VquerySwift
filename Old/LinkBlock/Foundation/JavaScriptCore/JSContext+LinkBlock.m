//
//  JSContext+LinkBlock.m
//  LinkBlockProgram
//
//  Created by NOVO on 16/6/21.
//  Copyright © 2016年 NOVO. All rights reserved.
//

#import "LinkBlock.h"

@implementation NSObject(JSContextLinkBlock)
- (JSValue *(^)(id))jsContextValue
{
    return ^id(id key){
        LinkHandle_REF(JSContext)
        LinkGroupHandle_REF(jsContextValue,key)
        return [_self objectForKeyedSubscript:key];
    };
}

- (JSContext *(^)(NSObject <NSCopying> *, id))jsContextSetValue
{
    return ^id(NSObject <NSCopying> * key , id value){
        LinkHandle_REF(JSContext)
        LinkGroupHandle_REF(jsContextSetValue,key,value)
        [_self setObject:value forKeyedSubscript:key];
        return _self;
    };
}

- (JSValue *(^)(NSString *))jsContextEval
{
    return ^id(NSString* script){
        LinkHandle_REF(JSContext)
        LinkGroupHandle_REF(jsContextEval,script)
        return [_self evaluateScript:script];
    };
}

- (JSValue *(^)(NSString *, NSArray *))jsContextCallFunc
{
    return ^id(NSString* func , NSArray* args){
        LinkHandle_REF(JSContext)
        LinkGroupHandle_REF(jsContextCallFunc,func,args)
        return [[_self objectForKeyedSubscript:func] callWithArguments:args];
    };
}

- (JSValue *(^)(NSString *,NSString* ))jsContextGetElementById
{
    return ^id(NSString* elementId,NSString* appendScript){
        LinkHandle_REF(JSContext)
        LinkGroupHandle_REF(jsContextGetElementById,elementId,appendScript)
        if([appendScript isKindOfClass:[NSString class]]){
            return [_self evaluateScript:[NSString stringWithFormat:@"document.getElementById(%@)%@",elementId,appendScript]];
        }else{
            return [_self evaluateScript:[NSString stringWithFormat:@"document.getElementById(%@)",elementId]];
        }
    };
}

- (JSValue *(^)(NSString *, NSString *))jsContextGetElementsByName
{
    return ^id(NSString* elementId,NSString* appendScript){
        LinkHandle_REF(JSContext)
        LinkGroupHandle_REF(jsContextGetElementsByName,elementId,appendScript)
        if([appendScript isKindOfClass:[NSString class]]){
            return [_self evaluateScript:[NSString stringWithFormat:@"document.getElementsByName(%@)%@",elementId,appendScript]];
        }else{
            return [_self evaluateScript:[NSString stringWithFormat:@"document.getElementsByName(%@)",elementId]];
        }
    };
}

- (JSValue *(^)(NSString *, NSString *))jsContextGetElementsByTagName
{
    return ^id(NSString* elementId,NSString* appendScript){
        LinkHandle_REF(JSContext)
        LinkGroupHandle_REF(jsContextGetElementsByTagName,elementId,appendScript)
        if([appendScript isKindOfClass:[NSString class]]){
            return [_self evaluateScript:[NSString stringWithFormat:@"document.getElementsByTagName(%@)%@",elementId,appendScript]];
        }else{
            return [_self evaluateScript:[NSString stringWithFormat:@"document.getElementsByTagName(%@)",elementId]];
        }
    };
}

- (JSContext *(^)(NSString *))jsContextWrite
{
    return ^id(NSString* str){
        LinkHandle_REF(JSContext)
        LinkGroupHandle_REF(jsContextWrite,str)
        [_self evaluateScript:[NSString stringWithFormat:@"document.write(%@)",str]];
        return _self;
    };
}

- (JSContext *(^)(NSString *))jsContextAlert
{
    return ^id(NSString* str){
        LinkHandle_REF(JSContext)
        LinkGroupHandle_REF(jsContextAlert,str)
        [_self evaluateScript:[NSString stringWithFormat:@"document.alert(%@)",str]];
        return _self;
    };
}

- (JSContext *(^)(void))jsContextHistoryBack
{
    return ^id(){
        LinkHandle_REF(JSContext)
        LinkGroupHandle_REF(jsContextHistoryBack)
        [_self evaluateScript:@"document.history.back()"];
        return _self;
    };
}

- (JSContext *(^)(void))jsContextHistoryForward
{
    return ^id(){
        LinkHandle_REF(JSContext)
        LinkGroupHandle_REF(jsContextHistoryForward)
        [_self evaluateScript:@"document.history.forward()"];
        return _self;
    };
}

- (JSContext *(^)(NSString* page))jsContextHistoryGo
{
    return ^id(NSString* page){
        LinkHandle_REF(JSContext)
        LinkGroupHandle_REF(jsContextHistoryGo,page)
        if(![page isKindOfClass:[NSString class]])  return _self;
        [_self evaluateScript:[NSString stringWithFormat:@"document.history.go(%@)",page]];
        return _self;
    };
}

- (NSString *(^)(void))jsContextTitle
{
    return ^id(){
        LinkHandle_REF(JSContext)
        LinkGroupHandle_REF(jsContextTitle)
        return [[_self evaluateScript:@"document.title"] toString];
    };
}

- (NSString *(^)(void))jsContextHTML
{
    return ^id(){
        LinkHandle_REF(JSContext)
        LinkGroupHandle_REF(jsContextHTML)
        return [[_self evaluateScript:@"document.documentElement.innerHTML"] toString];
    };
}

- (NSString *(^)(void))jsContextLocationHref
{
    return ^id(){
        LinkHandle_REF(JSContext)
        LinkGroupHandle_REF(jsContextLocationHref)
        return [[_self evaluateScript:@"window.location.href"] toString];
    };
}

- (JSContext *(^)(void))jsContextLocationReload
{
    return ^id(){
        LinkHandle_REF(JSContext)
        LinkGroupHandle_REF(jsContextLocationReload)
        [_self evaluateScript:@"window.location.reload()"];
        return _self;
    };
}

@end
