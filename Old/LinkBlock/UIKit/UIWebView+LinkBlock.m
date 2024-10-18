//
//  UIWebView+LinkBlock.m
//  LinkBlockProgram
//
//  Created by NOVO on 16/6/22.
//  Copyright © 2016年 NOVO. All rights reserved.
//

#import "LinkBlock.h"

@implementation NSObject(UIWebViewLinkBlock)
- (JSContext *(^)(void))webViewContext
{
    return ^id(){
        LinkHandle_REF(UIWebView)
        LinkGroupHandle_REF(webViewContext)
        return [_self valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    };
}

- (NSString *(^)(void))webViewTitle
{
    return ^id(){
        LinkHandle_REF(UIWebView)
        LinkGroupHandle_REF(webViewTitle)
        return [_self stringByEvaluatingJavaScriptFromString:@"document.title"];
    };
}

- (NSString *(^)(void))webViewLocationHref
{
    return ^id(){
        LinkHandle_REF(UIWebView)
        LinkGroupHandle_REF(webViewLocationHref)
        return [_self stringByEvaluatingJavaScriptFromString:@"window.location.href"];
    };
}

- (NSString *(^)(NSString* ))webViewEvalScript
{
    return ^id(NSString* script){
        LinkHandle_REF(UIWebView)
        LinkGroupHandle_REF(webViewEvalScript,script)
        return [_self stringByEvaluatingJavaScriptFromString:script];
    };
}

- (NSString *(^)(void))webViewHTML
{
    return ^id(){
        LinkHandle_REF(UIWebView)
        LinkGroupHandle_REF(webViewHTML)
        return [_self stringByEvaluatingJavaScriptFromString:@"document.documentElement.innerHTML"];
    };
}

@end
