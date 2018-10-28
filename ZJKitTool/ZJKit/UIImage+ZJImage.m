//
//  UIImage+ZJImage.m
//  ZJUIKit
//
//  Created by dzj on 2017/12/5.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

/**
 1.压缩图片质量
 NSData *data = UIImageJPEGRepresentation(image, compression);
 UIImage *resultImage = [UIImage imageWithData:data];
 通过 UIImage 和 NSData 的相互转化，减小 JPEG 图片的质量来压缩图片。UIImageJPEGRepresentation:: 第二个参数 compression 取值 0.0~1.0，值越小表示图片质量越低，图片文件自然越小。
 
 2.压缩图片尺寸
 UIGraphicsBeginImageContext(size);
 [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
 resultImage = UIGraphicsGetImageFromCurrentImageContext();
 UIGraphicsEndImageContext();
 给定所需的图片尺寸 size，resultImage 即为原图 image 绘制为 size 大小的图片。
 
 3.压缩图片使图片文件小于指定大小
 如果对图片清晰度要求不高，要求图片的上传、下载速度快的话，上传图片前需要压缩图片。压缩到什么程度要看具体情况，但一般会设定一个图片文件最大值，例如 100 KB。可以用上诉两种方法来压缩图片。假设图片转化来的 NSData 对象为 data，通过data.length即可得到图片的字节大小。
 */


#import "UIImage+ZJImage.h"

@implementation UIImage (ZJImage)

/**
 截屏
 @return 图片
 */
+(instancetype)zj_snapshotCurrentcreen{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIGraphicsBeginImageContextWithOptions(window.bounds.size, NO, 0);
    [window drawViewHierarchyInRect:window.frame afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 高效添加圆角
 */
-(UIImage *)zj_imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size{
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



/**
 压缩图片方法(先压缩质量再压缩尺寸)
 @param maxLength 最大质量
 @return 图片 Data
 */
-(NSData *)zj_compressWithMaxLengLimit:(NSUInteger)maxLength{
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    // 小于最大尺寸直接返回
    if (data.length < maxLength) {
        return data;
    }
    // 压缩质量
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i< 6; i++) {
        compression = (max + min)/2;
        data = UIImageJPEGRepresentation(self, compression);
//        NSLog(@"Compression = %.2f", compression);
//        NSLog(@"data.length = %.2lu", (unsigned long)data.length);
        if (data.length < maxLength * 0.9) {
            min = compression;
        }else if (data.length > maxLength){
            max = compression;
        }else{
            break;
        }
    }
    
    if (data.length < maxLength) {
        return data;
    }
    
    // 压缩尺寸
    UIImage *resultImage = [UIImage imageWithData:data];
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        // 设置压缩比例
        CGFloat ratio = (CGFloat)maxLength / data.length;
        // 使用NSUInteger防止空白
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
        
        NSLog(@"In compressing size loop, image size = %ld KB", data.length / 1024);
    }
    return data;
}


/**
 压缩图片方法(压缩质量)
 
 @param maxLength 最大尺寸
 @return 图片 Data
 */
-(NSData *)zj_compressQualityWithMaxLengthLimit:(NSInteger)maxLength{
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    while (data.length > maxLength && compression > 0) {
        compression -= 0.02;
        // 当压缩小于某个值时，将不再继续压缩
        data = UIImageJPEGRepresentation(self, compression);
    }
    return data;
}

/**
 压缩图片方法(压缩质量二分法)
 
 @param maxLength 最大质量
 @return 图片Data
 */
-(NSData *)zj_compressMidQualityWithMaxLengthLimit:(NSInteger)maxLength{
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (data.length < maxLength) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    return data;
}

/**
 压缩图片方法(压缩尺寸)
 
 @param maxLength 最大质量
 @return 图片Data
 */
-(NSData *)zj_compressBySizeWithMaxLengthLimit:(NSUInteger)maxLength{
    UIImage *resultImage = self;
    NSData *data = UIImageJPEGRepresentation(resultImage, 1);
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        // 使用NSUInteger防止空白
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        UIGraphicsBeginImageContext(size);
        // 使用图像绘制(drawInRect:)，图像更大，但压缩时间更多
        //使用result image绘制，图像更小，但压缩时间更短
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, 1);
    }
    return data;
}

@end
