//
//  UIImage+ZJHelperKit.h
//  ZJKitTool
//
//  Created by dzj on 2021/2/26.
//  Copyright © 2021 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZJHelperKit)

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

NS_ASSUME_NONNULL_END
