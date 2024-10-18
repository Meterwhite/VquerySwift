//
//  UIButton+LinkBlock.h
//
//  Created by NOVO on 15/8/19.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"


#define UIButtonNew ([UIButton buttonWithType:UIButtonTypeCustom])

@interface NSObject(UIButtonLinkBlock)

#pragma mark - Foundation Mirror/镜像
@property LB_BK UIButton* (^btnTitle)(NSString* title, UIControlState state);
@property LB_BK UIButton* (^btnTitleEdgeInsets)(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);
@property LB_BK UIButton* (^btnImageEdgeInsets)(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);
@property LB_BK UIButton* (^btnTitleColor)(UIColor* color , UIControlState state);
@property LB_BK UIButton* (^btnImage)(UIImage* img, UIControlState state);
@property LB_BK UIButton* (^btnBGImage)(UIImage* img, UIControlState state);
@property LB_BK UIButton* (^btnAttributeTitle)(NSAttributedString* attrStr, UIControlState state);



#pragma mark - Foundation Speed/速度
@property LB_BK UIButton* (^btnTitleUIControlStateNormal)(NSString* title);
@property LB_BK UIButton* (^btnTitleUIControlStateHighlighted)(NSString* title);
@property LB_BK UIButton* (^btnTitleUIControlStateDisabled)(NSString* title);
@property LB_BK UIButton* (^btnTitleUIControlStateSelected)(NSString* title);
@property LB_BK UIButton* (^btnTitleUIControlStateFocused)(NSString* title);
@property LB_BK UIButton* (^btnTitleUIControlStateApplication)(NSString* title);
@property LB_BK UIButton* (^btnTitleUIControlStateReserved)(NSString* title);
@property LB_BK UIButton* (^btnTitleColorUIControlStateNormal)(UIColor* color);
@property LB_BK UIButton* (^btnTitleColorUIControlStateHighlighted)(UIColor* color);
@property LB_BK UIButton* (^btnBGImageUIControlStateNormal)(UIImage* img);
@property LB_BK UIButton* (^btnBGImageUIControlStateHighlighted)(UIImage* img);
@property LB_BK UIButton* (^btnBGImageUIControlStateDisabled)(UIImage* img);
@property LB_BK UIButton* (^btnBGImageUIControlStateSelected)(UIImage* img);
@property LB_BK UIButton* (^btnBGImageUIControlStateFocused)(UIImage* img);
@property LB_BK UIButton* (^btnBGImageUIControlStateApplication)(UIImage* img);
@property LB_BK UIButton* (^btnBGImageUIControlStateReserved)(UIImage* img);
@property LB_BK UIButton* (^btnTitleColorUIControlStateDisabled)(UIColor* color);
@property LB_BK UIButton* (^btnTitleColorUIControlStateSelected)(UIColor* color);
@property LB_BK UIButton* (^btnTitleColorUIControlStateFocused)(UIColor* color);
@property LB_BK UIButton* (^btnTitleColorUIControlStateApplication)(UIColor* color);
@property LB_BK UIButton* (^btnTitleColorUIControlStateReserved)(UIColor* color);
@property LB_BK UIButton* (^btnImageUIControlStateNormal)(UIImage* img);
@property LB_BK UIButton* (^btnImageUIControlStateHighlighted)(UIImage* img);
@property LB_BK UIButton* (^btnImageUIControlStateDisabled)(UIImage* img);
@property LB_BK UIButton* (^btnImageUIControlStateSelected)(UIImage* img);
@property LB_BK UIButton* (^btnImageUIControlStateFocused)(UIImage* img);
@property LB_BK UIButton* (^btnImageUIControlStateApplication)(UIImage* img);
@property LB_BK UIButton* (^btnImageUIControlStateReserved)(UIImage* img);



#pragma mark - Foundation Extend/补充
@property LB_BK UIButton* (^btnTitleFont)(UIFont* font);
@property LB_BK UIButton* (^btnTitleFontSystemSizeSet)(CGFloat size);
@property LB_BK CGFloat   (^btnTitleFontSystemSizeGet)(void);



#pragma mark - LinkBlock
/** 40% light than NormalState */
@property LB_BK UIButton* (^btnHighlightedTitleColorLightByNormalState)(void);
/** 40% darker than NormalState */
@property LB_BK UIButton* (^btnHighlightedTitleColorDarkByNormalState)(void);

@end




@interface UIButton(UIButtonLinkBlock)
/**
 *  extend touch range
 */
@property LB_BK UIButton* (^btnExtensionOfTouchSide)(UIEdgeInsets insets);
@property LB_BK UIButton* (^btnExtensionOfTouchRects)(NSArray<NSString*>* rects);
@end

