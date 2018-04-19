//
//  UIActionSheet+ZJHelperKit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ZJActionSheetClickedButtonBlock)(UIActionSheet *actionSheet, NSUInteger buttonIndex);


@interface UIActionSheet (ZJHelperKit)
/**
 *
 *    The action sheet callback block
 */
@property (nonatomic, copy) ZJActionSheetClickedButtonBlock zj_clickedButtonBlock;

/**
 *
 *    Show an action sheet in the view with a title, cancel button title,
 *  destructive title and other button titles.
 *
 *    @param inView                        Which view show the action sheet.
 *    @param title                        The action sheet's title.
 *    @param cancelTitle            The cancel button's title.
 *    @param destructiveTitle    The destructive button title.
 *    @param otherTitles            Other buton titles.
 *    @param callback                    The callback block
 *
 *    @return The UIActionSheet instance.
 */
+ (instancetype)zj_showInView:(UIView *)inView
                         title:(NSString *)title
                   cancelTitle:(NSString *)cancelTitle
              destructiveTitle:(NSString *)destructiveTitle
                   otherTitles:(NSArray *)otherTitles
                      callback:(ZJActionSheetClickedButtonBlock)callback;
@end
