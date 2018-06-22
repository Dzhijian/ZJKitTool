//
//  UILabel+ZJMasonryKit.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/17.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "UILabel+ZJMasonryKit.h"
#import <CoreText/CoreText.h>

// 获取屏幕的宽度
#define kScreenWidthLabel ([UIScreen mainScreen].bounds.size.width)
// 不同屏幕尺寸字体适配
#define kScreenWidthRatioLabel  (kScreenWidthLabel / 375.0)
#define AdaptedWidthLabel(x)  ceilf((x) * kScreenWidthRatioLabel)
// 字体适配
#define AdaptedFontSizeLabel(R)     [UIFont systemFontOfSize:AdaptedWidthLabel(R)]

@implementation UILabel (ZJMasonryKit)


+(instancetype)zj_labelWithFontSize:(CGFloat)fontSize{
    return [self zj_labelWithFontSize:fontSize text:nil];
}


+(instancetype)zj_labelWithFontSize:(CGFloat)fontSize text:(NSString *)text{
    return [self zj_labelWithFontSize:fontSize text:text superView:nil constraints:nil];
}


+(instancetype)zj_labelWithFontSize:(CGFloat)fontSize
                      textColor:(UIColor *)textColor
                      superView:(UIView *)superView
                    constraints:(ZJConstrainMaker)constraints
{
    return [self zj_labelWithFontSize:fontSize lines:1 text:nil textColor:textColor superView:superView constraints:constraints];
}


+(instancetype)zj_labelWithFontSize:(CGFloat)fontSize
                           text:(NSString *)text
                      superView:(UIView *)superView
                    constraints:(ZJConstrainMaker)constraints
{
    return [self zj_labelWithFontSize:fontSize lines:1 text:text superView:superView constraints:constraints];
}

+(instancetype)zj_labelWithFontSize:(CGFloat)fontSize
                          lines:(NSInteger)lines
                           text:(NSString *)text
                      superView:(UIView *)superView
                    constraints:(ZJConstrainMaker)constraints
{
    return [self zj_labelWithFontSize:fontSize lines:lines text:text textColor:nil superView:superView constraints:constraints];
}

+(instancetype)zj_labelWithFont:(UIFont *)font
                          lines:(NSInteger)lines
                           text:(NSString *)text
                      textColor:(UIColor *)textColor
                      superView:(UIView *)superView
                    constraints:(ZJConstrainMaker)constraints
{
    return [self zj_initLabelWithFont:font fontSize:0 lines:lines text:text textColor:textColor superView:superView constraints:constraints];
}

+(instancetype)zj_labelWithFontSize:(CGFloat)fontsize
                          lines:(NSInteger)lines
                           text:(NSString *)text
                      textColor:(UIColor *)textColor
                      superView:(UIView *)superView
                    constraints:(ZJConstrainMaker)constraints
{
    return [self zj_initLabelWithFont:nil fontSize:fontsize lines:lines text:text textColor:textColor superView:superView constraints:constraints];
    
}

+(instancetype)zj_initLabelWithFont:(UIFont *)font
                   fontSize:(CGFloat)fontSize
                      lines:(NSInteger)lines
                       text:(NSString *)text
                  textColor:(UIColor *)textColor
                  superView:(UIView *)superView
                constraints:(ZJConstrainMaker)constraints{
    
    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    if (fontSize!=0) {
        label.font = AdaptedFontSizeLabel(fontSize);
    }
    
    if (font != nil) {
        label.font = font;
    }
    
    label.textAlignment = NSTextAlignmentLeft;
    
    // 避免视图混合
    label.backgroundColor = [UIColor whiteColor];
    label.layer.masksToBounds = YES;
    
    if (textColor != nil) {
        label.textColor = textColor;
    }else{
        label.textColor = [UIColor blackColor];
    }
    label.numberOfLines = lines;
    
    /*
     typedef NS_ENUM(NSInteger, NSLineBreakMode) {
     NSLineBreakByWordWrapping = 0,         // Wrap at word boundaries, default
     NSLineBreakByCharWrapping,        // Wrap at character boundaries
     NSLineBreakByClipping,        // Simply clip
     NSLineBreakByTruncatingHead,    // Truncate at head of line: "...wxyz"
     NSLineBreakByTruncatingTail,    // Truncate at tail of line: "abcd..."
     NSLineBreakByTruncatingMiddle    // Truncate middle of line:  "ab...yz"
     } NS_ENUM_AVAILABLE(10_0, 6_0);
     */
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
