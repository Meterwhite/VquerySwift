//
//  UIViewController+LinkBlock.m
//  LinkBlockProgram
//
//  Created by NOVO on 15/9/8.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlock.h"

@implementation NSObject(UIViewControllerLinkBlock)

- (UIViewController *(^)(UIViewController *))vcAddChildVC
{
    return ^id(UIViewController* childVC){
        LinkHandle_REF(UIViewController)
        LinkGroupHandle_REF(vcAddChildVC,childVC)
        [_self addChildViewController:childVC];
        return _self;
    };
}

- (UIViewController *(^)(NSString *))vcTitle
{
    return ^id(NSString* title){
        LinkHandle_REF(UIViewController)
        LinkGroupHandle_REF(vcTitle,title)
        _self.title = title;
        return _self;
    };
}

- (UIViewController *(^)(UIViewController *))vcNavigationControllerPushVC
{
    return ^id(UIViewController* vc){
        LinkHandle_REF(UIViewController)
        LinkGroupHandle_REF(vcNavigationControllerPushVC,vc)
        [_self.navigationController pushViewController:vc animated:YES];
        return _self;
    };
}

- (UIViewController *(^)(UIViewController *))vcNavigationControllerPopTo
{
    return ^id(UIViewController* vc){
        LinkHandle_REF(UIViewController)
        LinkGroupHandle_REF(vcNavigationControllerPopTo,vc)
        [_self.navigationController popToViewController:vc animated:YES];
        return _self;
    };
}

- (UIViewController *(^)(void))vcNavigationControllerPop
{
    return ^id(){
        LinkHandle_REF(UIViewController)
        LinkGroupHandle_REF(vcNavigationControllerPop)
        [_self.navigationController popViewControllerAnimated:YES];
        return _self;
    };
}

- (UIViewController *(^)(BOOL))vcHidesBottomBarWhenPushed
{
    return ^id(BOOL b){
        LinkHandle_REF(UIViewController)
        LinkGroupHandle_REF(vcHidesBottomBarWhenPushed,b)
        _self.hidesBottomBarWhenPushed = b;
        return _self;
    };
}

- (UIViewController *(^)(void))vcHidesBottomBarWhenPushedYES
{
    return ^id(){
        LinkHandle_REF(UIViewController)
        LinkGroupHandle_REF(vcHidesBottomBarWhenPushedYES)
        _self.hidesBottomBarWhenPushed = YES;
        return _self;
    };
}

- (UIViewController *(^)(UIView *))vcViewAddSubview
{
    return ^id(UIView *view){
        LinkHandle_REF(UIViewController)
        LinkGroupHandle_REF(vcViewAddSubview,view)
        [_self.view addSubview:view];
        return _self;
    };
}

+ (UIViewController*)_lb_currentViewController {
    
    // Find best view controller
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIViewController _lb_findCurrentVCFrom:viewController];
}
+(UIViewController*)_lb_findCurrentVCFrom:(UIViewController*)vc {
    
    if (vc.presentedViewController) {
        
        // Return presented view controller
        return [UIViewController _lb_findCurrentVCFrom:vc.presentedViewController];
        
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        
        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController _lb_findCurrentVCFrom:svc.viewControllers.lastObject];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        
        // Return top view
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController _lb_findCurrentVCFrom:svc.topViewController];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController _lb_findCurrentVCFrom:svc.selectedViewController];
        else
            return vc;
        
    } else {
        
        // Unknown view controller type, return last child view controller
        return vc;
    }
}

- (UIViewController *(^)(BOOL, void (^)(void)))vcpresentedFromCurrentController
{
    return ^id(BOOL animated,void(^completion)(void)){
        
        LinkHandle_REF(UIViewController)
        LinkGroupHandle_REF(vcpresentedFromCurrentController,animated,completion)
        
        [[self.class _lb_currentViewController] presentViewController:_self animated:animated completion:completion];
        return _self;
    };
}

- (UIViewController *(^)(BOOL))vcPushedFromCurrentControllerNavigation
{
    return ^id(BOOL animated){
        
        LinkHandle_REF(UIViewController)
        LinkGroupHandle_REF(vcPushedFromCurrentControllerNavigation,animated)
        
        [[self.class _lb_currentViewController].navigationController pushViewController:_self animated:animated];
        return _self;
    };
}
@end
