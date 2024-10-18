//
//  CABasicAnimation+LinkBlock.h
//  LinkBlockProgram
//
//  Created by NOVO on 17/4/26.
//  Copyright © 2017年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

#ifndef CAAnimationNew
#define CAAnimationNew ([CAAnimation animation])
#endif

#ifndef CAPropertyAnimationNew
#define CAPropertyAnimationNew ([CAPropertyAnimation animation])
#endif

#ifndef CABasicAnimationNew
#define CABasicAnimationNew ([CABasicAnimation animation])
#endif

#ifndef CAKeyframeAnimationNew
#define CAKeyframeAnimationNew ([CAKeyframeAnimation animation])
#endif

#ifndef CASpringAnimationNew
#define CASpringAnimationNew ([CASpringAnimation animation])
#endif

#ifndef CAAnimationGroupNew
#define CAAnimationGroupNew ([CAAnimationGroup animation])
#endif


/**
 include CAAnimation，CAPropertyAnimation，CABasicAnimation，CAKeyframeAnimation，CASpringAnimation的扩展
 */
@interface NSObject(CAAnimationsLinkBlock)
#pragma mark - Foundation Mirror/镜像
#pragma mark -- CAAnimation

@property(nonatomic,copy,readonly)
    CAAnimation*(^animationRemovedOnCompletion)(BOOL removedOnCompletion);

@property LB_BK CAAnimation*              (^animationTimingFunction)(CAMediaTimingFunction* timingFunction);

#pragma mark -- CAPropertyAnimation
@property LB_BK CAPropertyAnimation*      (^animationKeyPath)(NSString *keyPath);
@property LB_BK CAPropertyAnimation*      (^animationValueFunction)(CAValueFunction *valueFunction);

#pragma mark -- CAKeyframeAnimation
@property LB_BK CAKeyframeAnimation*      (^animationValues)(NSArray *values);
@property LB_BK CAKeyframeAnimation*      (^animationPath)(CGPathRef path);
@property LB_BK CAKeyframeAnimation*      (^animationKeyTimes)(NSArray<NSNumber *> *keyTimes);
@property LB_BK CAKeyframeAnimation*      (^animationTimingFunctions)(NSArray<CAMediaTimingFunction *> *timingFunctions);
@property LB_BK CAKeyframeAnimation*      (^animationCalculationMode)(NSString *calculationMode);
@property LB_BK CAKeyframeAnimation*      (^animationTensionValues)(NSArray<NSNumber *> *tensionValues);
@property LB_BK CAKeyframeAnimation*      (^animationContinuityValues)(NSArray<NSNumber *> *continuityValues);
@property LB_BK CAKeyframeAnimation*      (^animationBiasValues)(NSArray<NSNumber *> *biasValues);
@property LB_BK CAKeyframeAnimation*      (^animationRotationMode)(NSString *rotationMode);

#pragma mark -- CASpringAnimation
@property LB_BK CASpringAnimation*        (^animationMass)(CGFloat mass);
@property LB_BK CASpringAnimation*        (^animationStiffness)(CGFloat stiffness);
@property LB_BK CASpringAnimation*        (^animationDamping)(CGFloat damping);
@property LB_BK CASpringAnimation*        (^animationInitialVelocity)(CGFloat initialVelocity);

#pragma mark -- CABasicAnimation
@property LB_BK CABasicAnimation*         (^animationFromValue)(id value);
@property LB_BK CABasicAnimation*         (^animationToValue)(id value);
@property LB_BK CABasicAnimation*         (^animationByValue)(id value);

#pragma mark -- CAAnimationGroup
@property LB_BK CAAnimationGroup*         (^animationGroupAnimations)(NSArray<CAAnimation *> *animations);
@end
