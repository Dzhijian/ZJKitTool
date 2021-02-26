//
//  UIGestureRecognizer+ZJActionBlock.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/5/6.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * gesture事件Block
 *
 */
typedef void(^ZJGestureBlock)(UIGestureRecognizer *gesture);


/**
 * Tap点击事件Block
 *
 */
typedef void(^ZJTapGestureBlock)(UITapGestureRecognizer *gesture);

/**
 * Tap长按事件Block
 *
 */
typedef void(^ZJLongGestureBlock)(UILongPressGestureRecognizer *gesture);

@interface UIGestureRecognizer (ZJActionBlock)
/**
 *  所有手势都支持Block回调。
 *  支持各种手势。
 */
@property (nonatomic, copy) ZJGestureBlock zj_onGesture;

/**
 *
 *    tap手势支持Block回调。
 */
@property (nonatomic, copy) ZJTapGestureBlock zj_onTaped;

/**
 *
 *    long手势支持Block回调。
 */
@property (nonatomic, copy) ZJLongGestureBlock zj_onLongPressed;

@end
