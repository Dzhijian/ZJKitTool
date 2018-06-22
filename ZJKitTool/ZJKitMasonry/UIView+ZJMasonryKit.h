//
//  UIView+ZJMasonryKit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/18.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJKitMasonryTool.h"
#import "UIGestureRecognizer+ZJActionBlock.h"

@interface UIView (ZJMasonryKit)

/**
 *  点击手势
 */
@property (nonatomic, strong, readonly) UITapGestureRecognizer *zj_tapGesture;

/**
 *
 *    长按手势
 */
@property (nonatomic, strong, readonly) UILongPressGestureRecognizer *zj_longGesure;



/**
 * 快速创建一个View，设置背景颜色，布局
 
 @param backColor   背景颜色
 @param supView     父视图
 @param constraints 布局
 @return 返回一个View
 */
+(instancetype)zj_viewWithBackColor:(UIColor *)backColor
                            supView:(UIView *)supView
                        constraints:(ZJConstrainMaker)constraints;

/**
 * 快速创建一个View，设置背景颜色，布局，点击事件

 @param backColor 背景颜色
 @param constraints 布局
 @param supView     父视图
 @param onTap 点击事件
 @return 返回一个View
 */
+(instancetype)zj_viewWithBackColor:(UIColor *)backColor
                            supView:(UIView *)supView
                        constraints:(ZJConstrainMaker)constraints
                              onTap:(ZJTapGestureBlock)onTap;


/**
 *
 *    在回调中添加一个tap手势。它将自动打开用户界面为YES。
 *
 *    @param onTaped    The callback block when taped.
 */
- (void)zj_addTapGestureWithCallback:(ZJTapGestureBlock)onTaped;

/**
 *
 *    添加长按手势与回调。它将自动打开用户界面为YES。
 *
 *    @param onLongPressed    The long press callback when long pressed.
 */
- (void)zj_addLongGestureWithCallback:(ZJLongGestureBlock)onLongPressed;

@end
