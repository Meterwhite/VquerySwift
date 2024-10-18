//
//  UIView+LinkBlock.h
//
//  Created by NOVO on 15/8/12.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

#define UIViewNew ([UIView new])
@interface NSObject(UIViewLinkBlock)

#pragma mark Foundation Mirror/镜像

@property LB_BK UIView*      (^viewBGColor)(UIColor* color);
@property LB_BK UIView*      (^viewSetTag)(NSInteger tag);
@property LB_BK UIView*      (^viewSetFrameVal)(CGRect frame);
@property LB_BK UIView*      (^viewSetBoundsVal)(CGRect bounds);
@property LB_BK UIView*      (^viewSetOriginVal)(CGPoint origin);
@property LB_BK UIView*      (^viewSetCenterVal)(CGPoint center);
@property LB_BK UIView*      (^viewSetSizeVal)(CGSize size);
@property LB_BK UIView*      (^viewClipsToBounds)(BOOL b);
@property LB_BK UIView*      (^viewEndEditing)(BOOL force);
@property LB_BK UIView*      (^viewUserInteractionEnabled)(BOOL b);
@property LB_BK UIView*      (^viewHidden)(BOOL hidden);
@property LB_BK UIView*      (^viewContentMode)(UIViewContentMode contentMode);
@property LB_BK UIView*      (^viewBecomeFirstResponder)(void);
@property LB_BK UIView*      (^viewResignFirstResponder)(void);
@property LB_BK UIView*      (^viewSubviewsExclusiveTouch)(BOOL b);
@property LB_BK BOOL         (^viewIsFirstResponder)(void);
@property LB_BK UIView*      (^viewAlpha)(CGFloat alpha);
@property LB_BK UIView*      (^viewOpaque)(CGFloat opaque);
@property LB_BK UIView*      (^viewMultipleTouchEnabled)(BOOL b);
@property LB_BK UIView*      (^viewExclusiveTouch)(BOOL b);
@property LB_BK UIView*      (^viewAutoresizingMask)(UIViewAutoresizing mask);
@property LB_BK UIView*      (^viewSetNeedsLayout)(void);
@property LB_BK UIView*      (^viewLayoutIfNeeded)(void);
@property LB_BK UIView*      (^viewSetNeedsDisplay)(void);
@property LB_BK UIView*      (^viewAddSubview)(UIView* subview);
@property LB_BK UIView*      (^viewRemoveFromSuperview)(void);
@property LB_BK UIView*      (^viewExchangeSubviewByIndex)(NSUInteger index1, NSUInteger index2);


