//
//  UIBezierPath+LinkBlock.h
//  LinkBlockProgram
//
//  Created by NOVO on 16/5/17.
//  Copyright © 2016年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

#ifndef UIBezierPathNew
#define UIBezierPathNew ([UIBezierPath bezierPath])
#endif
@interface NSObject(UIBezierPathLinkBlock)

#pragma mark - Foundation Mirror/镜像
@property LB_BK UIBezierPath*    (^bezierPathSetLineWidth)(CGFloat lineWidth);
@property LB_BK UIBezierPath*    (^bezierPathSetLineCapStyle)(CGLineCap lineCapStyle);
@property LB_BK UIBezierPath*    (^bezierPathSetLineJoinStyle)(CGLineJoin lineJoinStyle);
@property LB_BK UIBezierPath*    (^bezierPathSetMiterLimit)(CGFloat miterLimit);
@property LB_BK UIBezierPath*    (^bezierPathSetFlatness)(CGFloat flatness);
@property LB_BK UIBezierPath*    (^bezierPathMoveToPoint)(CGPoint point);
@property LB_BK UIBezierPath*    (^bezierPathAddLineToPoint)(CGPoint point);
@property LB_BK UIBezierPath*    (^bezierPathAddCurveToPoint)(CGPoint endPoint,CGPoint controlPoint1,CGPoint controlPoint2);
@property LB_BK UIBezierPath*    (^bezierPathAddQuadCurveToPoint)(CGPoint endPoint,CGPoint controlPoint);
@property LB_BK UIBezierPath*    (^bezierPathAddArcWithCenter)(CGPoint center,CGFloat radius,CGFloat startAngle,CGFloat endAngle,BOOL clockwise);
@property LB_BK UIBezierPath*    (^bezierPathClosePath)(void);
@property LB_BK UIBezierPath*    (^bezierPathRemoveAllPoints)(void);
@property LB_BK UIBezierPath*    (^bezierPathAppendPath)(UIBezierPath* aPath);
@property LB_BK UIBezierPath*    (^bezierPathByReversingPath)(void) NS_AVAILABLE_IOS(6_0);
@property LB_BK BOOL             (^bezierPathContainsPoint)(CGPoint point);
@property LB_BK UIBezierPath*    (^bezierPathFill)(void);
@property LB_BK UIBezierPath*    (^bezierPathStroke)(void);
@property LB_BK UIBezierPath*    (^bezierPathAddClip)(void);
@end
