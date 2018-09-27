//
//  UIImage+ZJCompress.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/9/27.
//  Copyright © 2018 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZJCompress)
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
