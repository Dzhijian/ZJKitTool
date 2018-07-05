//
//  UIImageView+ZJMasonryKit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/17.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZJKitMasonryTool.h"

@interface UIImageView (ZJMasonryKit)

/**
 *  1.快速创建一个 UIImageView
 */
+(instancetype)zj_imageView;

/**
 * 2. 快速创建一个 UIImageView,设置图片
 */
+(instancetype)zj_imageViewWithImage:(id)image;
/**
 * 3. 快速创建一个 UIImageView,设置图片,父视图,Masonry约束
 */
+(instancetype)zj_imageViewWithImage:(id)image
                               SuperView:(UIView *)superView
                             constraints:(ZJConstrainMaker)constraints;
/**
 * 4. 快速创建一个 UIImageView,设置图片,父视图, Masonry约束,点击事件
 */
+(instancetype)zj_imageViewWithImage:(id)image
                               SuperView:(UIView *)superView
                             constraints:(ZJConstrainMaker)constraints
                              imgViewTap:(ZJTapGestureBlock)imgViewTap;

/**
 * 5. 快速创建一个 UIImageView,设置图片,父视图,填充模式,Masonry约束,是否剪切
 */
+(instancetype)zj_imageViewWithImage:(id)image
                               SuperView:(UIView *)superView
                             contentMode:(UIViewContentMode)contentMode
                                  isClip:(BOOL)isClip
                             constraints:(ZJConstrainMaker)constraints;

/**
 * 6. 快速创建一个 UIImageView
 *  @param image        图片或图片名
 *  @param superView    父视图
 *  @param isClip       是否剪切
 *  @param constraints  Masonry约束
 *  @param imgViewTap   点击事件
 */
+(instancetype)zj_imageViewWithImage:(id)image
                               SuperView:(UIView *)superView
                             contentMode:(UIViewContentMode)contentMode
                                  isClip:(BOOL)isClip
                             constraints:(ZJConstrainMaker)constraints
                              imgViewTap:(ZJTapGestureBlock)imgViewTap;


/**
 *  重新绘制图片,避免图层混合
 */
+(UIImage *)zj_reDrawImage:(UIImage *)image size:(CGSize)size;

@end
