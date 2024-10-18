//
//  CAShapeLayer+LinkBlock.m
//  LinkBlockProgram
//
//  Created by NOVO on 16/5/19.
//  Copyright © 2016年 NOVO. All rights reserved.
//

#import "LinkBlock.h"

@implementation NSObject(CAShapeLayerLinkBlock)
- (CAShapeLayer *(^)(UIBezierPath *))sharpLayerSetPath
{
    return ^id(UIBezierPath* path){
        LinkHandle_REF(CAShapeLayer)
        LinkGroupHandle_REF(sharpLayerSetPath,path)
        _self.path = path.CGPath;
        return _self;
    };
}

- (CAShapeLayer *(^)(UIColor *))sharpLayerSetFillColor
{
    return ^id(UIColor* color){
        LinkHandle_REF(CAShapeLayer)
        LinkGroupHandle_REF(sharpLayerSetFillColor,color)
        _self.fillColor = color.CGColor;
        return _self;
    };
}

- (CAShapeLayer *(^)(UIColor *))sharpLayerSetStrokeColor
{
    return ^id(UIColor* color){
        LinkHandle_REF(CAShapeLayer)
        LinkGroupHandle_REF(sharpLayerSetStrokeColor,color)
        _self.strokeColor = color.CGColor;
        return _self;
    };
}

- (CAShapeLayer *(^)(NSString *))sharpLayerSetFillRule
{
    return ^id(NSString* fillRule){
        LinkHandle_REF(CAShapeLayer)
        LinkGroupHandle_REF(sharpLayerSetFillRule,fillRule)
        _self.fillRule = fillRule;
        return _self;
    };
}

- (CAShapeLayer *(^)(CGFloat))sharpLayerSetStrokeStart
{
    return ^id(CGFloat strokeStart){
        LinkHandle_REF(CAShapeLayer)
        LinkGroupHandle_REF(sharpLayerSetStrokeStart,strokeStart)
        _self.strokeStart = strokeStart;
        return _self;
    };
}

- (CAShapeLayer *(^)(CGFloat))sharpLayerSetStrokeEnd
{
    return ^id(CGFloat strokeEnd){
        LinkHandle_REF(CAShapeLayer)
        LinkGroupHandle_REF(sharpLayerSetStrokeEnd,strokeEnd)
        _self.strokeEnd = strokeEnd;
        return _self;
    };
}

- (CAShapeLayer *(^)(CGFloat))sharpLayerSetLineWidth
{
    return ^id(CGFloat lineWidth){
        LinkHandle_REF(CAShapeLayer)
        LinkGroupHandle_REF(sharpLayerSetLineWidth,lineWidth)
        _self.lineWidth = lineWidth;
        return _self;
    };
}

- (CAShapeLayer *(^)(CGFloat))sharpLayerSetMiterLimit
{
    return ^id(CGFloat miterLimit){
        LinkHandle_REF(CAShapeLayer)
        LinkGroupHandle_REF(sharpLayerSetMiterLimit,miterLimit)
        _self.miterLimit = miterLimit;
        return _self;
    };
}

- (CAShapeLayer *(^)(NSString *))sharpLayerSetLineCap
{
    return ^id(NSString* lineCap){
        LinkHandle_REF(CAShapeLayer)
        LinkGroupHandle_REF(sharpLayerSetLineCap,lineCap)
        _self.lineCap = lineCap;
        return _self;
    };
}

- (CAShapeLayer *(^)(NSString *))sharpLayerSetLineJoin
{
    return ^id(NSString* lineJoin){
        LinkHandle_REF(CAShapeLayer)
        LinkGroupHandle_REF(sharpLayerSetLineJoin,lineJoin)
        _self.lineJoin = lineJoin;
        return _self;
    };
}

- (CAShapeLayer *(^)(CGFloat))sharpLayerSetLineDashPhase
{
    return ^id(CGFloat lineDashPhase){
        LinkHandle_REF(CAShapeLayer)
        LinkGroupHandle_REF(sharpLayerSetLineDashPhase,lineDashPhase)
        _self.lineDashPhase = lineDashPhase;
        return _self;
    };
}

- (CAShapeLayer *(^)(NSArray<NSNumber *> *))sharpLayerSetLineDashPattern
{
    return ^id(NSArray<NSNumber *> *lineDashPattern){
        LinkHandle_REF(CAShapeLayer)
        LinkGroupHandle_REF(sharpLayerSetLineDashPattern,lineDashPattern)
        _self.lineDashPattern = lineDashPattern;
        return _self;
    };
}

@end
