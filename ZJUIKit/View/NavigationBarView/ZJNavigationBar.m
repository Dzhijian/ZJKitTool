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
    self.titleLab = [UILabel zj_labelWithFont:kBoldFontWithSize(16) lines:1 text:nil textColor:kBlackColor superView:self constraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(10);
        make.centerX.mas_equalTo(0);
    }];
    
    self.zj_leftBtn = [UIButton zj_buttonWithTitle:@"返回" superView:self constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.equalTo(_titleLab.mas_centerY);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    } touchUp:^(id sender) {
        
        if ([weakObject.delegate respondsToSelector:@selector(zj_navigationBarLeftBtnAction:)]) {
            [weakObject.delegate zj_navigationBarLeftBtnAction:sender];
        }
    }];
    
    self.zj_rightBtn  = [UIButton zj_buttonWithTitle:@"确定" titleColor:kBlackColor backColor:kClearColor fontSize:14 isBold:NO cornerRadius:0 supView:self constraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.equalTo(_titleLab.mas_centerY);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    } touchUp:^(id sender) {
        if ([weakObject.delegate respondsToSelector:@selector(zj_navigationBarRightBtnAction:)]) {
            [weakObject.delegate zj_navigationBarRightBtnAction:sender];
        }
    }];
    
    self.zj_leftBtn.titleLabel.font = kFontWithSize(15);
    
    self.lineView = [UIView zj_viewWithBackColor:kLightGrayColor supView:self constraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}

@end
