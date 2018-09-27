//
//  UIImage+ZJImage.h
//  ZJUIKit
//
//  Created by dzj on 2017/12/5.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZJImage)

/** 截屏 */
+(instancetype)zj_snapshotCurrentcreen;

/** 高效添加圆角 */
-(UIImage *)zj_imageAddCornerWithRadius:(CGFloat)radius
                                andSize:(CGSize)size;

/**
 压缩图片方法(先压缩质量再压缩尺寸)
 
 @param maxLength 最大尺寸
 @return 图片 Data
 */
-(NSData *)zj_compressWithMaxLengLimit:(NSUInteger)maxLength;


/**
 压缩图片方法(压缩质量)
 
 @param maxLength 最大尺寸
 @return 图片 Data
 */
-(NSData *)zj_compressQualityWithMaxLengthLimit:(NSInteger)maxLength;

/**
 压缩图片方法(压缩质量二分法)
 
 @param maxLength 最大尺寸
 @return 图片Data
 */
-(NSData *)zj_compressMidQualityWithMaxLengthLimit:(NSInteger)maxLength;

/**
 压缩图片方法(压缩尺寸)
 
 @param maxLength 最大尺寸
 @return 图片Data
 */
-(NSData *)zj_compressBySizeWithMaxLengthLimit:(NSUInteger)maxLength;
@end
