//
//  UIView+ZJHelperKitUIkit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/17.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZJHelperKitUIkit)
#pragma mark - Convenience frame api
/**
 * view.frame.origin.x
 */
@property (nonatomic, assign) CGFloat zj_originX;

/**
 * view.frame.origin.y
 */
@property (nonatomic, assign) CGFloat zj_originY;

/**
 * view.frame.origin
 */
@property (nonatomic, assign) CGPoint zj_origin;

/**
 * view.center.x
 */
@property (nonatomic, assign) CGFloat zj_centerX;

/**
 * view.center.y
 */
@property (nonatomic, assign) CGFloat zj_centerY;

/**
 * view.center
 */
@property (nonatomic, assign) CGPoint zj_center;

/**
 * view.frame.size.width
 */
@property (nonatomic, assign) CGFloat zj_width;

/**
 * view.frame.size.height
 */
@property (nonatomic, assign) CGFloat zj_height;

/**
 * view.frame.size
 */
@property (nonatomic, assign) CGSize  zj_size;

/**
 * view.frame.size.height + view.frame.origin.y
 */
@property (nonatomic, assign) CGFloat zj_bottomY;

/**
 * view.frame.size.width + view.frame.origin.x
 */
@property (nonatomic, assign) CGFloat zj_rightX;
@end
