//
//  ZJKitMasonryTool.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/5/6.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Masonry/Masonry.h>

/**
 * Button点击事件Block
 *
 */
typedef void(^ZJButtonBlock)(id sender);
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

/**
 * Masonry Block
 *
 */
typedef void(^ZJConstrainMaker)(MASConstraintMaker *make);

@interface ZJKitMasonryTool : NSObject



@end
