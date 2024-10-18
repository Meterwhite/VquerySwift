//
//  UIView+LinkBlock.m
//
//  Created by NOVO on 15/8/12.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlock.h"
#import <objc/runtime.h>

@implementation NSObject(UIViewLinkBlock)
- (UIView *(^)(CGFloat, CGFloat, CGFloat, CGFloat))viewSetFrame
{
    return ^id(CGFloat x,CGFloat y, CGFloat width, CGFloat height){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewSetFrame,x,y,width,height)
        _self.frame= CGRectMake(x, y, width, height);
        return _self;
    };
}

- (UIView *(^)(CGRect))viewSetFrameVal
{
    return ^id(CGRect frame){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewSetFrameVal,frame)
        _self.frame = frame;
        return _self;
    };
}

- (UIView *(^)(CGFloat, CGFloat, CGFloat, CGFloat))viewSetBounds
{
    return ^id(CGFloat x,CGFloat y, CGFloat width, CGFloat height){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewSetBounds,x,y,width,height)
        _self.bounds= CGRectMake(x, y, width, height);
        return _self;
    };
}

- (UIView *(^)(CGRect))viewSetBoundsVal
{
    return ^id(CGRect bounds){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewSetBoundsVal,bounds)
        _self.bounds= bounds;
        return _self;
    };
}

- (UIView *(^)(CGFloat))viewSetX
{
    return ^id(CGFloat x){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewSetX,x)
        CGRect frame = _self.frame;
        frame.origin.x = x;
        _self.frame = frame;
        return _self;
    };
}

- (UIView *(^)(CGFloat))viewSetY
{
    return ^id(CGFloat y){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewSetY,y)
        CGRect frame = _self.frame;
        frame.origin.y = y;
        _self.frame = frame;
        return _self;
    };
}

- (UIView *(^)(CGFloat))viewSetCenterX
{
    return ^id(CGFloat centerX){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewSetCenterX,centerX)
        CGPoint center = _self.center;
        center.x = centerX;
        _self.center = center;
        return _self;
    };
}

- (UIView *(^)(CGFloat))viewSetCenterY
{
    return ^id(CGFloat centerY){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewSetCenterY,centerY)
        CGPoint center = _self.center;
        center.y = centerY;
        _self.center = center;
        return _self;
    };
}

- (UIView *(^)(CGFloat))viewSetWidth
{
    return ^id(CGFloat width){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewSetWidth,width)
        CGRect frame= _self.frame;
        frame.size.width= width;
        _self.frame= frame;
        return _self;
    };
}

- (UIView *(^)(CGFloat))viewSetHeight
{
    return ^id(CGFloat height){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewSetHeight,height)
        CGRect frame= _self.frame;
        frame.size.height= height;
        _self.frame= frame;
        return _self;
    };
}

- (UIView *(^)(CGFloat,CGFloat))viewSetSize
{
    return ^id(CGFloat width, CGFloat height){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewSetSize,width,height)
        CGRect frame= _self.frame;
        frame.size.width= width;
        frame.size.height= height;
        _self.frame= frame;
        return _self;
    };
}

- (UIView *(^)(CGSize))viewSetSizeVal
{
    return ^id(CGSize size){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewSetSizeVal,size)
        CGRect frame= _self.frame;
        frame.size = size;
        _self.frame = frame;
        return _self;
    };
}

- (UIView *(^)(NSInteger))viewSetTag
{
    return ^id(NSInteger tag){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewSetTag,tag)
        _self.tag = tag;
        return _self;
    };
}

- (UIView *(^)(CGFloat,CGFloat))viewSetOrigin
{
    return ^id(CGFloat x,CGFloat y){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewSetOrigin,x,y)
        CGRect frame= _self.frame;
        frame.origin.x= x;
        frame.origin.y= y;
        _self.frame= frame;
        return _self;
    };
}

- (UIView *(^)(CGPoint))viewSetOriginVal
{
    return ^id(CGPoint origin){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewSetOriginVal,origin)
        CGRect frame= _self.frame;
        frame.origin = origin;
        _self.frame= frame;
        return _self;
    };
}

- (UIView *(^)(UIColor *))viewBGColor
{
    return ^id(UIColor *color){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewBGColor,color)
        _self.backgroundColor= color;
        return _self;
    };
}

- (UIView *(^)(void))viewBGColorRandom
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewBGColorRandom)
        _self.backgroundColor= [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
        return _self;
    };
}

- (UIView *(^)(void))viewBGColorWhite
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewBGColorWhite)
        _self.backgroundColor=UIColor.whiteColor;
        return _self;
    };
}

- (UIView *(^)(void))viewBGColorClear
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewBGColorClear)
        _self.backgroundColor=UIColor.clearColor;
        return _self;
    };
}

- (UIView *(^)(void))viewBGColorRed
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewBGColorClear)
        _self.backgroundColor=UIColor.redColor;
        return _self;
    };
}

- (UIView *(^)(CGFloat x,CGFloat y))viewSetCenter
{
    return ^id(CGFloat x,CGFloat y){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewSetCenter,x,y)
        _self.center = CGPointMake(x, y);
        return _self;
    };
}

- (UIView *(^)(CGPoint))viewSetCenterVal
{
    return ^id(CGPoint center){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewSetCenterVal,center)
        _self.center = center;
        return _self;
    };
}

- (UIView *(^)(UIColor *))viewBorderColor
{
    return ^id(UIColor* color){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewBorderColor,color)
        if([color isKindOfClass:[UIColor class]]){
            _self.layer.borderColor= color.CGColor;
        }
        return _self;
    };
}

- (UIView *(^)(CGFloat))viewBorderWidth
{
    return ^id(CGFloat width){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewBorderWidth,width)
        _self.layer.borderWidth= width;
        return _self;
    };
}

- (UIView *(^)(UIColor *, CGFloat))viewBorderColorAndWidth
{
    return ^id(UIColor* color,CGFloat w){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewBorderColorAndWidth,color,w)
        _self.layer.borderWidth= w;
        _self.layer.borderColor= color.CGColor;
        return _self;
    };
}

- (UIView *(^)(CGFloat))viewCornerRadius
{
    return ^id(CGFloat cornerRadius){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewCornerRadius,cornerRadius)
        _self.layer.cornerRadius= cornerRadius;
        return _self;
    };
}

- (UIView *(^)(CGFloat))viewCornerRadiusAndClipsToBounds
{
    return self.viewClipsToBoundsYES().viewCornerRadius;
}

- (UIView *(^)(BOOL))viewClipsToBounds
{
    return ^id(BOOL flag){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewClipsToBounds,flag)
        _self.clipsToBounds= flag;
        return _self;
    };
}

