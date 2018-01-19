//
//  UIColor+ZJColor.m
//  ZJUIKit
//
//  Created by dzj on 2017/12/1.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import "UIColor+ZJColor.h"

@implementation UIColor (ZJColor)
+(instancetype)zj_colorWithHex:(uint32_t)hex{
    uint8_t r = (hex & 0xff0000) >> 16;
    uint8_t g = (hex & 0x00ff00) >> 8;
    uint8_t b = hex & 0x0000ff;
    return [self zj_colorWithRed:r green:g blue:b];
}

+(instancetype)zj_randomColor{
    return [UIColor zj_colorWithRed:arc4random_uniform(256) green:arc4random_uniform(256) blue:arc4random_uniform(256)];
}
+(instancetype)zj_colorWithRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}
+(UIColor *)zj_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    NSString *cstring = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]uppercaseString];
    if ([cstring length] < 6) {
        return [UIColor clearColor];
    }
    if ([cstring hasPrefix:@"0X"]) {
        cstring = [cstring substringFromIndex:2];
    }
    if ([cstring hasPrefix:@"#"]) {
        cstring = [cstring substringFromIndex:1];
    }
    if ([cstring length] != 6) {
        return [UIColor clearColor];
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    // red
    NSString *rString = [cstring substringWithRange:range];
    // green
    range.location = 2;
    NSString *gString = [cstring substringWithRange:range];
    // blue
    range.location = 4;
    NSString *bString = [cstring substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}


+ (UIColor*)zj_gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(CGFloat)height
{
    CGSize size = CGSizeMake(1, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    NSArray* colors = [NSArray arrayWithObjects:(id)c1.CGColor, (id)c2.CGColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)colors, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, size.height), 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}

@end
