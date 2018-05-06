//
//  UIGestureRecognizer+ZJActionBlock.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/5/6.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJKitMasonryTool.h"
@interface UIGestureRecognizer (ZJActionBlock)
/**
 *
 *    Make all gestures support block callback.
 *  This will support all kinds of gestures.
 */
@property (nonatomic, copy) ZJGestureBlock zj_onGesture;

/**
 *
 *    Make tap gesture support block callback.
 */
@property (nonatomic, copy) ZJTapGestureBlock zj_onTaped;

/**
 *
 *    Make long press gesture support block callback.
 */
@property (nonatomic, copy) ZJLongGestureBlock zj_onLongPressed;

@end
