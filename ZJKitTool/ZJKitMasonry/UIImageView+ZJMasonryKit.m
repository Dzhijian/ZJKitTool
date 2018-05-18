//
//  UIImageView+ZJMasonryKit.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/17.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "UIImageView+ZJMasonryKit.h"

@implementation UIImageView (ZJMasonryKit)

+(instancetype)zj_imageView
{
    return [self zj_imageViewWithImage:nil];
}

+(instancetype)zj_imageViewWithImage:(id)image
{
    return [self zj_imageViewWithImage:image SuperView:nil constraints:nil];
}

+(instancetype)zj_imageViewWithImage:(id)image
                               SuperView:(UIView *)superView
                             constraints:(ZJConstrainMaker)constraints
{
    return [self zj_imageViewWithImage:image SuperView:superView constraints:constraints imgViewTap:nil];
}

+(instancetype)zj_imageViewWithImage:(id)image
                               SuperView:(UIView *)superView
                             constraints:(ZJConstrainMaker)constraints
                              imgViewTap:(ZJTapGestureBlock)imgViewTap
{
    return [self zj_imageViewWithImage:image SuperView:superView contentMode:UIViewContentModeScaleAspectFill isClip:YES constraints:constraints imgViewTap:imgViewTap];
}


+(instancetype)zj_imageViewWithImage:(id)image
                               SuperView:(UIView *)superView
                             contentMode:(UIViewContentMode)contentMode
                                  isClip:(BOOL)isClip
                             constraints:(ZJConstrainMaker)constraints
{
    return [self zj_imageViewWithImage:image SuperView:superView contentMode:contentMode isClip:isClip constraints:constraints imgViewTap:nil];
}

+(instancetype)zj_imageViewWithImage:(id)image
                               SuperView:(UIView *)superView
                             contentMode:(UIViewContentMode)contentMode
                                  isClip:(BOOL)isClip
                             constraints:(ZJConstrainMaker)constraints
                              imgViewTap:(ZJTapGestureBlock)imgViewTap
{
    
    UIImageView *imageView = [[UIImageView alloc]init];
    
    if ([image isMemberOfClass:[NSString class]]) {
        imageView.image = [UIImage imageNamed:image];
    }else if ([image isMemberOfClass:[UIImage class]]){
        imageView.image = image;
    }
    

    imageView.contentMode = contentMode;
    [superView addSubview:imageView];
    imageView.clipsToBounds = isClip;
    if (constraints && superView) {
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            constraints(make);
        }];
    }
    
    if (imgViewTap) {
        
    }
    
    return imageView;
}

@end
