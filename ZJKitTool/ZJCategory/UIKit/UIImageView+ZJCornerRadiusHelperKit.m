//
//  UIImageView+ZJCornerRadiusHelperKit.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/23.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "UIImageView+ZJCornerRadiusHelperKit.h"
#import <objc/runtime.h>

const char kProcessedImage;

@interface UIImageView ()

@property (assign, nonatomic) CGFloat zjRadius;
@property (assign, nonatomic) UIRectCorner roundingCorners;
@property (assign, nonatomic) CGFloat zjBorderWidth;
@property (strong, nonatomic) UIColor *zjBorderColor;
@property (assign, nonatomic) BOOL zjHadAddObserver;
@property (assign, nonatomic) BOOL zjIsRounding;

@end


@implementation UIImageView (ZJCornerRadiusHelperKit)
/**
 * @brief init the Rounding UIImageView, no off-screen-rendered
 */
- (instancetype)initWithRoundingRectImageView {
    self = [super init];
    if (self) {
        [self zj_cornerRadiusRoundingRect];
    }
    return self;
}

/**
 * @简单的初始化UIImageView的角半径
 */
- (instancetype)initWithCornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType {
    self = [super init];
    if (self) {
        [self zj_cornerRadiusAdvance:cornerRadius rectCornerType:rectCornerType];
    }
    return self;
}

/**
 * @在UIImageView的边框上加上宽度和颜色。
 */
- (void)zj_attachBorderWidth:(CGFloat)width color:(UIColor *)color {
    self.zjBorderWidth = width;
    self.zjBorderColor = color;
}

#pragma mark - Kernel
/**
 * @ 使用图像的转角半径，UIImageView必须是之前的setFrame，不要在屏幕外显示。
 */
- (void)zj_cornerRadiusWithImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType {
    CGSize size = self.bounds.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize cornerRadii = CGSizeMake(cornerRadius, cornerRadius);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    if (nil == currentContext) {
        return;
    }
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCornerType cornerRadii:cornerRadii];
    [cornerPath addClip];
    [self.layer renderInContext:currentContext];
    [self drawBorder:cornerPath];
    UIImage *processedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (processedImage) {
        objc_setAssociatedObject(processedImage, &kProcessedImage, @(1), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    self.image = processedImage;
}

/**
 * @用图像来简单的截取角半径，画出你想要的背景色，UIImageView必须是之前的setFrame，没有屏幕外渲染，没有颜色混合层。
 */
- (void)zj_cornerRadiusWithImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType backgroundColor:(UIColor *)backgroundColor {
    CGSize size = self.bounds.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize cornerRadii = CGSizeMake(cornerRadius, cornerRadius);
    
    UIGraphicsBeginImageContextWithOptions(size, YES, scale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    if (nil == currentContext) {
        return;
    }
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCornerType cornerRadii:cornerRadii];
    UIBezierPath *backgroundRect = [UIBezierPath bezierPathWithRect:self.bounds];
    [backgroundColor setFill];
    [backgroundRect fill];
    [cornerPath addClip];
    [self.layer renderInContext:currentContext];
    [self drawBorder:cornerPath];
    UIImage *processedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (processedImage) {
        objc_setAssociatedObject(processedImage, &kProcessedImage, @(1), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    self.image = processedImage;
}

/**
 * @为UIImageView做一个简短的设置角半径，不显示屏幕外。
 */
- (void)zj_cornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType {
    self.zjRadius = cornerRadius;
    self.roundingCorners = rectCornerType;
    self.zjIsRounding = NO;
    if (!self.zjHadAddObserver) {
        [[self class] swizzleDealloc];
        [self addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
        self.zjHadAddObserver = YES;
    }
    //Xcode 8 xib 删除了控件的Frame信息，需要主动创造
    [self layoutIfNeeded];
}

/**
 * @简写为UIImageView，没有屏幕外渲染。
 */
- (void)zj_cornerRadiusRoundingRect {
    self.zjIsRounding = YES;
    if (!self.zjHadAddObserver) {
        [[self class] swizzleDealloc];
        [self addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
        self.zjHadAddObserver = YES;
    }
    //Xcode 8 xib 删除了控件的Frame信息，需要主动创造
    [self layoutIfNeeded];
}

#pragma mark - Private
- (void)drawBorder:(UIBezierPath *)path {
    if (0 != self.zjBorderWidth && nil != self.zjBorderColor) {
        [path setLineWidth:2 * self.zjBorderWidth];
        [self.zjBorderColor setStroke];
        [path stroke];
    }
}

- (void)zj_dealloc {
    if (self.zjHadAddObserver) {
        [self removeObserver:self forKeyPath:@"image"];
    }
    [self zj_dealloc];
}

- (void)validateFrame {
    if (self.frame.size.width == 0) {
        [self.class swizzleLayoutSubviews];
    }
}

+ (void)swizzleMethod:(SEL)oneSel anotherMethod:(SEL)anotherSel {
    Method oneMethod = class_getInstanceMethod(self, oneSel);
    Method anotherMethod = class_getInstanceMethod(self, anotherSel);
    method_exchangeImplementations(oneMethod, anotherMethod);
}

+ (void)swizzleDealloc {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod:NSSelectorFromString(@"dealloc") anotherMethod:@selector(zj_dealloc)];
    });
}

+ (void)swizzleLayoutSubviews {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod:@selector(layoutSubviews) anotherMethod:@selector(zj_LayoutSubviews)];
    });
}

