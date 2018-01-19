//
//  UIView+ZJHelperKitUIkit.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/17.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "UIView+ZJHelperKitUIkit.h"

@implementation UIView (ZJHelperKitUIkit)

- (void)setzj_origin:(CGPoint)zj_origin {
    CGRect frame = self.frame;
    frame.origin = zj_origin;
    self.frame = frame;
}

- (CGPoint)zj_origin {
    return self.frame.origin;
}

- (void)setzj_originX:(CGFloat)zj_originX {
    [self setzj_origin:CGPointMake(zj_originX, self.zj_originY)];
}

- (CGFloat)zj_originX {
    return self.zj_origin.x;
}

- (void)setzj_originY:(CGFloat)zj_originY {
    [self setzj_origin:CGPointMake(self.zj_originX, zj_originY)];
}

- (CGFloat)zj_originY {
    return self.zj_origin.y;
}

- (void)setzj_center:(CGPoint)zj_center {
    self.center = zj_center;
}

- (CGPoint)zj_center {
    return self.center;
}

- (void)setzj_centerX:(CGFloat)zj_centerX {
    [self setzj_center:CGPointMake(zj_centerX, self.zj_centerY)];
}

- (CGFloat)zj_centerX {
    return self.zj_center.x;
}

- (void)setzj_centerY:(CGFloat)zj_centerY {
    [self setzj_center:CGPointMake(self.zj_centerX, zj_centerY)];
}

- (CGFloat)zj_centerY {
    return self.zj_center.y;
}

- (void)setzj_size:(CGSize)zj_size {
    CGRect frame = self.frame;
    frame.size = zj_size;
    self.frame = frame;
}

- (CGSize)zj_size {
    return self.frame.size;
}

- (void)setzj_width:(CGFloat)zj_width {
    self.zj_size = CGSizeMake(zj_width, self.zj_height);
}

- (CGFloat)zj_width {
    return self.zj_size.width;
}

- (void)setzj_height:(CGFloat)zj_height {
    self.zj_size = CGSizeMake(self.zj_width, zj_height);
}

- (CGFloat)zj_height {
    return self.zj_size.height;
}

- (CGFloat)zj_bottomY {
    return self.zj_originY + self.zj_height;
}

- (void)setzj_bottomY:(CGFloat)zj_bottomY {
    self.zj_originY = zj_bottomY - self.zj_height;
}

- (CGFloat)zj_rightX {
    return self.zj_originX + self.zj_width;
}

- (void)setzj_rightX:(CGFloat)zj_rightX {
    self.zj_originX = zj_rightX - self.zj_width;
}

@end
