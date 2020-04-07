//
//  ZJSwitchChainModel.m
//  ZJKitTool
//
//  Created by 邓志坚 on 2020/3/29.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJSwitchChainModel.h"
#import <objc/runtime.h>

#define  ZJ_CHAIN_SWITCH_IMPLEMENTATION(methodName, viewMethod, ParmaType)  ZJ_CHAIN_IMPLEMENTATION(methodName, viewMethod, ParmaType, ZJSwitchChainModel * , UISwitch)

@implementation ZJSwitchChainModel

ZJ_CHAIN_SWITCH_IMPLEMENTATION(on, setOn, BOOL);
ZJ_CHAIN_SWITCH_IMPLEMENTATION(onTintColor, setOnTintColor, UIColor *);
ZJ_CHAIN_SWITCH_IMPLEMENTATION(thumbTintColor, setThumbTintColor, UIColor *);

ZJ_CHAIN_SWITCH_IMPLEMENTATION(onImage, setOnImage, UIImage *);
ZJ_CHAIN_SWITCH_IMPLEMENTATION(offImage, setOffImage,UIImage *);

#pragma mark - # UIControl
ZJ_CHAIN_SWITCH_IMPLEMENTATION(enabled, setEnabled, BOOL);
ZJ_CHAIN_SWITCH_IMPLEMENTATION(selected, setSelected ,BOOL);
ZJ_CHAIN_SWITCH_IMPLEMENTATION(highlighted, setHighlighted, BOOL);

@end


@implementation UISwitch (ZJChain)

- (ZJSwitchChainModel *)zj_chain{
    
    ZJSwitchChainModel *model = objc_getAssociatedObject(self, _cmd);
    if (!model) {

        NSAssert(![self isKindOfClass:[ZJSwitchChainModel class]], @"类型错误");
        model = [ZJSwitchChainModel new];
        model.view = self;
        objc_setAssociatedObject(self, _cmd, model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
    }
    return model;
}
@end
