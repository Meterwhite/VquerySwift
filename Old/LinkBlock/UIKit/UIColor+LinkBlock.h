//
//  UIColor+LinkBlock.h

//
//  Created by NOVO on 15/8/18.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

@interface NSObject(UIColorLinkBlock)
#pragma mark - Foundation Mirror/镜像

#pragma mark - Foundation Speed/速度
@property LB_BK CGFloat          (^colorRed)(void);
@property LB_BK CGFloat          (^colorGreen)(void);
@property LB_BK CGFloat          (^colorBlue)(void);
@property LB_BK CGFloat          (^colorAlpha)(void);
@property LB_BK CGFloat          (^colorHue)(void);
@property LB_BK CGFloat          (^colorSaturation)(void);
@property LB_BK CGFloat          (^colorBrightness)(void);
/** 设置红色，return new obj */
@property LB_BK UIColor*         (^colorRedSet)(CGFloat value);
@property LB_BK UIColor*         (^colorGreenSet)(CGFloat value);
@property LB_BK UIColor*         (^colorBlueSet)(CGFloat value);
@property LB_BK UIColor*         (^colorAlphaSet)(CGFloat value);
/** 色调，return new obj */
@property LB_BK UIColor*         (^colorHueSet)(CGFloat value);
/** 饱和度，return new obj */
@property LB_BK UIColor*         (^colorSaturationSet)(CGFloat value);
/** 亮度，return new obj */
@property LB_BK UIColor*         (^colorBrightnessSet)(CGFloat value);

#pragma mark - Foundation Extend/补充

#pragma mark - Weak coding/弱类型编码
/** return @"0xF2F2F2"(prefix=@"0x")||NSNull */
@property LB_BK NSString*        (^colorToHexStringWithPrefix)(NSString* prefix);
/** 根据颜色创建图片 */
@property LB_BK UIImage*         (^colorToUIImage)(CGSize size);
/**
 *  作为背景色
 *  toObj∈{NSArray||{.respondsToSelector(setTextColor:,setTitleColor:forState:) }}
 */
@property LB_BK UIColor*         (^colorSetToUIBackground)(id toObj);
/**
 *  作为文本色
 *  toObj∈{NSArray||{.respondsToSelector(setTextColor:,setTitleColor:forState:) }}
 */
@property LB_BK UIColor*         (^colorSetToUIText)(id toObj);




#pragma mark - LinkBlock
/** <^(double percent)>调节亮度,percent ∈ [-1,1] */
@property LB_BK UIColor*         (^colorBrightnessPercent)(double percent);
/** 40% darker(close to original) */
@property LB_BK UIColor*         (^colorHighlightDarkColor)(void);
/** 40% light */
@property LB_BK UIColor*         (^colorHighlightLightColor)(void);

@end
