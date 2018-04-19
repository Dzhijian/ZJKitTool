//
//  UITextView+ZJTextView.m
//  ZJUIKit
//
//  Created by dzj on 2017/12/4.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import "UITextView+ZJTextView.h"

@implementation UITextView (ZJTextView)

+(instancetype)zj_textViewInitWithFrame:(CGRect)frame textColor:(UIColor *)textColor fontSize:(float)fontSize bgColor:(UIColor *)bgColor{
    UITextView *textView = [[UITextView alloc]init];
    textView.frame = frame;
    textView.textColor = textColor;
    textView.font = [UIFont systemFontOfSize:fontSize];
    textView.backgroundColor = bgColor;
    return textView;
}

@end
