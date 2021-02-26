//
//  ZJPopShowView.m
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/11/29.
//  Copyright © 2018 kapokcloud. All rights reserved.
//

#import "ZJPopShowView.h"

@interface ZJPopShowView ()

@end

@implementation ZJPopShowView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kOrangeColor;
        kWeakObject(self)
        UILabel *lab = [UILabel new];
        lab.zj_chain.font(kFontSize(14))
        .numberOfLines(1)
        .text(@"ZJPopShowView")
        .textColor(kWhiteColor)
        .superView(self)
        .backgroundColor(kOrangeColor)
        .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
            make.center.mas_equalTo(0);
        });

        UIButton *cancelBtn =  [UIButton new];
        cancelBtn.zj_chain
        .title(@"取消", UIControlStateNormal)
        .titleColor(kOrangeColor, UIControlStateNormal)
        .backgroundColor(kWhiteColor)
        .titleFont([UIFont boldSystemFontOfSize:14])
        .superView(self)
        .cornerRadius(20)
        .onTouchUp(^(id  _Nonnull sender) {
            if (weakObject.closeBlock) {
                weakObject.closeBlock();
            }        })
        .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
            make.bottom.mas_equalTo(-10);
            make.left.mas_equalTo(20);
            make.right.equalTo(self.mas_centerX).offset(-10);
            make.height.mas_equalTo(40);
        });
        
        UIButton *OKBtn =  [UIButton new];
        OKBtn.zj_chain
        .title(@"确认", UIControlStateNormal)
        .titleColor(kOrangeColor, UIControlStateNormal)
        .backgroundColor(kWhiteColor)
        .titleFont([UIFont boldSystemFontOfSize:14])
        .superView(self)
        .cornerRadius(20)
        .onTouchUp(^(id  _Nonnull sender) {
            if (weakObject.okBlock) {
                weakObject.okBlock();
            }
        })
        .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
            make.bottom.mas_equalTo(-10);
            make.left.equalTo(cancelBtn.mas_right).offset(20);
            make.right.mas_equalTo(-30);
            make.height.mas_equalTo(40);
        });
        
       
    }
    return self;
}

@end