#pragma mark - Foundation Speed/速度
/** === CGRectIsEmpty */
@property LB_BK BOOL         (^viewIsZeroSize)(void);
@property LB_BK CGFloat      (^viewX)(void);
@property LB_BK CGFloat      (^viewY)(void);
@property LB_BK CGFloat      (^viewMaxX)(void);
@property LB_BK CGFloat      (^viewMaxY)(void);
@property LB_BK CGPoint      (^viewOrigin)(void);
@property LB_BK CGFloat      (^viewCenterX)(void);
@property LB_BK CGFloat      (^viewCenterY)(void);
@property LB_BK CGFloat      (^viewWidth)(void);
@property LB_BK CGFloat      (^viewHeight)(void);
@property LB_BK CGSize       (^viewSize)(void);
@property LB_BK UIView*      (^viewSetFrame)(CGFloat x,CGFloat y, CGFloat width,CGFloat height);
@property LB_BK UIView*      (^viewSetBounds)(CGFloat x,CGFloat y, CGFloat width,CGFloat height);
@property LB_BK UIView*      (^viewSetX)(CGFloat x);
@property LB_BK UIView*      (^viewSetY)(CGFloat y);
@property LB_BK UIView*      (^viewSetWidth)(CGFloat width);
@property LB_BK UIView*      (^viewSetHeight)(CGFloat height);
@property LB_BK UIView*      (^viewSetCenterX)(CGFloat centerX);
@property LB_BK UIView*      (^viewSetCenterY)(CGFloat centerY);
@property LB_BK UIView*      (^viewSetOrigin)(CGFloat x,CGFloat y);
@property LB_BK UIView*      (^viewSetCenter)(CGFloat x,CGFloat y);
@property LB_BK UIView*      (^viewSetSize)(CGFloat width, CGFloat height);
@property LB_BK NSValue*     (^viewFrameValue)(void);
@property LB_BK NSValue*     (^viewBoundsValue)(void);
@property LB_BK UIView*      (^viewBorderColor)(UIColor* color);
@property LB_BK UIView*      (^viewBorderWidth)(CGFloat w);
@property LB_BK UIView*      (^viewBorderColorAndWidth)(UIColor* color,CGFloat w);
@property LB_BK UIView*      (^viewCornerRadius)(CGFloat radius);
@property LB_BK UIView*      (^viewCornerRadiusAndClipsToBounds)(CGFloat radius);
@property LB_BK UIView*      (^viewCornerRadiusSide)(UIRectCorner side , CGSize radius);
@property LB_BK UIView*      (^viewBringFrontInSuperview)(void);
@property LB_BK UIView*      (^viewSendBackInSuperview)(void);
@property LB_BK UIView*      (^viewBGColorWhite)(void);
@property LB_BK UIView*      (^viewBGColorClear)(void);
@property LB_BK UIView*      (^viewBGColorRed)(void);
@property LB_BK UIView*      (^viewBGColorRandom)(void);
@property LB_BK UIView*      (^viewClipsToBoundsYES)(void);
@property LB_BK UIView*      (^viewClipsToBoundsNO)(void);
@property LB_BK UIView*      (^viewEndEditingYES)(void);
@property LB_BK UIView*      (^viewUserInteractionEnabledYES)(void);
@property LB_BK UIView*      (^viewUserInteractionEnabledNO)(void);
@property LB_BK UIView*      (^viewHiddenYES)(void);
@property LB_BK UIView*      (^viewHiddenNO)(void);
@property LB_BK UIView*      (^viewContentModeScaleToFill)(void);
@property LB_BK UIView*      (^viewContentModeScaleAspectFit)(void);
@property LB_BK UIView*      (^viewContentModeScaleAspectFill)(void);
@property LB_BK UIView*      (^viewContentModeRedraw)(void);
@property LB_BK UIView*      (^viewContentModeCenter)(void);
@property LB_BK UIView*      (^viewContentModeTop)(void);
@property LB_BK UIView*      (^viewContentModeBottom)(void);
@property LB_BK UIView*      (^viewContentModeLeft)(void);
@property LB_BK UIView*      (^viewContentModeRight)(void);
@property LB_BK UIView*      (^viewContentModeTopLeft)(void);
@property LB_BK UIView*      (^viewContentModeTopRight)(void);
@property LB_BK UIView*      (^viewContentModeBottomLeft)(void);
@property LB_BK UIView*      (^viewContentModeBottomRight)(void);
@property LB_BK UIView*      (^viewContentHuggingHorizentalPriority)(UILayoutPriority priority);
@property LB_BK UIView*      (^viewContentHuggingVerticalPriority)(UILayoutPriority priority);
@property LB_BK UIView*      (^viewContentCompressionResistanceHorizentalPriority)(UILayoutPriority priority);
@property LB_BK UIView*      (^viewContentCompressionResistanceVerticalPriority)(UILayoutPriority priority);


