//
//  UIControl+ZJHelperBlockKit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/18.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Button点击事件Block
 *
 */
typedef void(^ZJButtonBlock)(id sender);
/**
 * 改变值Block
 *
 */
typedef void(^ZJChangeValueBlock)(id sender);
/**
 * 编辑改变值block
 * 例如： UITextField
 */
typedef void(^ZJEditChangeBlock)(id sender);


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
