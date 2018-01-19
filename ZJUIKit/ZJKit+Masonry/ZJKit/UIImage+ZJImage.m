//
//  UIImage+ZJImage.m
//  ZJUIKit
//
//  Created by dzj on 2017/12/5.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import "UIImage+ZJImage.h"

@implementation UIImage (ZJImage)

// 截屏
+(instancetype)zj_snapshotCurrentcreen{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIGraphicsBeginImageContextWithOptions(window.bounds.size, NO, 0);
    [window drawViewHierarchyInRect:window.frame afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/** 高效添加圆角 */
-(UIImage *)zj_imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size{
//    CGRect rect = CGRectMake(0, 0, size.width, size.height);
//    UIGraphicsBeginImageContextWithOptions(size, NO,[UIScreen mainScreen].scale);
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
//
//    CGContextAddPath(ctx, path.CGPath);
//    CGContextClip(ctx);
//    [self drawInRect:rect];
//    CGContextDrawPath(ctx, kCGPathStroke);
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return newImage;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(ctx,path.CGPath);
    CGContextClip(ctx);
    [self drawInRect:rect];
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
