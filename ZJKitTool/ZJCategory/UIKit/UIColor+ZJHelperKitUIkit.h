//
//  UIColor+ZJHelperKitUIkit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//



@interface UIColor (ZJHelperKitUIkit)
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


@end
