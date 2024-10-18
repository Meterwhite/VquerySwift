//
//  UIWebView+LinkBlock.h
//  LinkBlockProgram
//
//  Created by NOVO on 16/6/22.
//  Copyright © 2016年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

#define UIWebViewNew ([UIWebView new])

@class JSContext;
@interface NSObject(UIWebViewLinkBlock)

#pragma mark - Foundation Speed/速度
@property LB_BK JSContext*      (^webViewContext)(void);
@property LB_BK NSString*       (^webViewEvalScript)(NSString* script);
@property LB_BK NSString*       (^webViewTitle)(void);
@property LB_BK NSString*       (^webViewLocationHref)(void);
@property LB_BK NSString*       (^webViewHTML)(void);

@end
