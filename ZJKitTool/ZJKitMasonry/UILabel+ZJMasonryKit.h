//
//  UILabel+ZJMasonryKit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/17.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

/**
 *  ZJKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下。😆
 */
#import <UIKit/UIKit.h>
#import "ZJKitMasonryTool.h"

@interface UILabel (ZJMasonryKit)


/**
 1. 创建一个Label,设置字体大小
 @param                 fontsize 字体大小
 @return                UILabel
 */
+(instancetype)zj_labelWithFontSize:(CGFloat)fontsize;


/**
 2.快速创建一个Label,字体大小,父视图,masonry布局

 @param fontsize            字体大小
 @param superView       父视图
 @param constraints     masonry布局
 @return label
 */
+(instancetype)zj_labelWithFontSize:(CGFloat)fontsize
                      textColor:(UIColor *)textColor
                      superView:(UIView *)superView
                    constraints:(ZJConstrainMaker)constraints;


/**
 3. 快速创建一个label,字体大小,文本

 @param                 fontsize 字体大小
 @param                 text 文本
 @return                label
 */
+(instancetype)zj_labelWithFontSize:(CGFloat)fontsize
                           text:(NSString *)text;


/**
 4.快速创建一个Label,字体大小,文本,父视图,masonry布局

 @param                 fontsize 字体大小
 @param                 text 文本
 @param                 superView 父视图
 @param                 constraints masonry布局
 @return                label
 */
+(instancetype)zj_labelWithFontSize:(CGFloat)fontsize
                           text:(NSString *)text
                      superView:(UIView *)superView
                    constraints:(ZJConstrainMaker)constraints;


/**
 5.快速创建一个Label,字体大小,文本,行数,父视图,masonry布局
 
 @param                 fontsize 字体大小
 @param                 lines 行数
 @param                 text 文本
 @param                 superView 父视图
 @param                 constraints masonry布局
 @return                label
 */
+(instancetype)zj_labelWithFontSize:(CGFloat)fontsize
                          lines:(NSInteger)lines
                           text:(NSString *)text
                      superView:(UIView *)superView
                    constraints:(ZJConstrainMaker)constraints;


/**
 6.快速创建一个Label,字体大小,文本,字体颜色,行数,父视图,masonry布局
 
 @param                 font 字体UIFont
 @param                 lines 行数
 @param                 text 文本
 @param                 superView 父视图
 @param                 constraints masonry布局
 @return                label
 */
+(instancetype)zj_labelWithFont:(UIFont *)font
                          lines:(NSInteger)lines
                           text:(NSString *)text
                      textColor:(UIColor *)textColor
                      superView:(UIView *)superView
                    constraints:(ZJConstrainMaker)constraints;

/**
 7.快速创建一个Label,字体大小,文本,字体颜色,行数,父视图,masonry布局
 
 @param                 fontsize 字体大小
 @param                 lines 行数
 @param                 text 文本
 @param                 superView 父视图
 @param                 constraints masonry布局
 @return                label
 */
+(instancetype)zj_labelWithFontSize:(CGFloat)fontsize
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
