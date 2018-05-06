//
//  UIControl+ZJActionBlock.m
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/5/6.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "UIControl+ZJActionBlock.h"
#import <objc/runtime.h>


static const void *s_ZJButtonTouchUpKey     = "s_ZJButtonTouchUpKey";


@implementation UIControl (ZJActionBlock)

-(ZJButtonActionBlock)zj_btnOnTouchUp{
    return objc_getAssociatedObject(self, s_ZJButtonTouchUpKey);
}

-(void)setZj_btnOnTouchUp:(ZJButtonActionBlock)zj_btnOnTouchUp{
    objc_setAssociatedObject(self, s_ZJButtonTouchUpKey, zj_btnOnTouchUp, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self removeTarget:self action:@selector(zj_private_btnOnTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    
    if (zj_btnOnTouchUp) {
        [self addTarget:self action:@selector(zj_private_btnOnTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    }
}



-(void)zj_private_btnOnTouchUp:(id)sender{
    ZJButtonActionBlock block  = [self zj_btnOnTouchUp];
    if (block) {
        block(sender);
    }
}


@end
