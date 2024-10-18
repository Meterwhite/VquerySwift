//
//  CAShapeLayer+LinkBlock.h
//  LinkBlockProgram
//
//  Created by NOVO on 16/5/19.
//  Copyright © 2016年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

#ifndef CAShapeLayerNew
#define CAShapeLayerNew ([CAShapeLayer layer])
#endif
@interface  NSObject(CAShapeLayerLinkBlock)

#pragma mark - Foundation Mirror/镜像
@property LB_BK CAShapeLayer*    (^sharpLayerSetPath)(UIBezierPath* path);
@property LB_BK CAShapeLayer*    (^sharpLayerSetFillColor)(UIColor* color);
@property LB_BK CAShapeLayer*    (^sharpLayerSetStrokeColor)(UIColor* color);
@property LB_BK CAShapeLayer*    (^sharpLayerSetFillRule)(NSString *fillRule);
@property LB_BK CAShapeLayer*    (^sharpLayerSetStrokeStart)(CGFloat strokeStart);
@property LB_BK CAShapeLayer*    (^sharpLayerSetStrokeEnd)(CGFloat strokeEnd);
@property LB_BK CAShapeLayer*    (^sharpLayerSetLineWidth)(CGFloat lineWidth);
@property LB_BK CAShapeLayer*    (^sharpLayerSetMiterLimit)(CGFloat miterLimit);
@property LB_BK CAShapeLayer*    (^sharpLayerSetLineCap)(NSString* lineCap);
@property LB_BK CAShapeLayer*    (^sharpLayerSetLineJoin)(NSString* lineJoin);
@property LB_BK CAShapeLayer*    (^sharpLayerSetLineDashPhase)(CGFloat lineDashPhase);
@property LB_BK CAShapeLayer*    (^sharpLayerSetLineDashPattern)(NSArray<NSNumber *> *lineDashPattern);
@end
