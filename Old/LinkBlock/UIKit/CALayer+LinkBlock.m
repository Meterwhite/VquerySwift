//
//  CALayer+LinkBlock.m
//  LinkBlockProgram
//
//  Created by NOVO on 16/5/19.
//  Copyright © 2016年 NOVO. All rights reserved.
//

#import "LinkBlock.h"

@implementation NSObject(CALayerLinkBlock)
- (CALayer *(^)(CALayer *))layerAddSublayer
{
    return ^id(CALayer* layer){
        
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerAddSublayer,layer)
        [_self addSublayer:layer];
        return _self;
    };
}

- (CALayer *(^)(CALayer *, unsigned int))layerInsertSublayerAt
{
    return ^id(CALayer* layer,unsigned idx){
        
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerInsertSublayerAt,layer,idx)
        [_self insertSublayer:layer atIndex:idx];
        return _self;
    };
}

- (CALayer *(^)(CALayer *, CALayer *))layerInsertSublayerBelow
{
    return ^id(CALayer* layer,CALayer* sibling){
        
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerInsertSublayerBelow,layer,sibling)
        [_self insertSublayer:layer below:sibling];
        return _self;
    };
}

- (CALayer *(^)(CALayer *, CALayer *))layerInsertSublayerAbove
{
    return ^id(CALayer* layer,CALayer* sibling){
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerInsertSublayerAbove,layer,sibling)
        [_self insertSublayer:layer above:sibling];
        return _self;
    };
}

- (CALayer *(^)(CALayer *, CALayer *))layerReplaceSublayerWithLayer
{
    return ^id(CALayer* layer,CALayer* newLayer){
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerReplaceSublayerWithLayer,layer,newLayer)
        [_self replaceSublayer:layer with:newLayer];
        return _self;
    };
}

- (CALayer *(^)(CAAnimation *, NSString *))layerAddAnimationWithKey
{
    return ^id(CAAnimation* animation , NSString* key){
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerAddAnimationWithKey,animation,key)
        [_self addAnimation:animation forKey:key];
        return _self;
    };
}

- (CALayer *(^)(CAAnimation *))layerAddAnimation
{
    return ^id(CAAnimation* animation){
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerAddAnimation,animation)
        [_self addAnimation:animation forKey:nil];
        return _self;
    };
}

- (CALayer *(^)(void))layerRemoveAllAnimations
{
    return ^id(){
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerRemoveAllAnimations)
        [_self removeAllAnimations];
        return _self;
    };
}

- (CALayer *(^)(NSString *))layerRemoveAnimationForKey
{
    return ^id(NSString* key){
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerRemoveAnimationForKey, key )
        [_self removeAnimationForKey:key];
        return _self;
    };
}

- (CALayer *(^)(CGFloat))layerCornerRadius
{
    return ^id(CGFloat cornerRadius){
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerCornerRadius, cornerRadius )
        _self.cornerRadius = cornerRadius;
        return _self;
    };
}

- (CALayer *(^)(CGFloat))layerBorderWidth
{
    return ^id(CGFloat borderWidth){
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerBorderWidth, borderWidth )
        _self.borderWidth = borderWidth;
        return _self;
    };
}

- (CALayer *(^)(UIColor *))layerBorderColor
{
    return ^id(UIColor* color){
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerBorderColor, color )
        _self.borderColor = color.CGColor;
        return _self;
    };
}

- (CALayer *(^)(UIColor *))layerBGColor
{
    return ^id(UIColor* color){
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerBGColor, color )
        _self.backgroundColor = color.CGColor;
        return _self;
    };
}

- (CALayer *(^)(CALayer *))layerMask
{
    return ^id(CALayer* mask){
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerMask, mask )
        _self.mask = mask;
        return _self;
    };
}

- (CALayer *(^)(UIColor *))layerShadowColor
{
    return ^id(UIColor* color){
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerShadowColor, color)
        _self.shadowColor = color.CGColor;
        return _self;
    };
}

