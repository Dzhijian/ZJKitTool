//
//  UIAlertView+ZJHelperKitUIKit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZJAlertClickedButtonBlock)(UIAlertView *alertView,
                                          NSUInteger buttonIndex);

@interface UIAlertView (ZJHelperKitUIKit)
/**
 *    @author https://github.com/CoderJackyHuang
 *
 *    The action callback block
 */
@property (nonatomic, copy) ZJAlertClickedButtonBlock  zj_clickedButtonBlock;

/**
 *    @author https://github.com/CoderJackyHuang
 *
 *    Show an alert view with a title, message and button titles.
 *
 *    @param title                Title
 *    @param message            The content message
 *    @param buttonTitles    The buttion titles array.
 *    @param block                The callbac when clicked.
 *
 *    @return The UIAlertView instance.
 */
+ (instancetype)zj_showWithTitle:(NSString *)title
                          message:(NSString *)message
                     buttonTitles:(NSArray *)buttonTitles
                            block:(ZJAlertClickedButtonBlock)block;
@end
