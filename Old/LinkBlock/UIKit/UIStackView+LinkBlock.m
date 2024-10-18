//
//  UIStackView+LinkBlock.m
//  LinkBlockProgram
//
//  Created by NOVO on 2019/1/15.
//  Copyright © 2019 NOVO. All rights reserved.
//

#import "LinkBlock.h"

@implementation NSObject(UIStackViewLinkBlock)

- (UIStackView *(^)(UILayoutConstraintAxis))stackViewAxis
{
    return ^id(UILayoutConstraintAxis axis){
        LinkHandle_REF(UIStackView)
        LinkGroupHandle_REF(stackViewAxis,axis)
        
        _self.axis = axis;
        return _self;
    };
}

- (UIStackView *(^)(void))stackViewAxisUILayoutConstraintAxisVertical
{
    return ^id(void){
        LinkHandle_REF(UIStackView)
        LinkGroupHandle_REF(stackViewAxisUILayoutConstraintAxisVertical)
        
        _self.axis = UILayoutConstraintAxisVertical;
        return _self;
    };
}

- (UIStackView *(^)(void))stackViewAxisUILayoutConstraintAxisHorizontal
{
    return ^id(void){
        LinkHandle_REF(UIStackView)
        LinkGroupHandle_REF(stackViewAxisUILayoutConstraintAxisHorizontal)
        
        _self.axis = UILayoutConstraintAxisHorizontal;
        return _self;
    };
}

- (UIStackView *(^)(CGFloat))stackViewSpacing
{
    return ^id(CGFloat spacing){
        LinkHandle_REF(UIStackView)
        LinkGroupHandle_REF(stackViewSpacing,spacing)
        
        _self.spacing = spacing;
        return _self;
    };
}

- (UIStackView *(^)(UIStackViewDistribution))stackViewDistribution
{
    return ^id(UIStackViewDistribution distribution){
        LinkHandle_REF(UIStackView)
        LinkGroupHandle_REF(stackViewDistribution,distribution)
        
        _self.distribution = distribution;
        return _self;
    };
}

- (UIStackView *(^)(void))stackViewDistributionFill
{
    return ^id(void){
        LinkHandle_REF(UIStackView)
        LinkGroupHandle_REF(stackViewDistributionFill)
        
        _self.distribution = UIStackViewDistributionFill;
        return _self;
    };
}
- (UIStackView *(^)(void))stackViewDistributionFillEqually
{
    return ^id(void){
        LinkHandle_REF(UIStackView)
        LinkGroupHandle_REF(stackViewDistributionFillEqually)
        
        _self.distribution = UIStackViewDistributionFillEqually;
        return _self;
    };
}
- (UIStackView *(^)(void))stackViewDistributionEqualSpacing
{
    return ^id(void){
        LinkHandle_REF(UIStackView)
        LinkGroupHandle_REF(stackViewDistributionEqualSpacing)
        
        _self.distribution = UIStackViewDistributionEqualSpacing;
        return _self;
    };
}
- (UIStackView *(^)(void))stackViewDistributionEqualCentering
{
    return ^id(void){
        LinkHandle_REF(UIStackView)
        LinkGroupHandle_REF(stackViewDistributionEqualCentering)
        
        _self.distribution = UIStackViewDistributionEqualCentering;
        return _self;
    };
}
- (UIStackView *(^)(void))stackViewDistributionFillProportionally
{
    return ^id(void){
        LinkHandle_REF(UIStackView)
        LinkGroupHandle_REF(stackViewDistributionFillProportionally)
        
        _self.distribution = UIStackViewDistributionFillProportionally;
        return _self;
    };
}

- (UIStackView *(^)(UIStackViewAlignment))stackViewAlignment
{
    return ^id(UIStackViewAlignment alignment){
        LinkHandle_REF(UIStackView)
        LinkGroupHandle_REF(stackViewAlignment, alignment)
        
        _self.alignment = alignment;
        return _self;
    };
}

