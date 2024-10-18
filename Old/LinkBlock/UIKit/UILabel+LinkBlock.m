//
//  UILabel+LinkBlock.m

//
//  Created by NOVO on 15/8/12.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlock.h"

@implementation NSObject(UILabelLinkBlock)
- (UILabel *(^)(void))labAlignmentRight
{
    return ^id(){
        LinkHandle_REF(UILabel)
        LinkGroupHandle_REF(labAlignmentRight)
        _self.textAlignment= NSTextAlignmentRight;
        return _self;
    };
}

- (UILabel *(^)(void))labAlignmentLeft
{
    return ^id(){
        LinkHandle_REF(UILabel)
        LinkGroupHandle_REF(labAlignmentLeft)
        _self.textAlignment= NSTextAlignmentLeft;
        return _self;
    };
}

- (UILabel *(^)(void))labAlignmentCenter
{
    return ^id(){
        LinkHandle_REF(UILabel)
        LinkGroupHandle_REF(labAlignmentCenter)
        _self.textAlignment= NSTextAlignmentCenter;
        return _self;
    };
}

- (UILabel *(^)(NSInteger))labNumberOfLines
{
    return ^id(NSInteger lines){
        LinkHandle_REF(UILabel)
        LinkGroupHandle_REF(labNumberOfLines,lines)
        _self.numberOfLines= lines;
        return _self;
    };
}

- (UILabel *(^)(NSTextAlignment))labAlignment
{
    return ^id(NSTextAlignment alighment){
        LinkHandle_REF(UILabel)
        LinkGroupHandle_REF(labAlignment,alighment)
        _self.textAlignment = alighment;
        return _self;
    };
}

- (UILabel *(^)(NSString *))labText
{
    return ^id(NSString * txt){
        LinkHandle_REF(UILabel)
        LinkGroupHandle_REF(labText,txt)
        _self.text= txt;
        return _self;
    };
}

- (UILabel *(^)(UIColor *))labTextColor
{
    return ^id(UIColor * color){
        LinkHandle_REF(UILabel)
        LinkGroupHandle_REF(labTextColor,color)
        _self.textColor= color;
        return _self;
    };
}

- (UILabel *(^)(UIFont *))labFont
{
    return ^id(UIFont * font){
        LinkHandle_REF(UILabel)
        LinkGroupHandle_REF(labFont,font)
        _self.font= font;
        return _self;
    };
}

- (UILabel *(^)(CGFloat))labFontSystemSizeSet
{
    return ^id(CGFloat size){
        LinkHandle_REF(UILabel)
        LinkGroupHandle_REF(labFontSystemSizeSet,size)
        _self.font= [UIFont systemFontOfSize:size];
        return _self;
    };
}

- (CGFloat (^)(void))labFontSystemSizeGet
{
    return ^CGFloat(){
        LinkHandle_VAL_IFNOT(UILabel){
            return 0.0;
        }
        LinkGroupHandle_VAL(labFontSystemSizeGet)
        return _self.font.pointSize;
    };
}

- (UILabel *(^)(void))labHighlightedTextColorLightByTextColor
{
    return ^id(){
        LinkHandle_REF(UILabel)
        LinkGroupHandle_REF(labHighlightedTextColorLightByTextColor)
        _self.highlightedTextColor = _self.textColor.colorHighlightLightColor();
        return _self;
    };
}

- (UILabel *(^)(void))labHighlightedTextColorDarkByTextColor
{
    return ^id(){
        LinkHandle_REF(UILabel)
        LinkGroupHandle_REF(labHighlightedTextColorDarkByTextColor)
        _self.highlightedTextColor = _self.textColor.colorHighlightDarkColor();
        return _self;
    };
}
@end

@implementation UILabel(UILabelLinkBlock)
static const char _lb_key_labExtensionOfTouchSide;
static const char _lb_key_labExtensionOfTouchRects;
- (UILabel *(^)(UIEdgeInsets))labExtensionOfTouchSide
{
    return ^UILabel*(UIEdgeInsets insets){
        NSValue* vaule = [NSValue valueWithUIEdgeInsets:insets];
        objc_setAssociatedObject(self, &_lb_key_labExtensionOfTouchSide, vaule, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return self;
    };
}

- (UILabel *(^)(NSArray<NSString *> *))labExtensionOfTouchRects
{
    return ^UILabel*(NSArray<NSString*>* rects){
        objc_setAssociatedObject(self,
                                 &_lb_key_labExtensionOfTouchRects,
                                 [rects copy],
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return self;
    };
}

- (UILabel *(^)(NSArray<NSString *> *))img_viewExtensionOfTouchRects
{
    return ^UILabel*(NSArray<NSString*>* rects){
        objc_setAssociatedObject(self,
                                 &_lb_key_labExtensionOfTouchRects,
                                 [rects copy],
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return self;
    };
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    if (event.type != UIEventTypeTouches||self.userInteractionEnabled == NO||self.hidden||self.alpha<0.01||self.enabled == NO) {
        return [super pointInside:point withEvent:event];
    }
    NSValue* valueSide = objc_getAssociatedObject(self,
                                                  &_lb_key_labExtensionOfTouchSide);
    NSArray<NSString*>* valueRects = objc_getAssociatedObject(self,
                                                              &_lb_key_labExtensionOfTouchRects);
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
