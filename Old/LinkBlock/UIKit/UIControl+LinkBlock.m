//
//  UIControl+LinkBlock.m
//
//  Created by NOVO on 15/8/18.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//
#import "LinkBlock.h"
#import <objc/runtime.h>

@implementation NSObject(UIControlLinkBlock)

- (UIControl *(^)(BOOL))controlEnable
{
    return ^id(BOOL enable){
        LinkHandle_REF(UIControl)
        LinkGroupHandle_REF(controlEnable,enable)
        _self.enabled=enable;
        return _self;
    };
}

- (UIControl *(^)(void))controlEnableYES
{
    return ^id(){
        LinkHandle_REF(UIControl)
        LinkGroupHandle_REF(controlEnableYES)
        _self.enabled=YES;
        return _self;
    };
}

- (UIControl* (^)(void))controlEnableNO
{
    return ^id(){
        LinkHandle_REF(UIControl)
        LinkGroupHandle_REF(controlEnableNO)
        _self.enabled=NO;
        return _self;
    };
}

- (UIControl *(^)(BOOL))controlSelected
{
    return ^id(BOOL selected){
        LinkHandle_REF(UIControl)
        LinkGroupHandle_REF(controlSelected,selected)
        _self.selected=selected;
        return _self;
    };
}

- (UIControl *(^)(BOOL))controlHighlighted
{
    return ^id(BOOL highlighted){
        LinkHandle_REF(UIControl)
        LinkGroupHandle_REF(controlHighlighted,highlighted)
        _self.highlighted=highlighted;
        return _self;
    };
}

- (UIControl *(^)(UIControlContentVerticalAlignment))controlContentVerticalAlignment
{
    return ^id(UIControlContentVerticalAlignment alignment){
        LinkHandle_REF(UIControl)
        LinkGroupHandle_REF(controlContentVerticalAlignment,alignment)
        _self.contentVerticalAlignment = alignment;
        return _self;
    };
}

- (UIControl *(^)(UIControlContentHorizontalAlignment))controlContentHorizontalAlignment
{
    return ^id(UIControlContentHorizontalAlignment alignment){
        LinkHandle_REF(UIControl)
        LinkGroupHandle_REF(controlContentHorizontalAlignment,alignment)
        _self.contentHorizontalAlignment = alignment;
        return _self;
    };
}

- (UIControl *(^)(void))controlSelectedYES
{
    return ^id(){
        LinkHandle_REF(UIControl)
        LinkGroupHandle_REF(controlSelectedYES)
        _self.selected=YES;
        return _self;
    };
}

- (UIControl *(^)(void))controlSelectedNO
{
    return ^id(){
        LinkHandle_REF(UIControl)
        LinkGroupHandle_REF(controlSelectedYES)
        _self.selected=NO;
        return _self;
    };
}

#define lb_controlContentHorizontalAlignment(symbol)\
\
- (UIControl *(^)(void))controlContentHorizontalAlignment##symbol\
{\
    return ^id(){\
        \
        LinkHandle_REF(UIControl)\
        LinkGroupHandle_REF(controlContentHorizontalAlignment##symbol)\
        \
        _self.contentHorizontalAlignment = UIControlContentHorizontalAlignment##symbol;\
        return _self;\
    };\
}

lb_controlContentHorizontalAlignment(Center)
lb_controlContentHorizontalAlignment(Left)
lb_controlContentHorizontalAlignment(Right)
lb_controlContentHorizontalAlignment(Fill)
lb_controlContentHorizontalAlignment(Leading)
lb_controlContentHorizontalAlignment(Trailing)

//- (UIControl *(^)(void))controlContentVerticalAlignmentCenter
#define lb_controlContentVerticalAlignment(symbol)\
\
- (UIControl *(^)(void))controlContentVerticalAlignment##symbol\
{\
    return ^id(){\
    \
        LinkHandle_REF(UIControl)\
        LinkGroupHandle_REF(controlContentVerticalAlignment##symbol)\
        \
        _self.contentHorizontalAlignment = UIControlContentVerticalAlignment##symbol;\
            return _self;\
    };\
}
lb_controlContentVerticalAlignment(Center)
lb_controlContentVerticalAlignment(Top)
lb_controlContentVerticalAlignment(Bottom)
lb_controlContentVerticalAlignment(Fill)
@end
