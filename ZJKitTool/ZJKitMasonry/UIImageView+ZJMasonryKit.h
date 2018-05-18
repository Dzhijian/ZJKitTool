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


+(instancetype)zj_imageView;

+(instancetype)zj_imageViewWithImage:(id)image;

+(instancetype)zj_imageViewWithImage:(id)image
                               SuperView:(UIView *)superView
                             constraints:(ZJConstrainMaker)constraints;

+(instancetype)zj_imageViewWithImage:(id)image
                               SuperView:(UIView *)superView
                             constraints:(ZJConstrainMaker)constraints
                              imgViewTap:(ZJTapGestureBlock)imgViewTap;


+(instancetype)zj_imageViewWithImage:(id)image
                               SuperView:(UIView *)superView
                             contentMode:(UIViewContentMode)contentMode
                                  isClip:(BOOL)isClip
                             constraints:(ZJConstrainMaker)constraints;

+(instancetype)zj_imageViewWithImage:(id)image
                               SuperView:(UIView *)superView
                             contentMode:(UIViewContentMode)contentMode
                                  isClip:(BOOL)isClip
                             constraints:(ZJConstrainMaker)constraints
                              imgViewTap:(ZJTapGestureBlock)imgViewTap;

@end
