//
//  UIViewController+ZJHelperKit.h
//  ZJKitTool
//
//  Created by dzj on 2021/2/26.
//  Copyright © 2021 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (ZJHelperKit)
//找到当前视图控制器
+ (UIViewController *)zj_currentViewController;

//找到当前导航控制器
+ (UINavigationController *)zj_currentNavigatonController;

/**
 * 在当前视图控制器中添加子控制器，将子控制器的视图添加到 view 中
 *
 * @param childController 要添加的子控制器
 * @param view            要添加到的视图
 */
- (void)zj_addChildController:(UIViewController *)childController intoView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
