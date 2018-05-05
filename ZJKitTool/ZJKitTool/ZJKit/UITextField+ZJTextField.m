//
//  UITextField+ZJTextField.m
//  ZJUIKit
//
//  Created by dzj on 2017/12/4.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import "UITextField+ZJTextField.h"

@implementation UITextField (ZJTextField)

+(instancetype)zj_textFieldWithFrame:(CGRect)frame textColor:(UIColor *)tColor fontSize:(float)fontSize placeText:(NSString *)placeText placeColor:(UIColor *)placeColor borderStyle:(UITextBorderStyle)borderStyle{
    UITextField *textfield = [[UITextField alloc]init];
    textfield.frame = frame;
    textfield.font =[UIFont systemFontOfSize:fontSize];
    textfield.textColor = tColor;
    textfield.placeholder = placeText;
    [textfield setValue:placeColor forKeyPath:@"_placeholderLabel.textColor"];
    textfield.borderStyle = borderStyle;
    return textfield;
}


@end
