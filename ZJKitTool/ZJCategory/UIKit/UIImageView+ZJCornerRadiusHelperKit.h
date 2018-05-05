//
//  UIImageView+ZJCornerRadiusHelperKit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/23.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (ZJCornerRadiusHelperKit)

- (instancetype)initWithCornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;


/**
 * 高效切圆角

 @param cornerRadius 圆角大小
 @param rectCornerType 圆角位置 上下左右 、全部
 */
- (void)zj_cornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;


- (instancetype)initWithRoundingRectImageView;


/**
 * 切成圆，没有屏幕外渲染。
 */
- (void)zj_cornerRadiusRoundingRect;

/**
 * 在UIImageView的边框上加上宽度和颜色。

 @param width 边框
 @param color 边框颜色
 */
- (void)zj_attachBorderWidth:(CGFloat)width color:(UIColor *)color;

@end