- (UIStackView *(^)(void))stackViewAlignmentFill
{
    return ^id(void){
        LinkHandle_REF(UIStackView)
        LinkGroupHandle_REF(stackViewAlignmentFill)
        
        _self.alignment = UIStackViewAlignmentFill;
        return _self;
    };
}
- (UIStackView *(^)(void))stackViewAlignmentCenter
{
    return ^id(void){
        LinkHandle_REF(UIStackView)
        LinkGroupHandle_REF(stackViewAlignmentCenter)
        
        _self.alignment = UIStackViewAlignmentCenter;
        return _self;
    };
}
- (UIStackView *(^)(void))stackViewAlignmentLastBaseline
{
    return ^id(void){
        LinkHandle_REF(UIStackView)
        LinkGroupHandle_REF(stackViewAlignmentLastBaseline)
        
        _self.alignment = UIStackViewAlignmentLastBaseline;
        return _self;
    };
}
- (UIStackView *(^)(void))stackViewAlignmentLeadingOrTop
{
    return ^id(void){
        LinkHandle_REF(UIStackView)
        LinkGroupHandle_REF(stackViewAlignmentLeadingOrTop)
        
        _self.alignment = UIStackViewAlignmentLeading;
        return _self;
    };
}
- (UIStackView *(^)(void))stackViewAlignmentFirstBaseline
{
    return ^id(void){
        LinkHandle_REF(UIStackView)
        LinkGroupHandle_REF(stackViewAlignmentFirstBaseline)
        
        _self.alignment = UIStackViewAlignmentFirstBaseline;
        return _self;
    };
}
- (UIStackView *(^)(void))stackViewAlignmentTrailingOrBottom
{
    return ^id(void){
        LinkHandle_REF(UIStackView)
        LinkGroupHandle_REF(stackViewAlignmentTrailingOrBottom)
        
        _self.alignment = UIStackViewAlignmentTrailing;
        return _self;
    };
}

- (UIStackView *(^)(id))stackViewAddArrangedSubview
{
    return ^id(id asSubview){
        LinkHandle_REF(UIStackView)
        LinkGroupHandle_REF(stackViewAddArrangedSubview,asSubview)
        
        if([asSubview isKindOfClass:NSArray.class])
        {
            [asSubview enumerateObjectsUsingBlock:^(UIView* subView, NSUInteger idx, BOOL * stop) {       
                [_self addArrangedSubview:subView];
            }];
        }
        
        [_self addArrangedSubview: asSubview];
        
        return _self;
    };
}

 - (UIStackView *(^)(UIView *, ...))stackViewAddArrangedSubviews
{
    return ^id(UIView* view0,...){
        
        LinkHandle_REF(UIStackView)
        
        NSMutableArray* argList = [NSMutableArray new];
        if(view0){
            
            [argList addObject:view0];
            va_list     args;
            id          parm;
            va_start(args, view0);
            while (( parm = va_arg(args, UIView*)) ) {
                [argList addObject:parm];
            }
            va_end(args);
        }
        
        ///////////////////////
        //LinkGroupHandle_VAL
        if([self isKindOfClass:[LinkGroup class]]){
            
            LinkGroup*      group = self.thisLinkObjs;
            NSMutableArray* newObjs = [NSMutableArray new];
            [group.linkObjects enumerateObjectsUsingBlock:^(id view, NSUInteger idx, BOOL *stop) {
                
                if([view isKindOfClass:[UIView class]]){
                    
                    [argList enumerateObjectsUsingBlock:^(id subView, NSUInteger idx, BOOL *stop) {
                        
                        [view addArrangedSubview:subView];
                    }];
                }else{
                    
                    [argList enumerateObjectsUsingBlock:^(id subView, NSUInteger idx, BOOL *stop) {
                        
                        LinkError* error = [LinkError new];
                        error.needClass = @"UIStackView";
                        error.errorClass = NSStringFromClass([subView class]);
                        error.inFunc = @(__func__);
                        [newObjs addObject:error];
                    }];
                    group.linkObjects = newObjs;
                }
            }];
            return group;
        }
        //LinkGroupHandle_VAL
        ///////////////////////
        
        [argList enumerateObjectsUsingBlock:^(id subView, NSUInteger idx, BOOL *stop) {
            
            [_self addArrangedSubview:subView];
        }];
        return _self;
    };
}
@end
