//
//  UIImageView+ZJMasonryKit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/17.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (ZJMasonryKit)


+(instancetype)zj_imageView;

+(instancetype)zj_imageViewWithImageName:(NSString *)imageName;

+(instancetype)zj_imageViewWithImageName:(NSString *)imageName
                               SuperView:(UIView *)superView
                             constraints:(ZJConstrainMaker)constraints;

+(instancetype)zj_imageViewWithImageName:(NSString *)imageName
                               SuperView:(UIView *)superView
                             constraints:(ZJConstrainMaker)constraints
                              imgViewTap:(ZJTapGestureBlock)imgViewTap;


+(instancetype)zj_imageViewWithImageName:(NSString *)imageName
                               SuperView:(UIView *)superView
                             contentMode:(UIViewContentMode)contentMode
                                  isClip:(BOOL)isClip
                             constraints:(ZJConstrainMaker)constraints;

+(instancetype)zj_imageViewWithImageName:(NSString *)imageName
                               SuperView:(UIView *)superView
                             contentMode:(UIViewContentMode)contentMode
                                  isClip:(BOOL)isClip
                             constraints:(ZJConstrainMaker)constraints
                              imgViewTap:(ZJTapGestureBlock)imgViewTap;

@end
