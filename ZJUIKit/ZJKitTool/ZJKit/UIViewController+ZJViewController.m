//
//  UIViewController+ZJViewController.m
//  ZJUIKit
//
//  Created by dzj on 2017/12/1.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import "UIViewController+ZJViewController.h"

@implementation UIViewController (ZJViewController)

+(instancetype)findBestViewController:(UIViewController *)vc{
    if (vc.presentedViewController) {
        return [self findBestViewController:vc.presentedViewController];
    }else if ([vc isKindOfClass:[UISplitViewController class]]){
        UISplitViewController *svc = (UISplitViewController *)vc;
        if (svc.viewControllers.count>0) {
            return [self findBestViewController:svc.viewControllers.lastObject];
        }else{
            return vc;
        }
    }else if ([vc isKindOfClass:[UINavigationController class]]){
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
        {
            return [self findBestViewController:svc.topViewController];
        }
        else
        {
            return vc;
        }
    }else if ([vc isKindOfClass:[UITabBarController class]]){
        UITabBarController* svc = (UITabBarController *)vc;
        if (svc.viewControllers.count > 0)
        {
            return [self findBestViewController:svc.selectedViewController];
        }
        else
        {
            return vc;
        }
        
    }else{
        return vc;
    }
}

+(UIViewController *)zj_currentViewController{
    UIViewController *viewController = [[UIApplication sharedApplication].delegate window].rootViewController;
    return [UIViewController findBestViewController:viewController];
}

+ (UINavigationController *)zj_currentNavigatonController {
    
    UIViewController * currentViewController =  [UIViewController zj_currentViewController];
    
    return currentViewController.navigationController;
}

- (void)zj_addChildController:(UIViewController *)childController intoView:(UIView *)view  {
    
    [self addChildViewController:childController];
    
    [view addSubview:childController.view];
    
    [childController didMoveToParentViewController:self];
}



@end
