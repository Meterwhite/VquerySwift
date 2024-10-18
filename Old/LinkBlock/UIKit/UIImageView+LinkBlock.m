//
//  UIImageView+LinkBlock.m
//  LinkBlockProgram
//
//  Created by NOVO on 15/8/30.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlock.h"

@implementation NSObject(UIImageViewLinkBlock)
- (UIImageView *(^)(UIImage *))img_viewImage
{
    return ^id(UIImage * img){
        LinkHandle_REF(UIImageView)
        LinkGroupHandle_REF(img_viewImage,img)
        _self.image= img;
        return _self;
    };
}

- (UIImageView *(^)(UIImage *))img_viewImageHighlight
{
    return ^id(UIImage * img){
        LinkHandle_REF(UIImageView)
        LinkGroupHandle_REF(img_viewImageHighlight,img)
        _self.highlightedImage= img;
        return _self;
    };
}

- (UIImageView *(^)(NSString *))img_viewImageWithName
{
    return ^id(NSString * imgStr){
        LinkHandle_REF(UIImageView)
        LinkGroupHandle_REF(img_viewImageWithName,imgStr)
        _self.image = [UIImage imageNamed:imgStr];
        return _self;
    };
}

- (UIImageView *(^)(NSString *))img_viewImageStrHighlight
{
    return ^id(NSString * imgStr){
        LinkHandle_REF(UIImageView)
        LinkGroupHandle_REF(img_viewImageStrHighlight,imgStr)
        _self.highlightedImage = [UIImage imageNamed:imgStr];
        return _self;
    };
}

- (UIImageView *(^)(BOOL))img_viewHighlight
{
    return ^id(BOOL b){
        LinkHandle_REF(UIImageView)
        LinkGroupHandle_REF(img_viewHighlight,b)
        _self.highlighted = b;
        return _self;
    };
}

- (UIImageView *(^)(NSArray<UIImage *> *))img_viewAnimationImages
{
    return ^id(NSArray<UIImage *> * imgs){
        LinkHandle_REF(UIImageView)
        LinkGroupHandle_REF(img_viewAnimationImages,imgs)
        _self.animationImages = imgs;
        return _self;
    };
}

- (UIImageView *(^)(NSArray<UIImage *> *))img_viewHighlightedAnimationImages
{
    return ^id(NSArray<UIImage *> * imgs){
        LinkHandle_REF(UIImageView)
        LinkGroupHandle_REF(img_viewAnimationImages,imgs)
        _self.highlightedAnimationImages = imgs;
        return _self;
    };
}

@end

@implementation UIImageView(UIImageViewLinkBlock)
static const char _lb_key_img_viewExtensionOfTouchSide;
static const char _lb_key_img_viewExtensionOfTouchRects;
- (UIImageView *(^)(UIEdgeInsets))img_viewExtensionOfTouchSide
{
    return ^UIImageView*(UIEdgeInsets insets){
        
        objc_setAssociatedObject(self,
                                 &_lb_key_img_viewExtensionOfTouchSide,
                                 [NSValue valueWithUIEdgeInsets:insets],
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return self;
    };
}

- (UIImageView *(^)(NSArray<NSString *> *))img_viewExtensionOfTouchRects
{
    return ^UIImageView*(NSArray<NSString*>* rects){
        objc_setAssociatedObject(self,
                                 &_lb_key_img_viewExtensionOfTouchRects,
                                 [rects copy],
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return self;
    };
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    if (event.type != UIEventTypeTouches||self.userInteractionEnabled == NO||self.hidden||self.alpha<0.01) {
        return [super pointInside:point withEvent:event];
    }
    NSValue* valueSide = objc_getAssociatedObject(self,
                                              &_lb_key_img_viewExtensionOfTouchSide);
    NSArray<NSString*>* valueRects = objc_getAssociatedObject(self,
                                                  &_lb_key_img_viewExtensionOfTouchRects);
    if(!valueSide && !valueRects){
        return [super pointInside:point withEvent:event];
    }else if (valueSide) {
        UIEdgeInsets edgeinsets = UIEdgeInsetsZero;
        [valueSide getValue:&edgeinsets];
        if(CGRectContainsPoint(LB_CGRectInsetMargin(self.bounds , edgeinsets) , point)){
            return YES;
        }
    }else if(valueRects){
        for (NSString* rectStr in valueRects) {
            if(CGRectContainsPoint(CGRectFromString(rectStr) , point)){
                return YES;
            }
        }
    }
    return NO;
}
@end
