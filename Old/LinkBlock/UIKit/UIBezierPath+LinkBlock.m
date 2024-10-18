//
//  UIBezierPath+LinkBlock.m
//  LinkBlockProgram
//
//  Created by NOVO on 16/5/17.
//  Copyright © 2016年 NOVO. All rights reserved.
//

#import "LinkBlock.h"

@implementation NSObject(UIBezierPathLinkBlock)
- (UIBezierPath *(^)(CGFloat))bezierPathSetLineWidth
{
    return ^id(CGFloat lineWidth){
        LinkHandle_REF(UIBezierPath)
        LinkGroupHandle_REF(bezierPathSetLineWidth,lineWidth)
        _self.lineWidth = lineWidth;
        return _self;
    };
}

- (UIBezierPath *(^)(CGLineCap))bezierPathSetLineCapStyle
{
    return ^id(CGLineCap lineCapStyle){
        LinkHandle_REF(UIBezierPath)
        LinkGroupHandle_REF(bezierPathSetLineCapStyle,lineCapStyle)
        _self.lineCapStyle = lineCapStyle;
        return _self;
    };
}

- (UIBezierPath *(^)(CGLineJoin))bezierPathSetLineJoinStyle
{
    return ^id(CGLineJoin lineJoinStyle){
        LinkHandle_REF(UIBezierPath)
        _self.lineJoinStyle = lineJoinStyle;
        return _self;
    };
}

- (UIBezierPath *(^)(CGFloat))bezierPathSetMiterLimit
{
    return ^id(CGFloat miterLimit){
        LinkHandle_REF(UIBezierPath)
        _self.miterLimit = miterLimit;
        return _self;
    };
}

- (UIBezierPath *(^)(CGFloat))bezierPathSetFlatness
{
    return ^id(CGFloat flatness){
        LinkHandle_REF(UIBezierPath)
        _self.flatness = flatness;
        return _self;
    };
}

- (UIBezierPath *(^)(CGPoint))bezierPathMoveToPoint
{
    return ^id(CGPoint point){
        LinkHandle_REF(UIBezierPath)
        [_self moveToPoint:point];
        return _self;
    };
}

- (UIBezierPath *(^)(CGPoint))bezierPathAddLineToPoint
{
    return ^id(CGPoint point){
        LinkHandle_REF(UIBezierPath)
        [_self addLineToPoint:point];
        return _self;
    };
}

- (UIBezierPath *(^)(CGPoint, CGPoint, CGPoint))bezierPathAddCurveToPoint
{
    return ^id(CGPoint endPoint,CGPoint controlPoint1,CGPoint controlPoint2){
        LinkHandle_REF(UIBezierPath)
        [_self addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
        return _self;
    };
}

- (UIBezierPath *(^)(CGPoint, CGPoint))bezierPathAddQuadCurveToPoint
{
    return ^id(CGPoint endPoint,CGPoint controlPoint){
        LinkHandle_REF(UIBezierPath)
        [_self addQuadCurveToPoint:endPoint controlPoint:controlPoint];
        return _self;
    };
}

- (UIBezierPath *(^)(CGPoint, CGFloat, CGFloat, CGFloat, BOOL))bezierPathAddArcWithCenter
{
    return ^id(CGPoint center,CGFloat radius,CGFloat startAngle,CGFloat endAngle,BOOL clockwise){
        LinkHandle_REF(UIBezierPath)
        [_self addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
        return _self;
    };
}

- (UIBezierPath *(^)(void))bezierPathClosePath
{
    return ^id(){
        LinkHandle_REF(UIBezierPath)
        [_self closePath];
        return _self;
    };
}

- (UIBezierPath *(^)(void))bezierPathRemoveAllPoints
{
    return ^id(){
        LinkHandle_REF(UIBezierPath)
        [_self removeAllPoints];
        return _self;
    };
}

- (UIBezierPath *(^)(UIBezierPath *))bezierPathAppendPath
{
    return ^id(UIBezierPath* aPath){
        LinkHandle_REF(UIBezierPath)
        [_self appendPath:aPath];
        return _self;
    };
}

- (UIBezierPath *(^)(void))bezierPathByReversingPath
{
    return ^id(){
        LinkHandle_REF(UIBezierPath)
        return [_self bezierPathByReversingPath];
    };
}

- (BOOL (^)(CGPoint))bezierPathContainsPoint
{
    return ^(CGPoint point){
        LinkHandle_VAL_IFNOT(UIBezierPath){
            return NO;
        }
        return [_self containsPoint:point];
    };
}

- (UIBezierPath *(^)(void))bezierPathFill
{
    return ^id(){
        LinkHandle_REF(UIBezierPath)
        [_self fill];
        return _self;
    };
}

- (UIBezierPath *(^)(void))bezierPathStroke
{
    return ^id(){
        LinkHandle_REF(UIBezierPath)
        [_self stroke];
        return _self;
    };
}

- (UIBezierPath *(^)(void))bezierPathAddClip
{
    return ^id(){
        LinkHandle_REF(UIBezierPath)
        [_self addClip];
        return _self;
    };
}

@end
