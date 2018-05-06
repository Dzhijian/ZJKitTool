//
//  UITextView+ZJMasonryKit.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/22.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "UITextView+ZJMasonryKit.h"
#import <objc/runtime.h>
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
    [textView zj_textViewsSetPlaceholderWithText:placeText Color:placeColor];
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



+(void)load{
    
    // 获取类方法 class_getClassMethod
    // 获取对象方法 class_getInstanceMethod
    Method setFontMethod = class_getInstanceMethod(self, @selector(setFont:));
    Method was_setFontMethod =class_getInstanceMethod(self, @selector(was_setFont:));
    // 交换方法的实现
    method_exchangeImplementations(setFontMethod, was_setFontMethod);
    
}

-(void)zj_textViewsSetPlaceholderWithText:(NSString *)text Color:(UIColor *)color{
    //多余 强指针换了指向以后label自动销毁
    //防止重复设置 cell复用等问题
    //    for (UIView *view in self.subviews) {
    //        if ([view isKindOfClass:[UILabel class]]) {
    //            [view removeFromSuperview];
    //        }
    //    }
    
    //设置占位label
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = self.font;
    label.textColor = color;
    label.numberOfLines = 0;
    [self addSubview:label];
    [self setValue:label forKey:@"_placeholderLabel"];
}

- (void)was_setFont:(UIFont *)font{
    //调用原方法 setFont:
    [self was_setFont:font];
    //设置占位字符串的font
    UILabel *label = [self valueForKey:@"_placeholderLabel"];
    label.font = font;
    NSLog(@"%s", __func__);
}

@end
