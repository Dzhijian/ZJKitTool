//
//  UIControl+ZJHelperBlockKit.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/18.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "UIControl+ZJHelperBlockKit.h"
#import <objc/runtime.h>


static const void *s_ZJButtonTouchUpKey     = "s_ZJButtonTouchUpKey";
static const void *s_ZJButtonTouchUDownKey  = "s_ZJButtonTouchUDownKey";
static const void *s_ZJOnValueChangedKey    = "s_ZJOnValueChangedKey";
static const void *s_ZJOnEditChangedKey     = "s_ZJOnEditChangedKey";

@implementation UIControl (ZJHelperBlockKit)


-(ZJButtonBlock)zj_onTouchUp{
    return objc_getAssociatedObject(self, s_ZJButtonTouchUpKey);
}

-(void)setZj_onTouchUp:(ZJButtonBlock)zj_onTouchUp{
    objc_setAssociatedObject(self, s_ZJButtonTouchUpKey, zj_onTouchUp, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self removeTarget:self action:@selector(zj_private_onTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    
    if (zj_onTouchUp) {
        [self addTarget:self action:@selector(zj_private_onTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

-(ZJButtonBlock)zj_onTouchDown{
    return objc_getAssociatedObject(self, s_ZJButtonTouchUDownKey);
}

-(void)setZj_onTouchDown:(ZJButtonBlock)zj_onTouchDown{
    
    [self removeTarget:self action:@selector(zj_private_onTouchDown:) forControlEvents:UIControlEventTouchDown];
    if (zj_onTouchDown) {
        [self addTarget:self action:@selector(zj_private_onTouchDown:) forControlEvents:UIControlEventTouchDown];
    }
    
    objc_setAssociatedObject(self, s_ZJButtonTouchUDownKey, zj_onTouchDown, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

-(ZJChangeValueBlock)zj_onValueChanged{
    return objc_getAssociatedObject(self, s_ZJOnValueChangedKey);
}

-(void)setZj_onValueChanged:(ZJChangeValueBlock)zj_onValueChanged{
    objc_setAssociatedObject(self, s_ZJOnValueChangedKey, zj_onValueChanged, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self removeTarget:self action:@selector(zj_private_onValueChanged:) forControlEvents:UIControlEventValueChanged];
    if (zj_onValueChanged) {
        [self addTarget:self action:@selector(zj_private_onValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
}

-(ZJEditChangeBlock)zj_onEditChanged{
    return objc_getAssociatedObject(self, s_ZJOnEditChangedKey);
}

-(void)setZj_onEditChanged:(ZJEditChangeBlock)zj_onEditChanged{
    objc_setAssociatedObject(self, s_ZJOnValueChangedKey, zj_onEditChanged, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self removeTarget:self action:@selector(zj_private_onEditChanged:) forControlEvents:UIControlEventValueChanged];
    if (zj_onEditChanged) {
        [self addTarget:self action:@selector(zj_private_onEditChanged:) forControlEvents:UIControlEventValueChanged];
    }
}


-(void)zj_private_onTouchUp:(id)sender{
    ZJButtonBlock block  = [self zj_onTouchUp];
    if (block) {
        block(sender);
    }
}

-(void)zj_private_onTouchDown:(id)sender{
    ZJButtonBlock block  = [self zj_onTouchDown];
    if (block) {
        block(sender);
    }
}

- (void)zj_private_onValueChanged:(id)sender {
    ZJChangeValueBlock block = [self zj_onValueChanged];
    
    if (block) {
        block(sender);
    }
}

- (void)zj_private_onEditChanged:(id)sender {
    ZJEditChangeBlock block = [self zj_onEditChanged];
    
    if (block) {
        block(sender);
    }
}
@end
