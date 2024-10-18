//
//  CALayer+LinkBlock.h
//  LinkBlockProgram
//
//  Created by NOVO on 16/5/19.
//  Copyright © 2016年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

#ifndef CALayerNew
#define CALayerNew ([CALayer layer])
#endif
@interface  NSObject(CALayerLinkBlock)

#pragma mark - Foundation Mirror/镜像
@property LB_BK CALayer*     (^layerSetBounds)(CGFloat x,CGFloat y, CGFloat width, CGFloat height);
@property LB_BK CALayer*     (^layerSetPosition)(CGFloat x,CGFloat y);
@property LB_BK CALayer*     (^layerSetFrame)(CGFloat x,CGFloat y, CGFloat width, CGFloat height);
@property LB_BK CALayer*     (^layerSetAnchorPoint)(CGFloat x,CGFloat y);
@property LB_BK CALayer*     (^layerSetTransform)(CATransform3D transform);
@property LB_BK UIView*      (^layerSetOrigin)(CGFloat x,CGFloat y);
@property LB_BK UIView*      (^layerSetSize)(CGFloat width, CGFloat height);
@property LB_BK CALayer*     (^layerAddSublayer)(CALayer* layer);
@property LB_BK CALayer*     (^layerInsertSublayerAt)(CALayer* layer,unsigned idx);
@property LB_BK CALayer*     (^layerInsertSublayerBelow)(CALayer* layer,CALayer* sibling);
@property LB_BK CALayer*     (^layerInsertSublayerAbove)(CALayer* layer,CALayer* sibling);
@property LB_BK CALayer*     (^layerReplaceSublayerWithLayer)(CALayer* layer,CALayer* newLayer);
@property LB_BK CALayer*     (^layerAddAnimation)(CAAnimation* animation);
@property LB_BK CALayer*     (^layerAddAnimationWithKey)(CAAnimation* animation , NSString* key);
@property LB_BK CALayer*     (^layerRemoveAllAnimations)(void);
@property LB_BK CALayer*     (^layerRemoveAnimationForKey)(NSString* key);
@property LB_BK CALayer*     (^layerCornerRadius)(CGFloat cornerRadius);
@property LB_BK CALayer*     (^layerBorderWidth)(CGFloat borderWidth);
@property LB_BK CALayer*     (^layerBorderColor)(UIColor* color);
@property LB_BK CALayer*     (^layerBGColor)(UIColor* color);
@property LB_BK CALayer*     (^layerMask)(CALayer* mask);
@property LB_BK CALayer*     (^layerShadowColor)(UIColor* color);
@property LB_BK CALayer*     (^layerShadowOpacity)(float shadowOpacity);
@property LB_BK CALayer*     (^layerShadowOffset)(CGFloat width , CGFloat height);
@property LB_BK CALayer*     (^layerShadowRadius)(CGFloat shadowRadius);
@property LB_BK CALayer*     (^layerShadowPath)(CGPathRef shadowPath);

#pragma mark - Foundation Speed/速度
@property LB_BK UIView*      (^layerSetX)(CGFloat x);
@property LB_BK UIView*      (^layerSetY)(CGFloat y);
@property LB_BK UIView*      (^layerSetWidth)(CGFloat width);
@property LB_BK UIView*      (^layerSetHeight)(CGFloat height);

@end
