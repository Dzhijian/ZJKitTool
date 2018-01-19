//
//  UIGestureRecognizer+ZJHelperBlockKit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/18.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (ZJHelperBlockKit)

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
