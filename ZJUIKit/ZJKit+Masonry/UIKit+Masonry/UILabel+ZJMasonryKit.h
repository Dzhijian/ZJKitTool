//
//  UILabel+ZJMasonryKit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/17.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//



@interface UILabel (ZJMasonryKit)


/**
 *创建一个Label,设置字体大小
 @param                 font 字体大小
 @return                UILabel
 */
+(instancetype)zj_labelWithFont:(CGFloat)font;


/**
 *快速创建一个Label,字体大小,父视图,masonry布局

 @param font            字体大小
 @param superView       父视图
 @param constraints     masonry布局
 @return label
 */
+(instancetype)zj_labelWithFont:(CGFloat)font
                      superView:(UIView *)superView
                    constraints:(ZJConstrainMaker)constraints;


/**
 *快速创建一个label,字体大小,文本

 @param                 font 字体大小
 @param                 text 文本
 @return                label
 */
+(instancetype)zj_labelWithFont:(CGFloat)font
                           text:(NSString *)text;


/**
 *快速创建一个Label,字体大小,文本,父视图,masonry布局

 @param                 font 字体大小
 @param                 text 文本
 @param                 superView 父视图
 @param                 constraints masonry布局
 @return                label
 */
+(instancetype)zj_labelWithFont:(CGFloat)font
                           text:(NSString *)text
                      superView:(UIView *)superView
                    constraints:(ZJConstrainMaker)constraints;


/**
 *快速创建一个Label,字体大小,文本,行数,父视图,masonry布局
 
 @param                 font 字体大小
 @param                 lines 行数
 @param                 text 文本
 @param                 superView 父视图
 @param                 constraints masonry布局
 @return                label
 */
+(instancetype)zj_labelWithFont:(CGFloat)font
                          lines:(NSInteger)lines
                           text:(NSString *)text
                      superView:(UIView *)superView
                    constraints:(ZJConstrainMaker)constraints;


/**
 *快速创建一个Label,字体大小,文本,字体颜色,行数,父视图,masonry布局
 
 @param                 font 字体大小
 @param                 lines 行数
 @param                 text 文本
 @param                 superView 父视图
 @param                 constraints masonry布局
 @return                label
 */
+(instancetype)zj_labelWithFont:(CGFloat)font
                          lines:(NSInteger)lines
                           text:(NSString *)text
                      textColor:(UIColor *)textColor
                      superView:(UIView *)superView
                    constraints:(ZJConstrainMaker)constraints;

/**
 *  设置字间距
 */
- (void)setColumnSpace:(CGFloat)columnSpace;

/**
 *  设置行距
 */
- (void)setRowSpace:(CGFloat)rowSpace;

@end
