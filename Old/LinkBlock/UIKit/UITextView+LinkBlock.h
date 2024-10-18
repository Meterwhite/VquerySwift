//
//  UITextView+LinkBlock.h
//  LinkBlockProgram
//
//  Created by NOVO on 16/8/16.
//  Copyright © 2016年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

#define UITextViewNew ([UITextView new])
@interface NSObject(UITextViewLinkBlock)
#pragma mark - Foundation Mirror/镜像
@property LB_BK UITextView*        (^txtViewText)(NSString* text);
@property LB_BK UITextView*        (^txtViewAttributedText)(NSAttributedString* attributedText);
@property LB_BK UITextView*        (^txtViewTextColor)(UIColor* textColor);
@property LB_BK UITextView*        (^txtViewFont)(UIFont* font);
@property LB_BK UITextView*        (^txtViewTextAlignment)(NSTextAlignment textAlignment);
@property LB_BK UITextView*        (^txtViewEditable)(BOOL b);
@property LB_BK UITextView*        (^txtViewSelectable)(BOOL b);


#pragma mark - Foundation Speed/速度
@property LB_BK UITextView*        (^txtViewSelectRangeSet)(NSRange range);
@property LB_BK NSRange            (^txtViewSelectRangeGet)(void);

@end
