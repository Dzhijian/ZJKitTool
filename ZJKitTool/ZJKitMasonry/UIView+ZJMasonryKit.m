//
//  UIView+ZJMasonryKit.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/18.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "UIView+ZJMasonryKit.h"
#import <objc/runtime.h>

static const void *s_zj_tapGestureKey = "s_zj_tapGestureKey";
static const void *s_zj_longGestureKey = "s_zj_longGestureKey";

@implementation UIView (ZJMasonryKit)


/**
 * 快速创建一个View，设置背景颜色，布局，点击事件
 
 @param backColor 背景颜色
 @param constraints 布局
 @return 返回一个View
 */
+(instancetype)zj_viewWithBackColor:(UIColor *)backColor
                            supView:(UIView *)supView
                        constraints:(ZJConstrainMaker)constraints
{
    return [self zj_viewWithBackColor:backColor supView:supView constraints:constraints onTap:nil];
}

/**
 * 快速创建一个View，设置背景颜色，布局，点击事件
 
 @param backColor 背景颜色
 @param constraints 布局
 @param onTap 点击事件
 @return 返回一个View
 */
+(instancetype)zj_viewWithBackColor:(UIColor *)backColor
                            supView:(UIView *)supView
                        constraints:(ZJConstrainMaker)constraints
                              onTap:(ZJTapGestureBlock)onTap{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = backColor;
    
    [supView addSubview:view];
    if (supView && constraints) {
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            constraints(make);
        }];
    }
    
    if (onTap) {
        [view zj_addTapGestureWithCallback:onTap];
    }
    
    return view;
    
}


- (UITapGestureRecognizer *)zj_tapGesture {
    return objc_getAssociatedObject(self, s_zj_tapGestureKey);
}

- (UILongPressGestureRecognizer *)zj_longGesure {
    return objc_getAssociatedObject(self, s_zj_longGestureKey);
}

- (void)zj_addTapGestureWithCallback:(ZJTapGestureBlock)onTaped {
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.zj_onTaped = onTaped;
    [self addGestureRecognizer:tap];
    
    objc_setAssociatedObject(self,
                             s_zj_tapGestureKey,
                             tap,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)zj_addLongGestureWithCallback:(ZJLongGestureBlock)onLongPressed {
    self.userInteractionEnabled = YES;
    
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] init];
    gesture.zj_onLongPressed = onLongPressed;
    [self addGestureRecognizer:gesture];
    
    objc_setAssociatedObject(self,
                             s_zj_longGestureKey,
                             gesture,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}


@end
