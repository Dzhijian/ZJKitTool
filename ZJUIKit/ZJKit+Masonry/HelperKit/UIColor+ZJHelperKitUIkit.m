//
//  UIColor+ZJHelperKitUIkit.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "UIColor+ZJHelperKitUIkit.h"

@implementation UIColor (ZJHelperKitUIkit)
- (UIImage *)zj_toImage {
    return [UIColor zj_imageWithColor:self];
}

+ (UIImage *)zj_imageWithColor:(UIColor *)color {
    return [self zj_imageWithColor:color size:CGSizeMake(1, 1)];
}

- (UIImage *)zj_toImageWithSize:(CGSize)size {
    return [UIColor zj_imageWithColor:self size:size];
}

+ (UIImage *)zj_imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
