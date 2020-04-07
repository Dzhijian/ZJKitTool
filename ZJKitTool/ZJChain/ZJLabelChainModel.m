//
//  ZJLabelChainModel.m
//  ZJKitTool
//
//  Created by 邓志坚 on 2020/3/27.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJLabelChainModel.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#define  ZJ_CHAIN_LABEL_IMPLEMENTATION(methodName, viewMethod, ParmaType)  ZJ_CHAIN_IMPLEMENTATION(methodName, viewMethod, ParmaType, ZJLabelChainModel * , UILabel)

@implementation ZJLabelChainModel

ZJ_CHAIN_LABEL_IMPLEMENTATION(text, setText, NSString *);
ZJ_CHAIN_LABEL_IMPLEMENTATION(font, setFont, UIFont *);
ZJ_CHAIN_LABEL_IMPLEMENTATION(textColor, setTextColor, UIColor *);
ZJ_CHAIN_LABEL_IMPLEMENTATION(attributedText, setAttributedText, NSAttributedString *);
ZJ_CHAIN_LABEL_IMPLEMENTATION(textAlignment, setTextAlignment, NSTextAlignment);
ZJ_CHAIN_LABEL_IMPLEMENTATION(numberOfLines, setNumberOfLines, NSInteger);
ZJ_CHAIN_LABEL_IMPLEMENTATION(lineBreakMode, setLineBreakMode, NSLineBreakMode);
ZJ_CHAIN_LABEL_IMPLEMENTATION(adjustsFontSizeToFitWidth, setAdjustsFontSizeToFitWidth, BOOL);

@end


@implementation UILabel (ZJChain)

- (ZJLabelChainModel *)zj_chain{
    
    ZJLabelChainModel *model = objc_getAssociatedObject(self, _cmd);
    if (!model) {

        NSAssert(![self isKindOfClass:[ZJLabelChainModel class]], @"类型错误");

        model = [ZJLabelChainModel new];
        model.view = self;
        objc_setAssociatedObject(self, _cmd, model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
    }
    return model;
}

@end
