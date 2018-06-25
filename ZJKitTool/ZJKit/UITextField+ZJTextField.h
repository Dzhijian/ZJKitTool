//
//  UITextField+ZJTextField.h
//  ZJUIKit
//
//  Created by dzj on 2017/12/4.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (ZJTextField)

/** 创建UITextField */
+(instancetype)zj_textFieldWithFrame:(CGRect)frame
                           textColor:(UIColor *)tColor
                            fontSize:(float)fontSize
                           placeText:(NSString *)placeText
                          placeColor:(UIColor *)placeColor
                         borderStyle:(UITextBorderStyle)borderStyle;

@end
