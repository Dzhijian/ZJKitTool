//
//  ZJCollectionViewCell.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/30.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//
/**
 *  ZJKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下,给个Star。😆
 */
#import "ZJCollectionViewCell.h"

@interface ZJCollectionViewCell()


@end

@implementation ZJCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 添加一个UIImageView
        self.imgView = [UIImageView new];
        self.imgView.zj_chain.superView(self.contentView)
        .backgroundColor(kRGBColor(220, 220, 220))
        .contentMode(UIViewContentModeScaleAspectFill)
        .clipsToBounds(true)
        .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
            make.edges.mas_equalTo(0);
        });
    }
    return self;
}

@end