- (UIView *(^)(void))viewClipsToBoundsYES
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewClipsToBoundsYES)
        _self.clipsToBounds= YES;
        return _self;
    };
}

- (UIView *(^)(void))viewClipsToBoundsNO
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewClipsToBoundsNO)
        _self.clipsToBounds= NO;
        return _self;
    };
}

- (UIView *(^)(BOOL))viewEndEditing
{
    return ^id(BOOL force){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewEndEditing,force)
        [_self endEditing:force];
        return _self;
    };
}

- (UIView *(^)(void))viewEndEditingYES
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewEndEditingYES)
        [_self endEditing:YES];
        return _self;
    };
}

- (BOOL (^)(void))viewIsFirstResponder
{
    return ^(){
        LinkHandle_VAL_IFNOT(UIView){
            return NO;
        }
        LinkGroupHandle_VAL(viewIsFirstResponder)
        return _self.isFirstResponder;
    };
}

- (UIView *(^)(void))viewBecomeFirstResponder
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewBecomeFirstResponder)
        [_self becomeFirstResponder];
        return _self;
    };
}

- (UIView *(^)(void))viewResignFirstResponder
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewResignFirstResponder)
        [_self resignFirstResponder];
        return _self;
    };
}

- (UIView *(^)(void))viewFindFirstResponderSubViewOfTextInput
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewFindFirstResponderSubViewOfTextInput)
        
        UIView *ret= (id)NSNull.null;
        
        for (UIView* view in _self.subviews) {
            
            if(view.isFirstResponder &&
               [view conformsToProtocol:@protocol(UITextInputTraits)]){
                
                    ret = view;
                    break;
            }else if((ret = view.viewFindFirstResponderSubViewOfTextInput())){
                
                break;
            }
        }
        
        return ret;
    };
}

- (CGRect (^)(void))viewConvertRectToWindow
{
    return ^(){
        LinkHandle_VAL_IFNOT(UIView){
            return CGRectZero;
        }
        LinkGroupHandle_VAL(viewConvertRectToWindow)
        return [_self.superview convertRect:_self.frame toView:nil];
    };
}

- (UIView *(^)(UIView *, BOOL))viewConvertSuperviewTo
{
    return ^id(UIView* aView, BOOL isKeep){
        
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewConvertSuperviewTo,aView,isKeep)
        if(isKeep){
            
            CGRect toAViewRect = [_self.superview convertRect:_self.frame toView:aView];
            [_self removeFromSuperview];
            [aView addSubview:_self];
            _self.frame=toAViewRect;
        }else{
            [_self removeFromSuperview];
            [aView addSubview:_self];
        }
        
        return _self;
    };
}

- (BOOL (^)(UIView *))viewIsInView
{
    return ^(UIView *view){
        LinkHandle_VAL_IFNOT(UIView){
            return NO;
        }
        LinkGroupHandle_VAL(viewIsInView,view)
        
        if([_self.superview isEqual:view])
            return  YES;
        
        return  _self.superview.viewIsInView(view);
    };
}

- (UIView *(^)(BOOL))viewUserInteractionEnabled
{
    return ^id(BOOL b){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewUserInteractionEnabled,b)
        _self.userInteractionEnabled = b;
        return _self;
    };
}

- (UIView *(^)(void))viewUserInteractionEnabledYES
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewUserInteractionEnabledYES)
        _self.userInteractionEnabled = YES;
        return _self;
    };
}

- (UIView *(^)(void))viewUserInteractionEnabledNO
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewUserInteractionEnabledNO)
        _self.userInteractionEnabled = NO;
        return _self;
    };
}

- (UIView *(^)(BOOL))viewMultipleTouchEnabled
{
    return ^id(BOOL b){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewMultipleTouchEnabled,b)
        _self.multipleTouchEnabled =b;
        return _self;
    };
}

- (UIView *(^)(BOOL))viewExclusiveTouch
{
    return ^id(BOOL b){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewExclusiveTouch,b)
        _self.exclusiveTouch = b;
        return _self;
    };
}

- (UIView *(^)(UIViewAutoresizing))viewAutoresizingMask
{
    return ^id(UIViewAutoresizing mask){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewAutoresizingMask,mask)
        _self.autoresizingMask = mask;
        return _self;
    };
}

- (UIView *(^)(CGFloat))viewAlpha
{
    return ^id(CGFloat alpha){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewAlpha,alpha)
        _self.alpha= alpha;
        return _self;
    };
}

- (UIView *(^)(CGFloat))viewOpaque
{
    return ^id(CGFloat opaque){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewOpaque,opaque)
        _self.opaque = opaque;
        return _self;
    };
}

- (UIView *(^)(BOOL))viewHidden
{
    return ^id(BOOL b){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewHidden,b)
        _self.hidden= b;
        return _self;
    };
}

- (UIView *(^)(void))viewHiddenYES
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewHiddenYES)
        _self.hidden= YES;
        return _self;
    };
}

- (UIView *(^)(void))viewHiddenNO
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewHiddenNO)
        _self.hidden= NO;
        return _self;
    };
}

- (UIView *(^)(NSTimeInterval))viewHiddenYESUsingAnimate
{
    return ^id(NSTimeInterval during){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewHiddenYESUsingAnimate,during)
        
        CGFloat alpha = _self.alpha;
        [UIView animateWithDuration:during animations:^{
            
            _self.alpha = 0;
        } completion:^(BOOL finished) {
            
            _self.hidden = YES;
            _self.alpha = alpha;
        }];
        return _self;
    };
}

- (UIView *(^)(NSTimeInterval))viewHiddenNOUsingAnimate
{
    return ^id(NSTimeInterval during){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewHiddenNOUsingAnimate,during)
        
        CGFloat alpha = _self.alpha;
        _self.hidden = NO;
        _self.alpha = 0.0;
        [UIView animateWithDuration:during animations:^{
            
            _self.alpha = alpha;
        }];
        return _self;
    };
}

- (UIView *(^)(UIViewContentMode))viewContentMode
{
    return ^id(UIViewContentMode contentMode){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewContentMode,contentMode)
        _self.contentMode = contentMode;
        return _self;
    };
}

#ifndef defineViewContentModeTail
#define defineViewContentModeTail(suffix)\
- (UIView *(^)(void))viewContentMode##suffix\
{\
    return ^id(){\
        LinkHandle_REF(UIView)\
        LinkGroupHandle_REF(viewContentMode##suffix)\
        _self.contentMode = UIViewContentMode##suffix;\
        return _self;\
    };\
}
#endif

defineViewContentModeTail(ScaleToFill)
defineViewContentModeTail(ScaleAspectFit)
defineViewContentModeTail(ScaleAspectFill)
defineViewContentModeTail(Redraw)
defineViewContentModeTail(Center)
defineViewContentModeTail(Top)
defineViewContentModeTail(Bottom)
defineViewContentModeTail(Left)
defineViewContentModeTail(Right)
defineViewContentModeTail(TopLeft)
defineViewContentModeTail(TopRight)
defineViewContentModeTail(BottomLeft)
defineViewContentModeTail(BottomRight)

- (UIView *(^)(UILayoutPriority))viewContentHuggingHorizentalPriority
{
    return ^id(UILayoutPriority priority){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewContentHuggingHorizentalPriority,priority)
        [_self setContentHuggingPriority:priority forAxis:UILayoutConstraintAxisHorizontal];
        return _self;
    };
}

