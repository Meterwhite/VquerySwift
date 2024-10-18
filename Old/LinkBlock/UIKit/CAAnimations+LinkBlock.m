//
//  CABasicAnimation+LinkBlock.m
//  LinkBlockProgram
//
//  Created by NOVO on 17/4/26.
//  Copyright © 2017年 NOVO. All rights reserved.
//

#import "LinkBlock.h"

@implementation NSObject(CAAnimationsLinkBlock)

- (CAAnimation *(^)(BOOL))animationRemovedOnCompletion
{
    return ^id(BOOL removedOnCompletion){
        LinkHandle_REF(CAAnimation)
        LinkGroupHandle_REF(animationRemovedOnCompletion,removedOnCompletion)
        _self.removedOnCompletion = removedOnCompletion;
        return _self;
    };
}

- (CAAnimation *(^)(CAMediaTimingFunction *))animationTimingFunction
{
    return ^id(CAMediaTimingFunction* timingFunction){
        LinkHandle_REF(CAAnimation)
        LinkGroupHandle_REF(animationTimingFunction,timingFunction)
        _self.timingFunction = timingFunction;
        return _self;
    };
}

- (CAPropertyAnimation *(^)(NSString *))animationKeyPath
{
    return ^id(NSString *keyPath){
        LinkHandle_REF(CAPropertyAnimation)
        LinkGroupHandle_REF(animationKeyPath,keyPath)
        _self.keyPath = keyPath;
        return _self;
    };
}

- (CAPropertyAnimation *(^)(CAValueFunction *))animationValueFunction
{
    return ^id(CAValueFunction *valueFunction){
        LinkHandle_REF(CAPropertyAnimation)
        LinkGroupHandle_REF(animationValueFunction,valueFunction)
        _self.valueFunction = valueFunction;
        return _self;
    };
}

- (CAKeyframeAnimation *(^)(NSArray *))animationValues
{
    return ^id(NSArray *values){
        LinkHandle_REF(CAKeyframeAnimation)
        LinkGroupHandle_REF(animationValues,values)
        _self.values = values;
        return _self;
    };
}

- (CAKeyframeAnimation *(^)(CGPathRef))animationPath
{
    return ^id(CGPathRef path){
        LinkHandle_REF(CAKeyframeAnimation)
        LinkGroupHandle_REF(animationPath,path)
        _self.path = path;
        return _self;
    };
}

- (CAKeyframeAnimation *(^)(NSArray<NSNumber *> *))animationKeyTimes
{
    return ^id(NSArray<NSNumber *> *keyTimes){
        LinkHandle_REF(CAKeyframeAnimation)
        LinkGroupHandle_REF(animationKeyTimes,keyTimes)
        _self.keyTimes = keyTimes;
        return _self;
    };
}

- (CAKeyframeAnimation *(^)(NSArray<CAMediaTimingFunction *> *))animationTimingFunctions
{
    return ^id(NSArray<CAMediaTimingFunction *> *timingFunctions){
        LinkHandle_REF(CAKeyframeAnimation)
        LinkGroupHandle_REF(animationTimingFunctions,timingFunctions)
        _self.timingFunctions = timingFunctions;
        return _self;
    };
}

- (CAKeyframeAnimation *(^)(NSString *))animationCalculationMode
{
    return ^id(NSString *calculationMode){
        LinkHandle_REF(CAKeyframeAnimation)
        LinkGroupHandle_REF(animationCalculationMode,calculationMode)
        _self.calculationMode = calculationMode;
        return _self;
    };
}

- (CAKeyframeAnimation *(^)(NSArray<NSNumber *> *))animationTensionValues
{
    return ^id(NSArray<NSNumber *> *tensionValues){
        LinkHandle_REF(CAKeyframeAnimation)
        LinkGroupHandle_REF(animationTensionValues,tensionValues)
        _self.tensionValues = tensionValues;
        return _self;
    };
}

- (CAKeyframeAnimation *(^)(NSArray<NSNumber *> *))animationContinuityValues
{
    return ^id(NSArray<NSNumber *> *continuityValues){
        LinkHandle_REF(CAKeyframeAnimation)
        LinkGroupHandle_REF(animationContinuityValues,continuityValues)
        _self.continuityValues = continuityValues;
        return _self;
    };
}

- (CAKeyframeAnimation *(^)(NSArray<NSNumber *> *))animationBiasValues
{
    return ^id(NSArray<NSNumber *> *biasValues){
        LinkHandle_REF(CAKeyframeAnimation)
        LinkGroupHandle_REF(animationBiasValues,biasValues)
        _self.biasValues = biasValues;
        return _self;
    };
}

- (CAKeyframeAnimation *(^)(NSString *))animationRotationMode
{
    return ^id(NSString *rotationMode){
        LinkHandle_REF(CAKeyframeAnimation)
        LinkGroupHandle_REF(animationRotationMode,rotationMode)
        _self.rotationMode = rotationMode;
        return _self;
    };
}

- (CASpringAnimation *(^)(CGFloat))animationMass
{
    return ^id(CGFloat mass){
        LinkHandle_REF(CASpringAnimation)
        LinkGroupHandle_REF(animationMass,mass)
        _self.mass = mass;
        return _self;
    };
}

- (CASpringAnimation *(^)(CGFloat))animationStiffness
{
    return ^id(CGFloat stiffness){
        LinkHandle_REF(CASpringAnimation)
        LinkGroupHandle_REF(animationStiffness,stiffness)
        _self.stiffness = stiffness;
        return _self;
    };
}

- (CASpringAnimation *(^)(CGFloat))animationDamping
{
    return ^id(CGFloat damping){
        LinkHandle_REF(CASpringAnimation)
        LinkGroupHandle_REF(animationDamping,damping)
        _self.damping = damping;
        return _self;
    };
}

- (CASpringAnimation *(^)(CGFloat))animationInitialVelocity
{
    return ^id(CGFloat initialVelocity){
        LinkHandle_REF(CASpringAnimation)
        LinkGroupHandle_REF(animationInitialVelocity,initialVelocity)
        _self.initialVelocity = initialVelocity;
        return _self;
    };
}

- (CABasicAnimation *(^)(id))animationFromValue
{
    return ^id(id value){
        LinkHandle_REF(CABasicAnimation)
        LinkGroupHandle_REF(animationFromValue,value)
        _self.fromValue = value;
        return _self;
    };
}

- (CABasicAnimation *(^)(id))animationToValue
{
    return ^id(id value){
        LinkHandle_REF(CABasicAnimation)
        LinkGroupHandle_REF(animationToValue,value)
        _self.toValue = value;
        return _self;
    };
}

- (CABasicAnimation *(^)(id))animationByValue
{
    return ^id(id value){
        LinkHandle_REF(CABasicAnimation)
        LinkGroupHandle_REF(animationByValue,value)
        _self.byValue = value;
        return _self;
    };
}

- (CAAnimationGroup *(^)(NSArray<CAAnimation *> *))animationGroupAnimations
{
    return ^id(NSArray<CAAnimation *> *animations){
        LinkHandle_REF(CAAnimationGroup)
        LinkGroupHandle_REF(animationGroupAnimations,animations)
        _self.animations = animations;
        return _self;
    };
}
@end