- (CALayer *(^)(float))layerShadowOpacity
{
    return ^id(float shadowOpacity){
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerShadowOpacity, shadowOpacity)
        _self.shadowOpacity = shadowOpacity;
        return _self;
    };
}

- (CALayer *(^)(CGFloat,CGFloat))layerShadowOffset
{
    return ^id(CGFloat width , CGFloat height){
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerShadowOffset,width,height)
        _self.shadowOffset = CGSizeMake(width, height);
        return _self;
    };
}

- (CALayer *(^)(CGFloat))layerShadowRadius
{
    return ^id(CGFloat shadowRadius){
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerShadowRadius, shadowRadius)
        _self.shadowRadius = shadowRadius;
        return _self;
    };
}

- (CALayer *(^)(CGPathRef))layerShadowPath
{
    return ^id(CGPathRef shadowPath){
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerShadowPath, shadowPath)
        _self.shadowPath = shadowPath;
        return _self;
    };
}

- (CALayer *(^)(CGFloat,CGFloat,CGFloat,CGFloat))layerSetBounds
{
    return ^id(CGFloat x,CGFloat y, CGFloat width, CGFloat height){
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerSetBounds,x,y,width,height)
        _self.bounds = CGRectMake(x, y, width, height);
        return _self;
    };
}

- (CALayer *(^)(CGFloat,CGFloat))layerSetPosition
{
    return ^id(CGFloat x,CGFloat y){
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerSetPosition, x,y)
        _self.position = CGPointMake(x, y);
        return _self;
    };
}

- (CALayer *(^)(CGFloat,CGFloat,CGFloat,CGFloat))layerSetFrame
{
    return ^id(CGFloat x,CGFloat y, CGFloat width, CGFloat height){
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerSetFrame,x,y,width,height)
        _self.frame = CGRectMake(x, y, width, height);
        return _self;
    };
}

- (CALayer *(^)(CGFloat, CGFloat))layerSetAnchorPoint
{
    return ^id(CGFloat x,CGFloat y){
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerSetAnchorPoint, x,y)
        _self.anchorPoint = CGPointMake(x, y);
        return _self;
    };
}

- (CALayer *(^)(CATransform3D))layerSetTransform
{
    return ^id(CATransform3D transform){
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerSetTransform, transform)
        _self.transform = transform;
        return _self;
    };
}

- (UIView *(^)(CGFloat))layerSetX
{
    return ^id(CGFloat x){
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerSetX,x)
        CGRect frame = _self.frame;
        frame.origin.x = x;
        _self.frame = frame;
        return _self;
    };
}

- (UIView *(^)(CGFloat))layerSetY
{
    return ^id(CGFloat y){
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerSetY,y)
        CGRect frame = _self.frame;
        frame.origin.y = y;
        _self.frame = frame;
        return _self;
    };
}

- (UIView *(^)(CGFloat))layerSetWidth
{
    return ^id(CGFloat width){
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerSetWidth,width)
        CGRect frame= _self.frame;
        frame.size.width= width;
        _self.frame= frame;
        return _self;
    };
}

- (UIView *(^)(CGFloat))layerSetHeight
{
    return ^id(CGFloat height){
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerSetHeight,height)
        CGRect frame= _self.frame;
        frame.size.height= height;
        _self.frame= frame;
        return _self;
    };
}

- (UIView *(^)(CGFloat,CGFloat))layerSetSize
{
    return ^id(CGFloat width, CGFloat height){
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerSetSize,width,height)
        CGRect frame= _self.frame;
        frame.size.width= width;
        frame.size.height= height;
        _self.frame= frame;
        return _self;
    };
}

- (UIView *(^)(CGFloat,CGFloat))layerSetOrigin
{
    return ^id(CGFloat x,CGFloat y){
        LinkHandle_REF(CALayer)
        LinkGroupHandle_REF(layerSetOrigin,x,y)
        CGRect frame= _self.frame;
        frame.origin.x= x;
        frame.origin.y= y;
        _self.frame= frame;
        return _self;
    };
}
@end