- (UIView *(^)(UILayoutPriority))viewContentHuggingVerticalPriority
{
    return ^id(UILayoutPriority priority){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewContentHuggingVerticalPriority,priority)
        [_self setContentHuggingPriority:priority forAxis:UILayoutConstraintAxisVertical];
        return _self;
    };
}

- (UIView *(^)(UILayoutPriority))viewContentCompressionResistanceHorizentalPriority
{
    return ^id(UILayoutPriority priority){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewContentCompressionResistanceHorizentalPriority , priority)
        [_self setContentCompressionResistancePriority:(UILayoutPriority)priority forAxis:UILayoutConstraintAxisHorizontal];
        return _self;
    };
}

- (UIView *(^)(UILayoutPriority))viewContentCompressionResistanceVerticalPriority
{
    return ^id(UILayoutPriority priority){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewContentCompressionResistanceVerticalPriority , priority)
        [_self setContentCompressionResistancePriority:(UILayoutPriority)priority forAxis:UILayoutConstraintAxisVertical];
        return _self;
    };
}

- (UIView *(^)(NSUInteger))viewSubviewAt
{
    return ^id(NSUInteger index){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewSubviewAt,index)
        if(index < _self.subviews.count) return _self.subviews[index];
        return [[LinkError errorWithCustomDescription:[NSString stringWithFormat:@"LinkBlock\n:\n Index overflow %p:index=%lu array.count=%lu",_self.subviews,(unsigned long)index,(unsigned long)_self.subviews.count]] logError];
    };
}

- (NSNumber* (^)(void))viewIndexInSuperviewAs
{
    return ^NSNumber*(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewIndexInSuperviewAs)
        for (NSInteger i=0; i<_self.superview.subviews.count; i++)
            
            if([_self.superview.subviews[i] isEqual:_self])
                return [NSNumber numberWithInteger:i];
        
        return nil;
    };
}

- (UIView *(^)(void))viewRemoveFromSuperview
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewRemoveFromSuperview)
        [_self removeFromSuperview];
        return _self;
    };
}

- (UIView *(^)(NSUInteger))viewRemoveSubviewAt
{
    return ^id(NSUInteger index){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewRemoveSubviewAt,index)
        return _self.viewSubviewAt(index).viewRemoveFromSuperview();
    };
}

- (UIView *(^)(NSUInteger, NSUInteger))viewExchangeSubviewByIndex
{
    return ^id(NSUInteger index1, NSUInteger index2){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewExchangeSubviewByIndex,index1,index2)
        [_self exchangeSubviewAtIndex:index1 withSubviewAtIndex:index2];
        return _self;
    };
}

- (UIView *(^)(void))viewRemoveAllSubview
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewRemoveAllSubview)
        
        [_self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        return _self;
    };
}

- (UIView *(^)(UIView *))viewAddSubview
{
    return ^id(UIView* subview){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewAddSubview,subview)
        if([subview isKindOfClass:[UIView class]]){
            [_self addSubview:subview];
        }
        return _self;
    };
}

- (UIView *(^)(UIView *, ...))viewAddSubviews
{
    return ^id(UIView* view0,...){
        LinkHandle_REF(UIView)
        
        NSMutableArray* argList = [NSMutableArray new];
        if(view0){
            [argList addObject:view0];
            va_list args;
            va_start(args, view0);
            id parm;
            while (( parm = va_arg(args, UIView*)) ) {
                [argList addObject:parm];
            }
            va_end(args);
        }
        
        ///////////////////////
        //LinkGroupHandle_VAL
        if([self isKindOfClass:[LinkGroup class]]){
            
            LinkGroup* group = self.thisLinkObjs;
            NSMutableArray* newObjs = [NSMutableArray new];
            [group.linkObjects enumerateObjectsUsingBlock:^(id view, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if([view isKindOfClass:[UIView class]]){
                    
                    [argList enumerateObjectsUsingBlock:^(id  _Nonnull subView, NSUInteger idx, BOOL * _Nonnull stop) {
                        [view addSubview:subView];
                    }];
                }else{
                    
                    [argList enumerateObjectsUsingBlock:^(id  _Nonnull subView, NSUInteger idx, BOOL * _Nonnull stop) {
                        LinkError* error = [LinkError new];
                        error.needClass = @"UIView";
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
        
        [argList enumerateObjectsUsingBlock:^(id  _Nonnull subView, NSUInteger idx, BOOL * _Nonnull stop) {
            [_self addSubview:subView];
        }];
        return _self;
    };
}

- (UIView *(^)(__weak UIView *))viewAddToView
{
    return ^id(__weak UIView* view){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewAddToView,view)
        if([view respondsToSelector:@selector(addSubview:)]){
            [view addSubview:_self];
        }
        return _self;
    };
}
- (UIView *(^)(UIStackView *__weak))viewAddToStackViewArranged
{
    return ^id(__weak UIStackView* stackView){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewAddToStackViewArranged,stackView)
        if([stackView respondsToSelector:@selector(addArrangedSubview:)])
            
            [stackView addArrangedSubview:_self];
        
        return _self;
    };
}

- (NSMutableArray *(^)(Class))viewFindSubviewsOfClass
{
    return ^id(Class clazz){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewFindSubviewsOfClass,clazz)
        NSMutableArray* re = [NSMutableArray new];
        [_self.subviews enumerateObjectsUsingBlock:^(UIView* view, NSUInteger idx, BOOL* stop) {
            
            if([view isKindOfClass:clazz])
                
                [re addObject:view];
        }];
        return re;
    };
}

- (UIView *(^)(void))viewSetNeedsLayout
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewSetNeedsLayout)
        [_self setNeedsLayout];
        return _self;
    };
}

- (UIView *(^)(void))viewLayoutIfNeeded
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewSetNeedsLayout)
        [_self viewLayoutIfNeeded];
        return _self;
    };
}

- (UIView *(^)(void))viewSetNeedsDisplay
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewSetNeedsLayout)
        [_self setNeedsDisplay];
        return _self;
    };
}

- (UIView *(^)(UIView *, NSUInteger))viewInsertSubviewAtIndex
{
    return ^id(UIView* view, NSUInteger index){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewInsertSubviewAtIndex,view,index)
        [_self insertSubview:view atIndex:index];
        return _self;
    };
}

