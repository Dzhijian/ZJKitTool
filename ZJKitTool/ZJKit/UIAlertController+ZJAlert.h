//
//  UIAlertController+ZJAlert.h
//  ZJUIKit
//
//  Created by dzj on 2017/12/4.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, OptionStyle) {
    OptionStyleStyleOK_Cancel = 0,
    OptionStyleStyleOnlyOK
};

@interface UIAlertController (ZJAlert)
/**
 中间弹窗
 
 @param title 标题
 @param message 消息
 @param optionStyle 弹窗选项样式，两个选择或只有一个
 @param okTitle 右边选项的文字
 @param cancelTitle 左边选项的文字
 @param okBlock 右边选择选中后执行的代码
 @param cancelBlock 左边选项选中后执行的代码
 @return UIAlertController
 */
+ (UIAlertController *)zj_alertControllerWithTitle:(NSString *)title
                                           message:(NSString *)message
                                       optionStyle:(OptionStyle)optionStyle
                                           OkTitle:(NSString *)okTitle
                                       cancelTitle:(NSString *)cancelTitle
                                           okBlock:(dispatch_block_t)okBlock
                                       cancelBlock:(dispatch_block_t)cancelBlock;


/**
 从下面出现的弹窗
 
 @param title 标题
 @param message 消息
 @param optionStyle 弹窗选项样式，两个选择或只有一个
 @param okTitle 上面选项的文字
 @param cancelTitle 下面选项的文字
 @param okBlock 上面选择选中后执行的代码
 @param cancelBlock 下面选项选中后执行的代码
 @return UIAlertController
 */
+ (UIAlertController *)zj_sheetAlertControllerWithTitle:(NSString *)title
                                                message:(NSString *)message
                                            optionStyle:(OptionStyle)optionStyle
                                                OkTitle:(NSString *)okTitle
                                            cancelTitle:(NSString *)cancelTitle
                                                okBlock:(dispatch_block_t)okBlock
                                            cancelBlock:(dispatch_block_t)cancelBlock;

@end
