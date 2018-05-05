//
//  UIImageView+ZJImageView.m
//  ZJUIKit
//
//  Created by dzj on 2017/12/4.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import "UIImageView+ZJImageView.h"

@implementation UIImageView (ZJImageView)

+(instancetype)zj_imageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName contentMode:(UIViewContentMode)contentMode{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    imageView.frame  = frame;
    imageView.contentMode = contentMode;
    return imageView;
}


@end
