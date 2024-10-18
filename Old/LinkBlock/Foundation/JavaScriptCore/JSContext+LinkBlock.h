//
//  JSContext+LinkBlock.h
//  LinkBlockProgram
//
//  Created by NOVO on 16/6/21.
//  Copyright © 2016年 NOVO. All rights reserved.
//
#import "LinkBlockDefine.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface NSObject(JSContextLinkBlock)

#pragma mark - Foundation Speed/速度
@property LB_BK JSValue*     (^jsContextValue)(id key);
@property LB_BK JSContext*   (^jsContextSetValue)(NSObject <NSCopying> * key, id value);
@property LB_BK JSValue*     (^jsContextEval)(NSString* script);
@property LB_BK JSValue*     (^jsContextCallFunc)(NSString* func , NSArray* args);

#pragma mark - LinkBlock

@property LB_BK JSValue*     (^jsContextGetElementById)(NSString* elementId, NSString* appendScript);
@property LB_BK JSValue*     (^jsContextGetElementsByName)(NSString* name, NSString* appendScript);
@property LB_BK JSValue*     (^jsContextGetElementsByTagName)(NSString* tagName, NSString* appendScript);
@property LB_BK NSString*    (^jsContextTitle)(void);
@property LB_BK NSString*    (^jsContextHTML)(void);
@property LB_BK NSString*    (^jsContextLocationHref)(void);
@property LB_BK JSContext*   (^jsContextLocationReload)(void);
@property LB_BK JSContext*   (^jsContextWrite)(NSString* str);
@property LB_BK JSContext*   (^jsContextAlert)(NSString* str);
@property LB_BK JSContext*   (^jsContextHistoryBack)(void);
@property LB_BK JSContext*   (^jsContextHistoryForward)(void);
/** page ∈ {-1,0,1,2...} */
@property LB_BK JSContext*   (^jsContextHistoryGo)(NSString* page);
@end
