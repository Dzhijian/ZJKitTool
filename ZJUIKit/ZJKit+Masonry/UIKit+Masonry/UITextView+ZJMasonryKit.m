//
//  UITextView+ZJMasonryKit.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/22.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "UITextView+ZJMasonryKit.h"

@implementation UITextView (ZJMasonryKit)

+(instancetype)zj_textViewWithFontSize:(CGFloat)fontSize
                             textColor:(UIColor *)textColor
                            placeColor:(UIColor *)placeColor
                             placeText:(NSString *)placeText
                             superView:(UIView *)superView
                           constraints:(ZJConstrainMaker)constraints{
    return [self zj_textViewWithFontSize:fontSize textColor:textColor borderColor:nil borderWidth:0 cornerRadiu:0 placeColor:placeColor placeText:placeText superView:superView constraints:constraints];
}

+(instancetype)zj_textViewWithFontSize:(CGFloat)fontSize
                             textColor:(UIColor *)textColor
                           borderColor:(UIColor *)borderColor
                           borderWidth:(CGFloat)borderWidth
                           cornerRadiu:(CGFloat)cornerRadiu
                            placeColor:(UIColor *)placeColor
                             placeText:(NSString *)placeText
                             superView:(UIView *)superView
                           constraints:(ZJConstrainMaker)constraints{
    UITextView *textView = [[UITextView alloc]init];
    textView.font = [UIFont systemFontOfSize:fontSize];
    textView.textColor = textColor;
    [textView zj_setPlaceholderWithText:placeText Color:placeColor];
    textView.layer.borderColor = borderColor.CGColor;
    textView.layer.borderWidth = borderWidth;
    textView.layer.cornerRadius = cornerRadiu;
    
    
    if (superView && constraints) {
        [superView addSubview:textView];
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            constraints(make);
        }];
    }
    
    
    return textView;
}


@end
