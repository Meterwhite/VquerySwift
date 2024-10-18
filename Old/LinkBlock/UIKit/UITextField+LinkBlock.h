//
//  UITextField+LinkBlock.h
//  LinkBlockProgram
//
//  Created by NOVO on 16/1/29.
//  Copyright © 2016年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

#define UITextFieldNew ([UITextField new])

@interface NSObject(UITextFieldLinkBlock)

#pragma mark - Foundation Mirror/镜像

@property LB_BK UITextField*        (^txtFieldText)(NSString* text);
@property LB_BK UITextField*        (^txtFieldAttributedText)(NSAttributedString* attributedText);
@property LB_BK UITextField*        (^txtFieldTextColor)(UIColor* textColor);
@property LB_BK UITextField*        (^txtFieldFont)(UIFont* font);
@property LB_BK UITextField*        (^txtFieldTextAlignment)(NSTextAlignment textAlignment);
@property LB_BK UITextField*        (^txtFieldPlaceholder)(NSString* placeholder);
@property LB_BK UITextField*        (^txtFieldAttributedPlaceholder)(NSAttributedString* attributedPlaceholder);


#pragma mark - Foundation Speed/速度

@property LB_BK UITextField*        (^txtFieldPlaceholdColor)(UIColor* color);
@property LB_BK UITextField*        (^txtFieldSelectRangeSet)(NSRange range);
@property LB_BK NSRange             (^txtFieldSelectRangeGet)(void);


@end