- (void)zj_LayoutSubviews {
    [self zj_LayoutSubviews];
    if (self.zjIsRounding) {
        [self zj_cornerRadiusWithImage:self.image cornerRadius:self.frame.size.width/2 rectCornerType:UIRectCornerAllCorners];
    } else if (0 != self.zjRadius && 0 != self.roundingCorners && nil != self.image) {
        [self zj_cornerRadiusWithImage:self.image cornerRadius:self.zjRadius rectCornerType:self.roundingCorners];
    }
}

#pragma mark - KVO for .image
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"image"]) {
        UIImage *newImage = change[NSKeyValueChangeNewKey];
        if ([newImage isMemberOfClass:[NSNull class]]) {
            return;
        } else if ([objc_getAssociatedObject(newImage, &kProcessedImage) intValue] == 1) {
            return;
        }
        [self validateFrame];
        if (self.zjIsRounding) {
            [self zj_cornerRadiusWithImage:newImage cornerRadius:self.frame.size.width/2 rectCornerType:UIRectCornerAllCorners];
        } else if (0 != self.zjRadius && 0 != self.roundingCorners && nil != self.image) {
            [self zj_cornerRadiusWithImage:newImage cornerRadius:self.zjRadius rectCornerType:self.roundingCorners];
        }
    }
}

#pragma mark property
- (CGFloat)zjBorderWidth {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setZjBorderWidth:(CGFloat)zjBorderWidth {
    objc_setAssociatedObject(self, @selector(zjBorderWidth), @(zjBorderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)zjBorderColor {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setZjBorderColor:(UIColor *)zjBorderColor {
    objc_setAssociatedObject(self, @selector(zjBorderColor), zjBorderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)zjHadAddObserver {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setZjHadAddObserver:(BOOL)zjHadAddObserver {
    objc_setAssociatedObject(self, @selector(zjHadAddObserver), @(zjHadAddObserver), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)zjIsRounding {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setZjIsRounding:(BOOL)zjIsRounding {
    objc_setAssociatedObject(self, @selector(zjIsRounding), @(zjIsRounding), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIRectCorner)roundingCorners {
    return [objc_getAssociatedObject(self, _cmd) unsignedLongValue];
}

- (void)setRoundingCorners:(UIRectCorner)roundingCorners {
    objc_setAssociatedObject(self, @selector(roundingCorners), @(roundingCorners), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)zjRadius {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setZjRadius:(CGFloat)zjRadius {
    objc_setAssociatedObject(self, @selector(zjRadius), @(zjRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