- (UIView *(^)(UIView *, NSUInteger))viewInsertToViewAtIndex
{
    return ^id(UIView* view, NSUInteger index){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewInsertToViewAtIndex,view,index)
        [view insertSubview:_self atIndex:index];
        return _self;
    };
}

- (UIView *(^)(UIView *, UIView *))viewInsertSubviewBelow
{
    return ^id(UIView* view, UIView* belowView){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewInsertSubviewBelow,view,belowView)
        [_self insertSubview:view belowSubview:belowView];
        return _self;
    };
}

- (UIView *(^)(UIView *, UIView *))viewInsertToViewBelow
{
    return ^id(UIView* view, UIView* belowView){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewInsertSubviewBelow,view,belowView)
        [view insertSubview:_self belowSubview:belowView];
        return _self;
    };
}

- (UIView *(^)(UIView *, UIView *))viewInsertSubviewAbouve
{
    return ^id(UIView* view, UIView* belowView){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewInsertSubviewAbouve,view,belowView)
        [_self insertSubview:view aboveSubview:belowView];
        return _self;
    };
}

- (UIView *(^)(UIView *, UIView *))viewInsertToViewAbouve
{
    return ^id(UIView* view, UIView* belowView){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewInsertSubviewAbouve,view,belowView)
        [view insertSubview:_self aboveSubview:belowView];
        return _self;
    };
}

- (UIView* (^)(BOOL))viewSubviewsExclusiveTouch
{
    return ^id(BOOL b){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewSubviewsExclusiveTouch,b)            
        [_self.subviews setValue:@(b) forKey:@"exclusiveTouch"];
        return _self;
    };
}

- (UIView *(^)(UIRectCorner, CGSize))viewCornerRadiusSide
{
    return ^id(UIRectCorner side , CGSize radius){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewCornerRadiusSide,side,radius)
        __block CGRect bounds = _self.bounds;
        if(_self.constraints.count){
            [_self.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull constraint, NSUInteger idx, BOOL * _Nonnull stop) {
                if(constraint.firstAttribute==NSLayoutAttributeWidth){
                    bounds.size.width = constraint.constant;
                }else if (constraint.firstAttribute==NSLayoutAttributeHeight){
                    bounds.size.height = constraint.constant;
                }
            }];
        }
        UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:bounds
                                                   byRoundingCorners:side
                                                         cornerRadii:radius];
        CAShapeLayer* shape = [[CAShapeLayer alloc] init];
        shape.frame= bounds;
        shape.path= path.CGPath;
        _self.layer.mask = shape;
        return _self;
    };
}

- (BOOL (^)(void))viewIsZeroSize
{
    return ^(){
        LinkHandle_VAL_IFNOT(UIView){
            return YES;
        }
        LinkGroupHandle_VAL(viewIsZeroSize)
        if(CGRectIsEmpty(_self.frame))
            return NO;
        return YES;
    };
}

- (CGFloat (^)(void))viewX
{
    return ^CGFloat(){
        LinkHandle_VAL_IFNOT(UIView){
            return 0.0;
        }
        LinkGroupHandle_VAL(viewX)
        return _self.frame.origin.x;
    };
}

- (CGFloat (^)(void))viewY
{
    return ^CGFloat(){
        LinkHandle_VAL_IFNOT(UIView){
            return 0.0;
        }
        LinkGroupHandle_VAL(viewY)
        return _self.frame.origin.y;
    };
}

- (CGFloat (^)(void))viewCenterX
{
    return ^CGFloat(){
        LinkHandle_VAL_IFNOT(UIView){
            return 0.0;
        }
        LinkGroupHandle_VAL(viewCenterX)
        return _self.center.x;
    };
}

- (CGFloat (^)(void))viewCenterY
{
    return ^CGFloat(){
        LinkHandle_VAL_IFNOT(UIView){
            return 0.0;
        }
        LinkGroupHandle_VAL(viewCenterY)
        return _self.center.y;
    };
}

- (CGSize (^)(void))viewSize
{
    return ^(){
        LinkHandle_VAL_IFNOT(UIView){
            return CGSizeZero;
        }
        LinkGroupHandle_VAL(viewSize)
        return _self.frame.size;
    };
}

- (NSValue *(^)(void))viewFrameValue
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewFrameValue)
        return [NSValue valueWithCGRect:_self.frame];
    };
}

- (NSValue *(^)(void))viewBoundsValue
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewBoundsValue)
        return [NSValue valueWithCGRect:_self.bounds];
    };
}

- (CGFloat (^)(void))viewWidth
{
    return ^CGFloat(){
        LinkHandle_VAL_IFNOT(UIView){
            return 0.0;
        }
        LinkGroupHandle_VAL(viewWidth)
        return _self.frame.size.width;
    };
}

- (CGFloat (^)(void))viewHeight
{
    return ^CGFloat(){
        LinkHandle_VAL_IFNOT(UIView){
            return 0.0;
        }
        LinkGroupHandle_VAL(viewHeight)
        return _self.frame.size.height;
    };
}

- (CGPoint (^)(void))viewOrigin
{
    return ^(){
        LinkHandle_VAL_IFNOT(UIView){
            return CGPointZero;
        }
        LinkGroupHandle_VAL(viewOrigin)
        return _self.frame.origin;
    };
}

- (UIView *(^)(double))viewAnimateShakeHorizental
{
    return ^id(double duration){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewAnimateShakeHorizental,duration)
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        animation.duration = duration;
        animation.values = @[@(-12), @(12), @(-8), @(8), @(-4), @(4), @(0) ];
        [_self.layer addAnimation:animation forKey:@"shake"];
        return _self;
    };
}

- (UIView *(^)(CGFloat, NSTimeInterval))viewAnimateMoveUp
{
    return ^id(CGFloat distance, NSTimeInterval time){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewAnimateMoveUp,distance,time)
        [UIView animateWithDuration:time animations:^{
            _self.transform = CGAffineTransformTranslate(_self.transform,0 , -distance);
        }];
        return _self;
    };
}

- (UIView *(^)(CGFloat, NSTimeInterval))viewAnimateMoveDown
{
    return ^id(CGFloat distance, NSTimeInterval time){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewAnimateMoveDown,distance,time)
        [UIView animateWithDuration:time animations:^{
            _self.transform = CGAffineTransformTranslate(_self.transform,0 , distance);
        }];
        return _self;
    };
}

- (UIView *(^)(CGFloat, NSTimeInterval))viewAnimateMoveRight
{
    return ^id(CGFloat distance, NSTimeInterval time){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewAnimateMoveRight,distance,time)
        [UIView animateWithDuration:time animations:^{
            _self.transform = CGAffineTransformTranslate(_self.transform,distance, 0);
        }];
        return _self;
    };
}

