//
//  UIControl+ZJActionBlock.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/5/6.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * Button点击事件Block
 *
 */
typedef void(^ZJButtonActionBlock)(id sender);

@interface UIControl (ZJActionBlock)
/**
 *
 *    Make it support block callback of touch up event.
 */
@property (nonatomic, copy) ZJButtonActionBlock zj_btnOnTouchUp;


@end
