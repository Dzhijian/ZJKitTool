//
//  UIColor+ZJHelperKitUIkit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//



@interface UIColor (ZJHelperkit)
/**
 *
 *    Generate an image with current color, and the image size will be set to {1, 1}
 *
 *    @return UIImage instance.
 */
- (UIImage *)zj_toImage;

/**
 *
 *    Generate an image with the color and size will be {1, 1}
 *
 *    @param color    The color to generate image.
 *
 *    @return UIImage instance.
 */
+ (UIImage *)zj_imageWithColor:(UIColor *)color;

/**
 *
 *    Generate an image to the specified size with current color.
 *
 *    @param size    The returning image size.
 *
 *    @return The image instance.
 */
- (UIImage *)zj_toImageWithSize:(CGSize)size;

/**
 *
 *    Generate an image to the specified size with specified color.
 *
 *    @param color    The color to be used to generate an image.
 *    @param size    The result image size.
 *
 *    @return The image instance.
 */
+ (UIImage *)zj_imageWithColor:(UIColor *)color size:(CGSize)size;


/**
 * 使用16进制数字创建颜色
 */
+(instancetype)zj_colorWithHex:(uint32_t)hex;

/**
 * 随机颜色
 */
+(instancetype)zj_randomColor;

/**
 * RGB颜色
 */
+ (instancetype)zj_colorWithRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue;

/**
 十六进制字符串显示颜色
 
 @param color 十六进制字符串
 @param alpha 透明度
 @return 颜色
 */
+ (UIColor *)zj_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/**
 *  @brief  渐变颜色
 *
 *  @param fromColor  开始颜色
 *  @param toColor    结束颜色
 *  @param height     渐变高度
 *
 *  @return 渐变颜色
 */
+ (UIColor*)zj_gradientFromColor:(UIColor*)fromColor toColor:(UIColor*)toColor withHeight:(CGFloat)height;
@end