- (UIView *(^)(CGFloat, NSTimeInterval))viewAnimateMoveLeft
{
    return ^id(CGFloat distance, NSTimeInterval time){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewAnimateMoveLeft,distance,time)
        [UIView animateWithDuration:time animations:^{
            _self.transform = CGAffineTransformTranslate(_self.transform, -distance, 0);
        }];
        
        return _self;
    };
}

- (UIView *(^)(double))viewAnimateShakeVertical
{
    return ^id(double duration){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewAnimateShakeVertical,duration)
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        animation.duration = duration;
        animation.values = @[@(-12), @(12), @(-8), @(8), @(-4), @(4), @(0) ];
        
        [_self.layer addAnimation:animation forKey:@"shake"];
        return _self;
    };
}

- (UIView *(^)(void))viewAnimateAppleMotionEffects
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewAnimateAppleMotionEffects)
        // Motion effects are available starting from iOS 7.
        if (([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending))
        {
            
            UIInterpolatingMotionEffect *horizontalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                                                                            type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
            horizontalEffect.minimumRelativeValue = @(-10.0f);
            horizontalEffect.maximumRelativeValue = @( 10.0f);
            UIInterpolatingMotionEffect *verticalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                                                                                                          type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
            verticalEffect.minimumRelativeValue = @(-10.0f);
            verticalEffect.maximumRelativeValue = @( 10.0f);
            UIMotionEffectGroup *motionEffectGroup = [[UIMotionEffectGroup alloc] init];
            motionEffectGroup.motionEffects = @[horizontalEffect, verticalEffect];
            
            [_self addMotionEffect:motionEffectGroup];
        }
        return _self;
    };
}

- (UIView *(^)(CGFloat, NSTimeInterval, BOOL))viewAnimatePulse
{
    return ^id(CGFloat scale,NSTimeInterval duration,BOOL repeat){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewAnimatePulse,scale,duration,repeat)
        CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        pulseAnimation.duration = duration;
        pulseAnimation.toValue = [NSNumber numberWithFloat:scale];
        pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pulseAnimation.autoreverses = YES;
        pulseAnimation.repeatCount = repeat ? HUGE_VALF : 0;
        [_self.layer addAnimation:pulseAnimation forKey:@"pulse"];
        return _self;
    };
}

- (UIView *(^)(NSTimeInterval, NSUInteger, BOOL))viewAnimateFlipFromTop
{
    return ^id(NSTimeInterval duration,NSUInteger repeatCount,BOOL shouldAutoreverse){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewAnimateFlipFromTop,duration,repeatCount,shouldAutoreverse)
        
        CATransition *transition = [CATransition animation];
        transition.type = @"oglFlip";
        transition.subtype = kCATransitionFromTop;
        transition.duration = duration;
        transition.repeatCount = repeatCount;
        transition.autoreverses = shouldAutoreverse;
        [_self.layer addAnimation:transition forKey:@"oglFlipAnimation"];
        return _self;
    };
}

- (UIView *(^)(NSTimeInterval, NSUInteger, BOOL))viewAnimateFlipFromBottom
{
    return ^id(NSTimeInterval duration,NSUInteger repeatCount,BOOL shouldAutoreverse){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewAnimateFlipFromBottom,duration,repeatCount,shouldAutoreverse)
        CATransition *transition = [CATransition animation];
        transition.type = @"oglFlip";
        transition.subtype = kCATransitionFromBottom;
        transition.duration = 1.0;
        transition.repeatCount = repeatCount;
        transition.autoreverses = shouldAutoreverse;
        [_self.layer addAnimation:transition forKey:@"oglFlipAnimation"];
        return _self;
    };
}

- (UIView *(^)(NSTimeInterval, NSUInteger, BOOL))viewAnimateFlipFromLeft
{
    return ^id(NSTimeInterval duration,NSUInteger repeatCount,BOOL shouldAutoreverse){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewAnimateFlipFromLeft,duration,repeatCount,shouldAutoreverse)
        CATransition *transition = [CATransition animation];
        transition.type = @"oglFlip";
        transition.subtype = kCATransitionFromLeft;
        transition.duration = duration;
        transition.repeatCount = repeatCount;
        transition.autoreverses = shouldAutoreverse;
        [_self.layer addAnimation:transition forKey:@"oglFlipAnimation"];
        return _self;
    };
}

- (UIView *(^)(NSTimeInterval, NSUInteger, BOOL))viewAnimateFlipFromRight
{
    return ^id(NSTimeInterval duration,NSUInteger repeatCount,BOOL shouldAutoreverse){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewAnimateFlipFromRight,duration,repeatCount,shouldAutoreverse)
        
        CATransition *transition = [CATransition animation];
        transition.type = @"oglFlip";
        transition.subtype = kCATransitionFromRight;
        transition.duration = duration;
        transition.repeatCount = repeatCount;
        transition.autoreverses = shouldAutoreverse;
        [_self.layer addAnimation:transition
                           forKey:@"spin"];
        return _self;
    };
}

- (UIView *(^)(CGFloat, NSTimeInterval, NSUInteger, BOOL))viewAnimateRotateToLeft
{
    return ^id(CGFloat angle,NSTimeInterval duration,NSUInteger repeatCount,BOOL shouldAutoreverse){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewAnimateRotateToLeft,angle,duration,repeatCount,shouldAutoreverse)
        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = @(-angle);
        rotationAnimation.duration = duration;
        rotationAnimation.autoreverses = shouldAutoreverse;
        rotationAnimation.repeatCount = repeatCount;
        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [_self.layer addAnimation:rotationAnimation
                          forKey:@"transform.rotation.z"];
        return _self;
    };
}

- (UIView *(^)(CGFloat, CGFloat, NSTimeInterval))viewAnimateOpacity
{
    return ^id(CGFloat from , CGFloat to , NSTimeInterval duration){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewAnimateOpacity,from,to,duration);
        CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"opacity"];
        anima.fromValue = @(from);
        anima.toValue = @(to);
        anima.duration = duration;
        [_self.layer addAnimation:anima forKey:@"opacityAniamtion"];
        return _self;
    };
}

- (UIView *(^)(CGFloat, NSTimeInterval, NSUInteger, BOOL))viewAnimateRotateToRight
{
    return ^id(CGFloat angle,NSTimeInterval duration,NSUInteger repeatCount,BOOL shouldAutoreverse){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewAnimateRotateToRight,angle,duration,repeatCount,shouldAutoreverse)
        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = @(angle);
        rotationAnimation.duration = duration;
        rotationAnimation.autoreverses = shouldAutoreverse;
        rotationAnimation.repeatCount = repeatCount;
        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [_self.layer addAnimation:rotationAnimation
                           forKey:@"transform.rotation.z"];
        return _self;
    };
}

