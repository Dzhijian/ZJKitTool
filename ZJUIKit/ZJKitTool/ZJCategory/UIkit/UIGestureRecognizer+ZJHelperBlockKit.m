//
//  UIGestureRecognizer+ZJHelperBlockKit.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/18.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "UIGestureRecognizer+ZJHelperBlockKit.h"
#import <objc/runtime.h>

static const void *s_zj_gestureKey = "s_zj_gestureKey";
static const void *s_zj_tap_gestureKey = "s_zj_tap_gestureKey";
static const void *s_zj_long_gestureKey = "s_zj_long_gestureKey";


@implementation UIGestureRecognizer (ZJHelperBlockKit)


- (ZJGestureBlock)zj_onGesture {
    return objc_getAssociatedObject(self, s_zj_gestureKey);
}

- (void)setZj_onGesture:(ZJGestureBlock)zj_onGesture {
    objc_setAssociatedObject(self,
                             s_zj_gestureKey,
                             zj_onGesture,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self removeTarget:self action:@selector(zj_private_onGesture:)];
    
    if (zj_onGesture) {
        [self addTarget:self action:@selector(zj_private_onGesture:)];
    }
}

- (ZJTapGestureBlock)zj_onTaped {
    return objc_getAssociatedObject(self, s_zj_tap_gestureKey);
}

- (void)setZj_onTaped:(ZJTapGestureBlock)zj_onTaped {
    objc_setAssociatedObject(self,
                             s_zj_tap_gestureKey,
                             zj_onTaped,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self removeTarget:self action:@selector(zj_private_onTaped:)];
    
    if (zj_onTaped) {
        [self addTarget:self action:@selector(zj_private_onTaped:)];
    }
}

- (ZJLongGestureBlock)zj_onLongPressed {
    return objc_getAssociatedObject(self, s_zj_long_gestureKey);
}

- (void)setZj_onLongPressed:(ZJLongGestureBlock)zj_onLongPressed {
    objc_setAssociatedObject(self,
                             s_zj_long_gestureKey,
                             zj_onLongPressed,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self removeTarget:self action:@selector(zj_private_onLongPressed:)];
    
    if (zj_onLongPressed) {
        [self addTarget:self action:@selector(zj_private_onLongPressed:)];
    }
}

#pragma mark - Private
- (void)zj_private_onGesture:(UIGestureRecognizer *)sender {
    ZJGestureBlock block = [self zj_onGesture];
    
    if (block) {
        block(sender);
    }
}

- (void)zj_private_onTaped:(UITapGestureRecognizer *)sender {
    ZJTapGestureBlock block = [self zj_onTaped];
    
    if (block) {
        block(sender);
    }
}

- (void)zj_private_onLongPressed:(UILongPressGestureRecognizer *)sender {
    ZJLongGestureBlock block = [self zj_onLongPressed];
    
    if (block) {
        block(sender);
    }
}




@end
