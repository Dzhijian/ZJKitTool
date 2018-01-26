//
//  UILabel+ZJMasonryKit.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/17.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "UILabel+ZJMasonryKit.h"
#import <CoreText/CoreText.h>

@implementation UILabel (ZJMasonryKit)


+(instancetype)zj_labelWithFont:(CGFloat)font{
    return [self zj_labelWithFont:font text:nil];
}


+(instancetype)zj_labelWithFont:(CGFloat)font text:(NSString *)text{
    return [self zj_labelWithFont:font text:text superView:nil constraints:nil];
}


+(instancetype)zj_labelWithFont:(CGFloat)font
                      textColor:(UIColor *)textColor
                      superView:(UIView *)superView
                    constraints:(ZJConstrainMaker)constraints
{
    return [self zj_labelWithFont:font lines:1 text:nil textColor:textColor superView:superView constraints:constraints];
}


+(instancetype)zj_labelWithFont:(CGFloat)font
                           text:(NSString *)text
                      superView:(UIView *)superView
                    constraints:(ZJConstrainMaker)constraints
{
    return [self zj_labelWithFont:font lines:1 text:text superView:superView constraints:constraints];
}

+(instancetype)zj_labelWithFont:(CGFloat)font
                          lines:(NSInteger)lines
                           text:(NSString *)text
                      superView:(UIView *)superView
                    constraints:(ZJConstrainMaker)constraints
{
    return [self zj_labelWithFont:font lines:lines text:text textColor:nil superView:superView constraints:constraints];
}

+(instancetype)zj_labelWithFont:(CGFloat)font
                          lines:(NSInteger)lines
                           text:(NSString *)text
                      textColor:(UIColor *)textColor
                      superView:(UIView *)superView
                    constraints:(ZJConstrainMaker)constraints
{
    
    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.font = kFontWithSize(font);
    label.textAlignment = NSTextAlignmentLeft;
    if (textColor != nil) {
        label.textColor = textColor;
    }else{
        label.textColor = kBlackColor;
    }
    label.numberOfLines = lines;
    
    if (lines <= 0) {
        label.lineBreakMode = NSLineBreakByWordWrapping;
    } else {
        label.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    
    [superView addSubview:label];
    
    if (superView && constraints) {
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            constraints(make);
        }];
    }
    return label;
}


- (void)setColumnSpace:(CGFloat)columnSpace
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    //调整间距
    [attributedString addAttribute:(__bridge NSString *)kCTKernAttributeName value:@(columnSpace) range:NSMakeRange(0, [attributedString length])];
    self.attributedText = attributedString;
}

- (void)setRowSpace:(CGFloat)rowSpace
{
    self.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    //调整行距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = rowSpace;
    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
}
@end