- (UIView *(^)(void))viewAnimateRemove
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewAnimateRemove)
        [CATransaction begin];
        [_self.layer removeAllAnimations];
        [CATransaction commit];
        [CATransaction flush];
        return _self;
    };
}

- (BOOL (^)(void))viewAnimateIsDoing
{
    return ^BOOL(){
        LinkHandle_VAL_IFNOT(UIView){
            return NO;
        }
        LinkGroupHandle_VAL(viewAnimateIsDoing)
        return [_self.layer.animationKeys count];
    };
}

- (UIView *(^)(void))viewAnimatePause
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewAnimatePause)
        CFTimeInterval pausedTime= [_self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
        _self.layer.speed= 0.0;
        _self.layer.timeOffset= pausedTime;
        return _self;
    };
}

- (UIView *(^)(void))viewAnimateResume
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewAnimateResume)
        CFTimeInterval pausedTime= [_self.layer timeOffset];
        _self.layer.speed= 1.0;
        _self.layer.timeOffset= 0.0;
        _self.layer.beginTime= 0.0;
        CFTimeInterval timeSincePause= [_self.layer convertTime:CACurrentMediaTime() fromLayer:nil]- pausedTime;
        _self.layer.beginTime= timeSincePause;
        return _self;
    };
}

- (UIImage *(^)(void))viewSnapshot
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewSnapshot)
        
        UIGraphicsBeginImageContextWithOptions(_self.bounds.size, NO, YES);
        [_self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *re = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return re;
    };
}


- (CGFloat (^)(void))viewMaxX
{
    return ^CGFloat(){
        LinkHandle_VAL_IFNOT(UIView){
            return 0.0;
        }
        LinkGroupHandle_VAL(viewMaxX)
        return CGRectGetMaxX(_self.frame);
    };
}

- (CGFloat (^)(void))viewMaxY
{
    return ^CGFloat(){
        LinkHandle_VAL_IFNOT(UIView){
            return 0.0;
        }
        LinkGroupHandle_VAL(viewMaxY)
        return CGRectGetMaxY(_self.frame);
    };
}

- (UIView *(^)(void))viewBringFrontInSuperview
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewBringFrontInSuperview)
        [_self.superview bringSubviewToFront:_self];
        return _self;
    };
}

- (UIView *(^)(void))viewSendBackInSuperview
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewSendBackInSuperview)
        [_self.superview sendSubviewToBack:_self];
        return _self;
    };
}

- (UIView *(^)(void))viewRemoveConstraints
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewRemoveConstraints)
        [_self removeConstraints:_self.constraints];
        if(_self.superview){
            [_self.superview.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull constraint, NSUInteger idx, BOOL * _Nonnull stop) {
                if([constraint.firstItem isEqual:_self]){
                    [_self.superview removeConstraint:constraint];
                }
            }];
        }
        return _self;
    };
}

- (UIView *(^)(CGFloat))viewConstraintWidth
{
    return ^id(CGFloat value){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewConstraintWidth,value)
        
        __block BOOL modified = NO;
        [_self.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull constraint, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([constraint.firstItem isEqual:_self] && constraint.firstAttribute == NSLayoutAttributeWidth && !constraint.secondItem){
                constraint.constant = value;
                modified = YES;
            }
        }];
        
        if(!modified){
            
            [_self addConstraint:[NSLayoutConstraint constraintWithItem:_self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:value]];
        }
        return _self;
    };
}

- (UIView *(^)(CGFloat))viewConstraintHeight
{
    return ^id(CGFloat value){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewConstraintHeight,value)
        
        __block BOOL modified = NO;
        [_self.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull constraint, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([constraint.firstItem isEqual:_self] && constraint.firstAttribute == NSLayoutAttributeHeight && !constraint.secondItem){
                constraint.constant = value;
                modified = YES;
            }
        }];
        
        if(!modified){
            
            [_self addConstraint:[NSLayoutConstraint constraintWithItem:_self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:value]];
        }
        
        return _self;
    };
}

- (UIView *(^)(CGFloat))viewConstraintTop
{
    return ^id(CGFloat value){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewConstraintHeight,value)
        
        [_self.superview.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull constraint, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([constraint.firstItem isEqual:_self] && constraint.firstAttribute == NSLayoutAttributeTop){
                
                constraint.constant = value;
            }else if ([constraint.secondItem isEqual:_self] && constraint.secondAttribute == NSLayoutAttributeTop){
                
                constraint.constant = value;
            }
        }];
        return _self;
    };
}

- (UIView *(^)(CGFloat))viewConstraintBottom
{
    return ^id(CGFloat value){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewConstraintBottom,value)
        
        [_self.superview.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull constraint, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([constraint.firstItem isEqual:_self] && constraint.firstAttribute == NSLayoutAttributeBottom){
                
                constraint.constant = value;
            }else if ([constraint.secondItem isEqual:_self] && constraint.secondAttribute == NSLayoutAttributeBottom){
                
                constraint.constant = value;
            }
        }];
        return _self;
    };
}

- (UIView *(^)(CGFloat))viewConstraintLeft
{
    return ^id(CGFloat value){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewConstraintLeft,value)
        
        [_self.superview.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull constraint, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([constraint.firstItem isEqual:_self] && constraint.firstAttribute == NSLayoutAttributeLeft){
                
                constraint.constant = value;
            }else if ([constraint.secondItem isEqual:_self] && constraint.secondAttribute == NSLayoutAttributeLeft){
                
                constraint.constant = value;
            }
        }];
        return _self;
    };
}

- (UIView *(^)(CGFloat))viewConstraintRight
{
    return ^id(CGFloat value){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewConstraintRight,value)
        
        [_self.superview.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull constraint, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([constraint.firstItem isEqual:_self] && constraint.firstAttribute == NSLayoutAttributeRight){
                
                constraint.constant = value;
            }else if ([constraint.secondItem isEqual:_self] && constraint.secondAttribute == NSLayoutAttributeRight){
                
                constraint.constant = value;
            }
        }];
        return _self;
    };
}

- (UIView *(^)(CGFloat))viewConstraintLeading
{
    return ^id(CGFloat value){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewConstraintLeading,value)
        
        [_self.superview.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull constraint, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([constraint.firstItem isEqual:_self] && constraint.firstAttribute == NSLayoutAttributeLeading){
                
                constraint.constant = value;
            }else if ([constraint.secondItem isEqual:_self] && constraint.secondAttribute == NSLayoutAttributeLeading){
                
                constraint.constant = value;
            }
        }];
        return _self;
    };
}

