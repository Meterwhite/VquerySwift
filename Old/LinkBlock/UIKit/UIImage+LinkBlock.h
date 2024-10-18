//
//  UIImage+LinkBlock.h
//
//  Created by NOVO on 15/8/12.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

@interface NSObject(UIImageLinkBlock)

#pragma mark - Foundation Speed/速度
/** Stretch image */
@property LB_BK UIImage*        (^imgResizableWithCapInsets)(CGFloat top,CGFloat left,CGFloat bottom, CGFloat right);
/** Stretch image */
@property LB_BK UIImage*        (^imgStretchableImageWithLeftCapWidthAndTopCapHeight)(CGFloat lWidth,CGFloat tHeight);
#pragma mark - Foundation Extend/补充
/** get color from image/图片取色 */
@property LB_BK UIColor*         (^imgGetPatternColor)(void);
/** Fix Orientation/矫正照片方向 */
@property LB_BK UIImage*         (^imgOrientationFix)(void);

#pragma mark - Weak coding/弱类型编码
@property LB_BK UIImageView*     (^imgToUIImageView)(void);
/**
 *  control∈{.respondsToSelector(setImage:,setImage:forState:,setBackground:,setBackgroundImage:)}
 *  forState = UIControlStateNormal
 */
@property LB_BK UIImage*         (^imgSetToControl)(id control);
@property LB_BK NSObject*        (^imgSetToControlAsWhatSet)(id container);




#pragma mark - LinkBlock
/**
 *  @ ratio: 仅仅针对JPEG格式有效的压缩质量
 */
@property LB_BK NSData*          (^imgToData)(float ratio);
@property LB_BK UIImage*         (^imgResizeAspect)(CGSize maxSize);
@property LB_BK UIImage*         (^imgCut)(CGRect frame);
/** Gaussian blur/高斯模糊 note:need 'Accelerate.framework' */
@property LB_BK UIImage*         (^imgBlurColor)(UIColor* tintColor);
@property LB_BK UIImage*         (^imgBlurLight)(void);
/**
 Can change the degree of blur
 @param blurRadius value>0
 */
@property LB_BK UIImage*         (^imgBlurLightRadius)(float blurRadius);
@property LB_BK UIImage*         (^imgBlurExtraLight)(void);
@property LB_BK UIImage*         (^imgBlurDarkEffect)(void);
@property LB_BK UIImage*         (^imgRenderingMode)(UIImageRenderingMode mode);
/** Watermark/水印 */
@property LB_BK UIImage*         (^imgAddImg)(UIImage* aImg , CGRect rect);


@end
