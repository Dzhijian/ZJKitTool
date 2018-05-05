//
//  UIControl+ZJHelperBlockKit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/18.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (ZJHelperBlockKit)

/**
 *
 *    Make it support block callback of touch up event.
 */
@property (nonatomic, copy) ZJButtonBlock zj_onTouchUp;

/**
 *
 *    Make it support block callback of touch down event.
 */
@property (nonatomic, copy) ZJButtonBlock zj_onTouchDown;

/**
 *
 *    Make it support block callback of value change event.
 */
@property (nonatomic, copy) ZJChangeValueBlock zj_onValueChanged;

/**
 *
 *    Make it support block callback of editing changed event.
 */
@property (nonatomic, copy) ZJEditChangeBlock zj_onEditChanged;



@end
