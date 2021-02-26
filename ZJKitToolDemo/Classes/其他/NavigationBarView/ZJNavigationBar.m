//
//  ZJNavigationBar.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/31.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJNavigationBar.h"

@interface ZJNavigationBar()

@property(nonatomic ,strong) UILabel *titleLab;

@end

@implementation ZJNavigationBar


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
    }
    return self;
}

-(void)setZj_title:(NSString *)zj_title{
    _zj_title = zj_title;
    self.titleLab.text = zj_title;
}


-(void)zj_setNavBarTint:(UIColor *)tintColor navBackColor:(UIColor *)backColor{
    if (tintColor) {
        self.titleLab.textColor = tintColor;
        [self.zj_leftBtn setTitleColor:tintColor forState:(UIControlStateNormal)];
        [self.zj_rightBtn setTitleColor:tintColor forState:UIControlStateNormal];
    }
    
    if (backColor != nil) {
        self.backgroundColor = backColor;
    }
    
}

-(void)setUpAllView{
    
    kWeakObject(self);
    self.titleLab = [UILabel new];
    self.titleLab.zj_chain.font(kBoldFontWithSize(16))
    .numberOfLines(1)
    .textColor(kBlackColor)
    .superView(self)
    .backgroundColor( [UIColor clearColor])
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.bottom.mas_equalTo(-10);
        make.centerX.mas_equalTo(0);
    });
   
    self.zj_leftBtn = [[UIButton alloc]init];
    self.zj_leftBtn.zj_chain.title(@"返回", UIControlStateNormal)
    .titleColor(kBlackColor, UIControlStateNormal)
    .backgroundColor(kClearColor)
    .titleFont([UIFont systemFontOfSize:15])
    .superView(self)
    .onTouchUp(^(id  _Nonnull sender) {
        if ([weakObject.delegate respondsToSelector:@selector(zj_navigationBarLeftBtnAction:)]) {
            [weakObject.delegate zj_navigationBarLeftBtnAction:sender];
        }
    })
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.left.mas_equalTo(15);
        make.centerY.equalTo(_titleLab.mas_centerY);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    });
        
    
    self.zj_rightBtn = [[UIButton alloc]init];
    self.zj_rightBtn.zj_chain.title(@"确定", UIControlStateNormal)
    .titleColor(kBlackColor, UIControlStateNormal)
    .backgroundColor(kClearColor)
    .titleFont([UIFont systemFontOfSize:15])
    .superView(self)
    .onTouchUp(^(id  _Nonnull sender) {
        if ([weakObject.delegate respondsToSelector:@selector(zj_navigationBarRightBtnAction:)]) {
            [weakObject.delegate zj_navigationBarRightBtnAction:sender];
        }
    })
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.right.mas_equalTo(-15);
        make.centerY.equalTo(_titleLab.mas_centerY);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    });
    
    
    self.lineView = [[UIView alloc]init];
    self.lineView.zj_chain.backgroundColor(kLightGrayColor)
    .superView(self)
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    });
}

@end
