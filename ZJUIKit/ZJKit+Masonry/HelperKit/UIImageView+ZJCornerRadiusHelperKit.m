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
 * @brief init the UIImageView with cornerRadius, no off-screen-rendered
 */
- (instancetype)initWithCornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType {
    self = [super init];
    if (self) {
        [self zj_cornerRadiusAdvance:cornerRadius rectCornerType:rectCornerType];
    }
    return self;
}

/**
 * @brief attach border for UIImageView with width & color
 */
- (void)zj_attachBorderWidth:(CGFloat)width color:(UIColor *)color {
    self.zjBorderWidth = width;
    self.zjBorderColor = color;
}

#pragma mark - Kernel
/**
 * @brief clip the cornerRadius with image, UIImageView must be setFrame before, no off-screen-rendered
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
 * @brief clip the cornerRadius with image, draw the backgroundColor you want, UIImageView must be setFrame before, no off-screen-rendered, no Color Blended layers
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
 * @brief set cornerRadius for UIImageView, no off-screen-rendered
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
 * @brief become Rounding UIImageView, no off-screen-rendered
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