#pragma mark - Foundation Extend/补充
@property LB_BK UIView*      (^viewAddSubviews)(UIView* v0,...);
@property LB_BK UIView*      (^viewAddToView)(__weak UIView* view);
@property LB_BK UIView*      (^viewAddToStackViewArranged)(__weak UIStackView* stackView);
@property LB_BK UIView*      (^viewRemoveAllSubview)(void);
/** 判断后代视图 */
@property LB_BK BOOL         (^viewIsInView)(UIView* view);
/** 判断前辈视图 */
@property LB_BK BOOL         (^viewContainsView)(UIView* view);
/** <^(BOOL b)>控件相对window的位置 */
@property LB_BK CGRect       (^viewConvertRectToWindow)(void);
@property LB_BK UIView*      (^viewSubviewAt)(NSUInteger index);
@property LB_BK UIView*      (^viewRemoveSubviewAt)(NSUInteger index);
/** <^()>在父视图中的索引。如果没有则返回nil */
@property LB_BK NSNumber*    (^viewIndexInSuperviewAs)(void);
/** <^()>视图截屏 */
@property LB_BK UIImage*     (^viewSnapshot)(void);
@property LB_BK UIView*      (^viewInsertSubviewAtIndex)(UIView* subView, NSUInteger index);
@property LB_BK UIView*      (^viewInsertToViewAtIndex)(UIView* toView, NSUInteger index);
@property LB_BK UIView*      (^viewInsertSubviewAbouve)(UIView* subView, UIView* abouveView);
@property LB_BK UIView*      (^viewInsertToViewAbouve)(UIView* toView, UIView* abouveView);
@property LB_BK UIView*      (^viewInsertSubviewBelow)(UIView* subView, UIView* belowView);
@property LB_BK UIView*      (^viewInsertToViewBelow)(UIView* toView, UIView* belowView);



#pragma mark - LinkBlock
@property LB_BK NSMutableArray*      (^viewFindSubviewsOfClass)(Class clazz);
/** Set width and aspect ratio.Autolayout first.*/
@property LB_BK UIView*      (^viewSetWidthAspect)(CGFloat width);
@property LB_BK UIView*      (^viewSetHeightAspect)(CGFloat height);
/** Traversal for first responder about input control */
@property LB_BK UIView*      (^viewFindFirstResponderSubViewOfTextInput)(void);
/** Get previous sibling item(index-1 in superview) else NSNull. */
@property LB_BK UIView*      (^viewPrevIndexView)(void);
/** Get next sibling item(index+1 in superview) else NSNull. */
@property LB_BK UIView*      (^viewNextIndexView)(void);
/**
 *  Change superview.If isKeep==YES means Keep current visual position unchanged.
 *  note:Not suport Autolayou
 *  更换父视图,isKeep是否保持当前视觉位置不变，否则保持frame不变
 */
@property LB_BK UIView*      (^viewConvertSuperviewTo)(UIView* newSuperview , BOOL isKeep);

@property LB_BK BOOL         (^viewIsUsingAutolayout)(void);

@property LB_BK BOOL         (^viewIsUsingAutoresizing)(void);
@property LB_BK UIView*      (^viewRemoveAutoresizing)(void);

/**
 Control constraint version use prioriry value.
 active = YES; Otherwise NO;
 
 asPriority ∈ {NSNumber | NSArray<NSNumber*>}
 : @(UILayoutPriority number)
 */
@property LB_BK UIView*      (^viewConstraintActiveByPriority)(id asPriority);

#pragma mark - Animation 动画
@property LB_BK UIView*      (^viewHiddenYESUsingAnimate)(NSTimeInterval during);
@property LB_BK UIView*      (^viewHiddenNOUsingAnimate)(NSTimeInterval during);
/** note: position is changed/真实移动了视图的位置 */
@property LB_BK UIView*      (^viewAnimateMoveUp)(CGFloat distance, NSTimeInterval time);
@property LB_BK UIView*      (^viewAnimateMoveDown)(CGFloat distance, NSTimeInterval time);
@property LB_BK UIView*      (^viewAnimateMoveRight)(CGFloat distance, NSTimeInterval time);
@property LB_BK UIView*      (^viewAnimateMoveLeft)(CGFloat distance, NSTimeInterval time);
/** Shake Horizental/水平摇晃 */
@property LB_BK UIView*      (^viewAnimateShakeHorizental)(double duration);
/** Shake Vertical/垂直摇晃 */
@property LB_BK UIView*      (^viewAnimateShakeVertical)(double duration);
/** 苹果桌面视差效果 */
@property LB_BK UIView*      (^viewAnimateAppleMotionEffects)(void)
NS_DEPRECATED_IOS(2_0, 7_0, "ios more than 7.0 effective");
/** Pulse scale size/脉冲形式的放大缩小 */
@property LB_BK UIView*      (^viewAnimatePulse)(CGFloat scale,NSTimeInterval duration,BOOL repeat);
/** Flip from top/上翻转 */
@property LB_BK UIView*      (^viewAnimateFlipFromTop)
(
 NSTimeInterval duration,
 NSUInteger repeatCount,
 BOOL shouldAutoreverse
 );