- (UIView *(^)(CGFloat))viewConstraintTrailing
{
    return ^id(CGFloat value){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewConstraintTrailing,value)
        
        [_self.superview.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull constraint, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([constraint.firstItem isEqual:_self] && constraint.firstAttribute == NSLayoutAttributeTrailing){
                
                constraint.constant = value;
            }else if ([constraint.secondItem isEqual:_self] && constraint.secondAttribute == NSLayoutAttributeTrailing){
                
                constraint.constant = value;
            }
        }];
        return _self;
    };
}

- (UIView *(^)(CGFloat))viewConstraintLeftOrLeading
{
    return ^id(CGFloat value){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewConstraintLeftOrLeading,value)
        
        [_self.superview.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull constraint, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([constraint.firstItem isEqual:_self] && (constraint.firstAttribute == NSLayoutAttributeLeft || constraint.firstAttribute == NSLayoutAttributeLeading)){
                
                constraint.constant = value;
            }else if ([constraint.secondItem isEqual:_self] && (constraint.secondAttribute == NSLayoutAttributeLeft || constraint.secondAttribute == NSLayoutAttributeLeading)){
                
                constraint.constant = value;
            }
        }];
        return _self;
    };
}

- (UIView *(^)(CGFloat))viewConstraintRightOrTrailing
{
    return ^id(CGFloat value){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewConstraintRightOrTrailing,value)
        
        [_self.superview.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull constraint, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([constraint.firstItem isEqual:_self] && (constraint.firstAttribute == NSLayoutAttributeRight || constraint.firstAttribute == NSLayoutAttributeTrailing)){
                
                constraint.constant = value;
            }else if ([constraint.secondItem isEqual:_self] && (constraint.secondAttribute == NSLayoutAttributeRight || constraint.secondAttribute == NSLayoutAttributeTrailing)){
                
                constraint.constant = value;
            }
        }];
        return _self;
    };
}


- (UIView *(^)(CGFloat))viewConstraintCenterX
{
    return ^id(CGFloat value){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewConstraintCenterX,value)
        
        [_self.superview.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull constraint, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([constraint.firstItem isEqual:_self] && constraint.firstAttribute == NSLayoutAttributeCenterX){
                
                constraint.constant = value;
            }else if ([constraint.secondItem isEqual:_self] && constraint.secondAttribute == NSLayoutAttributeCenterX){
                
                constraint.constant = value;
            }
        }];
        return _self;
    };
}

- (UIView *(^)(CGFloat))viewConstraintCenterY
{
    return ^id(CGFloat value){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewConstraintCenterY,value)
        
        [_self.superview.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull constraint, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([constraint.firstItem isEqual:_self] && constraint.firstAttribute == NSLayoutAttributeCenterY){
                
                constraint.constant = value;
            }else if ([constraint.secondItem isEqual:_self] && constraint.secondAttribute == NSLayoutAttributeCenterY){
                
                constraint.constant = value;
            }
        }];
        return _self;
    };
}

- (UIView *(^)(CGFloat))viewConstraintLastBaseline
{
    return ^id(CGFloat value){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewConstraintLastBaseline,value)
        
        [_self.superview.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull constraint, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([constraint.firstItem isEqual:_self] && constraint.firstAttribute == NSLayoutAttributeLastBaseline){
                
                constraint.constant = value;
            }else if ([constraint.secondItem isEqual:_self] && constraint.secondAttribute == NSLayoutAttributeLastBaseline){
                
                constraint.constant = value;
            }
        }];
        return _self;
    };
}

- (UIView *(^)(CGFloat))viewConstraintBaseline
{
    return self.viewConstraintLastBaseline;
}

- (UIView *(^)(CGFloat))viewConstraintFirstBaseline
{
    return ^id(CGFloat value){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewConstraintFirstBaseline,value)
        
        [_self.superview.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull constraint, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([constraint.firstItem isEqual:_self] && constraint.firstAttribute == NSLayoutAttributeFirstBaseline){
                
                constraint.constant = value;
            }else if ([constraint.secondItem isEqual:_self] && constraint.secondAttribute == NSLayoutAttributeFirstBaseline){
                
                constraint.constant = value;
            }
        }];
        return _self;
    };
}



- (BOOL (^)(void))viewIsUsingAutolayout
{
    return ^BOOL(){
        LinkHandle_VAL_IFNOT(UIView){
            return NO;
        }
        LinkGroupHandle_VAL(viewIsUsingAutolayout)
        
        //自身
        if(_self.constraints.count>0)
            return YES;
        
        //父视图
        if([[_self.superview.constraints valueForKey:@"firstItem"] indexOfObject:_self] != NSNotFound)
            return YES;
        
        if([[_self.superview.constraints valueForKey:@"secondItem"] indexOfObject:_self] != NSNotFound)
            return YES;
        
        //兄视图
        __block BOOL result = NO;
        [_self.superview.subviews enumerateObjectsUsingBlock:^(UIView * _Nonnull subview, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if(subview != _self){
                
                if([[subview.constraints valueForKey:@"firstItem"] indexOfObject:_self] != NSNotFound){
                    
                    result = YES;
                    *stop = YES;
                }else if([[subview.constraints valueForKey:@"secondItem"] indexOfObject:_self] != NSNotFound){
                    
                    result = YES;
                    *stop = YES;
                }
            }
        }];
        
        return result;
    };
}

- (BOOL (^)(void))viewIsUsingAutoresizing
{
    return ^BOOL(){
        LinkHandle_VAL_IFNOT(UIView){
            return NO;
        }
        LinkGroupHandle_VAL(viewIsUsingAutoresizing)
        return _self.autoresizingMask;
    };
}

- (UIView *(^)(void))viewRemoveAutoresizing
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewRemoveAutoresizing)
        _self.autoresizingMask=UIViewAutoresizingNone;
        _self.translatesAutoresizingMaskIntoConstraints=NO;
        return _self;
    };
}

- (UIView *(^)(id))viewConstraintActiveByPriority
{
    return ^id(id asPriority){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewConstraintActiveByPriority, asPriority)
        
        if([asPriority isKindOfClass:NSArray.class] == NO)
            
            asPriority = [NSArray arrayWithObject:asPriority];
        [_self setContentHuggingPriority:0 forAxis:0];
        for (NSLayoutConstraint* item in _self.constraints)
        {
            //"Height" or "Width" constraint,"self" as its first item, no second item
            if(item.secondItem == nil   ||
               //"Aspect ratio" constraint,"self" as its first AND second item
               [item.firstItem isEqual:item.secondItem])
            {
                item.active = [asPriority containsObject:@(item.priority)];
            }
        }
        
        if(_self.superview.constraints.count == 0)
            
            return _self;
        
        for (NSLayoutConstraint* item in _self.superview.constraints)
        {
            if([item.firstItem isEqual:self] || [item.secondItem isEqual:self])
            {
                item.active = [asPriority containsObject:@(item.priority)];
            }
        }
        
        return _self;
    };
}

