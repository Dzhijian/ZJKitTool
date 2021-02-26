//
//  UIViewController+ZJHelperKit.m
//  ZJKitTool
//
//  Created by dzj on 2021/2/26.
//  Copyright © 2021 kapokcloud. All rights reserved.
//

#import "UIViewController+ZJHelperKit.h"

@implementation UIViewController (ZJHelperKit)

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