/** Flip from bottom/下翻转 */
@property LB_BK UIView*      (^viewAnimateFlipFromBottom)
(
 NSTimeInterval duration,
 NSUInteger repeatCount,
 BOOL shouldAutoreverse
 );
/** Flip from right/右翻转 */
@property LB_BK UIView*      (^viewAnimateFlipFromRight)
(
 NSTimeInterval duration,
 NSUInteger repeatCount,
 BOOL shouldAutoreverse
 );
/** Flip from left/左翻转 */
@property LB_BK UIView*      (^viewAnimateFlipFromLeft)
(
 NSTimeInterval duration,
 NSUInteger repeatCount,
 BOOL shouldAutoreverse
 );
/** Rotate/旋转动画 */
@property LB_BK UIView*      (^viewAnimateRotateToRight)
(
 CGFloat angle,
 NSTimeInterval duration,
 NSUInteger repeatCount,
 BOOL shouldAutoreverse
 );
/** Rotate/旋转动画 */
@property LB_BK UIView*      (^viewAnimateRotateToLeft)
(
 CGFloat angle,
 NSTimeInterval duration,
 NSUInteger repeatCount,
 BOOL shouldAutoreverse
);
@property LB_BK UIView*      (^viewAnimateOpacity)(CGFloat from,CGFloat to,NSTimeInterval duration);
@property LB_BK UIView*      (^viewAnimateRemove)(void);
@property LB_BK BOOL         (^viewAnimateIsDoing)(void);
@property LB_BK UIView*      (^viewAnimatePause)(void);
/** Resume animate after pause /恢复暂停的动画 */
@property LB_BK UIView*      (^viewAnimateResume)(void);

#pragma mark - Autolayout 自动布局
/**
 *  remove constraint from current view and superview
 *  移除当前视图约束以及父视图中的相关约束
 */
@property LB_BK UIView*      (^viewRemoveConstraints)(void);
/** Craete or modify constraint value */
@property LB_BK UIView*      (^viewConstraintWidth)(CGFloat value);
@property LB_BK UIView*      (^viewConstraintHeight)(CGFloat value);
/** Only modify constraint value,if it exsist */
@property LB_BK UIView*      (^viewConstraintTop)(CGFloat value);
@property LB_BK UIView*      (^viewConstraintBottom)(CGFloat value);
@property LB_BK UIView*      (^viewConstraintLeading)(CGFloat value);
@property LB_BK UIView*      (^viewConstraintTrailing)(CGFloat value);
@property LB_BK UIView*      (^viewConstraintLeft)(CGFloat value);
@property LB_BK UIView*      (^viewConstraintRight)(CGFloat value);
@property LB_BK UIView*      (^viewConstraintLeftOrLeading)(CGFloat value);
@property LB_BK UIView*      (^viewConstraintRightOrTrailing)(CGFloat value);
@property LB_BK UIView*      (^viewConstraintCenterX)(CGFloat value);
@property LB_BK UIView*      (^viewConstraintCenterY)(CGFloat value);
@property LB_BK UIView*      (^viewConstraintBaseline)(CGFloat value);
@property LB_BK UIView*      (^viewConstraintLastBaseline)(CGFloat value);
@property LB_BK UIView*      (^viewConstraintFirstBaseline)(CGFloat value);

@end

@interface UIView (UIViewLinkBlock)
#pragma mark - For test
/**
 Add a button for test.
 self-increase 1 after once click.
 */
- (UIButton*)viewAddTestBtn:(CGRect)frame
                      block:(void(^)(NSInteger idx, UIButton* testButton))block;

- (void)viewEnumerateSubviewsUsingBlock:(void(^)(UIView* subview , NSUInteger depth , NSUInteger idx , BOOL* stop))block;

- (void)viewEnumerateSuperviewUsingBlock:(void(^)(UIView* superview,BOOL* stop))block;
@end