- (UIView *(^)(void))viewPrevIndexView
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewPrevIndexView)
        return _self.objBeforeInArr(_self.subviews);
    };
}

- (UIView *(^)(void))viewNextIndexView
{
    return ^id(){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewNextIndexView)
        return _self.objGetNextItemFromObjs(_self.subviews);
    };
}

- (BOOL (^)(UIView *))viewContainsView
{
    return ^(UIView* aView){
        LinkHandle_VAL_IFNOT(UIView){
            return NO;
        }
        LinkGroupHandle_VAL(viewContainsView,aView)
        __block BOOL re = NO;
        [aView viewEnumerateSuperviewUsingBlock:^(UIView *superview, BOOL *stop) {
            if([superview isEqual: _self]) {
                re = YES;*stop = re;
            }
        }];
        return re;
    };
}

- (UIView *(^)(CGFloat))viewSetWidthAspect
{
    return ^id(CGFloat newWidth){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewSetWidthAspect,newWidth)
        __block CGFloat w = 0;
        __block CGFloat h = 0;
        CGFloat k;
        CGFloat newHeight;
        if(_self.constraints.count){
            [_self.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull constraint, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if(constraint.firstAttribute == NSLayoutAttributeWidth){
                    w = constraint.constant;
                }else if (constraint.firstAttribute == NSLayoutAttributeHeight){
                    h = constraint.constant;
                }
            }];
        }
        
        if(w && h){//使用autolayout时
            if(!w)  return _self;
            k =  newWidth/w;
            newHeight = k*h;
            [_self.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull constraint, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if(constraint.firstAttribute == NSLayoutAttributeWidth){
                    constraint.constant = newWidth;
                }else if (constraint.firstAttribute == NSLayoutAttributeHeight){
                    constraint.constant = newHeight;
                }
            }];
        }else{
            w = _self.frame.size.width;
            h = _self.frame.size.height;
            k =  newWidth/w;
            if(!w)  return _self;
            newHeight = k*h;
            CGRect frame = _self.frame;
            frame.size.width = newWidth;
            frame.size.height = newHeight;
            _self.frame = frame;
        }
        return _self;
    };
}

- (UIView *(^)(CGFloat))viewSetHeightAspect
{
    return ^id(CGFloat newHeight){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewSetHeightAspect,newHeight)
        CGFloat k;
        CGFloat newWidth;
        __block CGFloat w = 0;
        __block CGFloat h = 0;
        if(_self.constraints.count){
            [_self.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull constraint, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if(constraint.firstAttribute == NSLayoutAttributeWidth){
                    w = constraint.constant;
                }else if (constraint.firstAttribute == NSLayoutAttributeHeight){
                    h = constraint.constant;
                }
            }];
        }
        
        if(w && h){//使用autolayout时
            if(!h)  return _self;
            k =  newHeight/h;
            newWidth = k*w;
            [_self.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull constraint, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if(constraint.firstAttribute == NSLayoutAttributeWidth){
                    constraint.constant = newWidth;
                }else if (constraint.firstAttribute == NSLayoutAttributeHeight){
                    constraint.constant = newHeight;
                }
            }];
        }else{
            w = _self.frame.size.width;
            h = _self.frame.size.height;
            k =  newHeight/h;
            if(!h)  return _self;
            newWidth = k*w;
            CGRect frame = _self.frame;
            frame.size.width =  newWidth;
            frame.size.height = newHeight;
            _self.frame = frame;
        }
        return _self;
    };
}
@end


@implementation UIView (UIViewLinkBlock)
- (UIButton*)viewAddTestBtn:(CGRect)frame block:(void(^)(NSInteger idx, UIButton* testButton))block
{
    UIButton* btn=UIButtonNew.viewBGColor([UIColor lightGrayColor])
    .viewAddToView(self).btnTitleFont([UIFont systemFontOfSize:12]);
    btn.frame=frame;;
    [btn addTarget:btn action:@selector(_lb_ClickTestBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [btn lb_SetBlock_ClickTestBtnBlock:block];
    [btn lb_SetBlock_ClickTestBtnNumFlag:0];
    return btn;
}

- (void)viewEnumerateSuperviewUsingBlock:(void (^)(UIView *, BOOL *))block
{
    BOOL stop=NO;
    [self viewEnumerateSuperview:&stop blcok:block];
}
//private
- (void)viewEnumerateSuperview:(BOOL*)stop blcok:(void (^)(UIView *, BOOL *))block
{
    if(*stop)return;
    if(self.superview){
        block(self.superview , stop);
        [self.superview viewEnumerateSuperview:stop blcok:block];
    }
}

- (void)viewEnumerateSubviewsUsingBlock:(void (^)(UIView *, NSUInteger,NSUInteger, BOOL *))block
{
    [self _lb_viewEnumerateSubviewsFromDeep:0 usingBlock:block];
}

//private
- (void)_lb_viewEnumerateSubviewsFromDeep:(NSUInteger)deep usingBlock:(void (^)(UIView *subview, NSUInteger deep,NSUInteger idx, BOOL *stop))block
{
    if(self.subviews.count){
        
        deep++;
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subview, NSUInteger idx, BOOL * _Nonnull stop) {
            
            block(subview,deep,idx,stop);
            if(subview.subviews.count){
                [subview _lb_viewEnumerateSubviewsFromDeep:deep usingBlock:block];
            }
        }];
    }
}

- (void)_lb_ClickTestBtnAction
{
    if(![self isKindOfClass:[UIButton class]])
        return;
    UIButton* _self= (UIButton*)self;
    
    void(^block)(NSInteger idx, UIButton* testButton) = [self lb_GetBlock_ClickTestBtnBlock];
    if(block){
        NSInteger num=[self lb_GetBlock_ClickTestBtnNumFlag];
        block(num,_self);
        [self lb_SetBlock_ClickTestBtnNumFlag:++num];
    }
}

/** 回调block */
static char _lb_key_clickTestBtnBlock;
- (void)lb_SetBlock_ClickTestBtnBlock:(id)block
{
    objc_setAssociatedObject(self, &_lb_key_clickTestBtnBlock, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (id)lb_GetBlock_ClickTestBtnBlock
{
    return objc_getAssociatedObject(self, &_lb_key_clickTestBtnBlock);
}
/** 点击次数 */
static char _lb_key_clickTestBtnNumFlag;
- (void)lb_SetBlock_ClickTestBtnNumFlag:(NSInteger)num
{
    objc_setAssociatedObject(self, &_lb_key_clickTestBtnNumFlag, @(num), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSInteger)lb_GetBlock_ClickTestBtnNumFlag
{
    return [objc_getAssociatedObject(self, &_lb_key_clickTestBtnNumFlag) integerValue];
}
@end
