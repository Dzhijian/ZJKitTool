//
//  ZJFourChildView.m
//  ZJUIKit
//
//  Created by dzj on 2017/12/8.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//
/**
 *  ZJUIKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJUIKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下。😆
 */


#import "ZJFourChildView.h"

@interface ZJFourChildView()

@property(nonatomic ,strong) UIButton   *promBtn;
@property(nonatomic ,strong) UIButton   *verBtn;
@property(nonatomic ,strong) UIView     *line;
@property(nonatomic ,strong) UIButton   *resetBtn;
@property(nonatomic ,strong) UIButton   *comBtn;

@end

@implementation ZJFourChildView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
    }
    return self;
}

// 促销 实名认证按钮的点击事件
-(void)limitSelectedBtnAction:(UIButton *)sender{
    NSInteger tag = sender.tag;
    if (tag == 1001) { // 促销
        self.promBtn.selected = !self.promBtn.isSelected;
        if (_promBtn.isSelected) {
            [_promBtn setBackgroundColor:k16RGBColor(0xFD962A)];
            [_promBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
            _promBtn.layer.borderWidth = 0;
        }else{
            [_promBtn setBackgroundColor:[UIColor clearColor]];
            [_promBtn setTitleColor:kLightGrayColor forState:UIControlStateNormal];
            _promBtn.layer.borderColor = k16RGBColor(0xCCCCCC).CGColor;
            _promBtn.layer.borderWidth = 0.5;
        }
    }else if (tag == 1002){
        self.verBtn.selected = !self.verBtn.isSelected;
        if (_verBtn.isSelected) {
            [_verBtn setBackgroundColor:k16RGBColor(0xFD962A)];
            [_verBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
            _verBtn.layer.borderWidth = 0;
            
        }else{
            [_verBtn setBackgroundColor:[UIColor clearColor]];
            [_verBtn setTitleColor:kLightGrayColor forState:UIControlStateNormal];
            _verBtn.layer.borderColor = k16RGBColor(0xCCCCCC).CGColor;
            _verBtn.layer.borderWidth = 0.5;
        }
    }
}

// 重置 确定按钮的点击事件
-(void)selectBtnAction:(UIButton *)sender{
    NSInteger tag = sender.tag;
    if (tag == 1003) { // 重置
        _promBtn.selected = NO;
        _verBtn.selected = NO;
        [_promBtn setBackgroundColor:[UIColor clearColor]];
        [_promBtn setTitleColor:kLightGrayColor forState:UIControlStateNormal];
        _promBtn.layer.borderColor = k16RGBColor(0xCCCCCC).CGColor;
        _promBtn.layer.borderWidth = 0.5;
        [_verBtn setBackgroundColor:[UIColor clearColor]];
        [_verBtn setTitleColor:kLightGrayColor forState:UIControlStateNormal];
        _verBtn.layer.borderColor = k16RGBColor(0xCCCCCC).CGColor;
        _verBtn.layer.borderWidth = 0.5;
    }else if (tag == 1004){
        // 确定
        BOOL isProm = self.promBtn.isSelected;
        BOOL isVer = self.verBtn.isSelected;
        if ([self.delegate respondsToSelector:@selector(fourViewBtnSelectedWithIsProm:isVer:)]) {
            [self.delegate fourViewBtnSelectedWithIsProm:isProm isVer:isVer];
        }
    }
}

-(void)setUpAllView{
    [self addSubview:self.promBtn];
    [self addSubview:self.verBtn];
    [self addSubview:self.line];
    [self addSubview:self.resetBtn];
    [self addSubview:self.comBtn];
    
    [self.promBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(62);
        make.height.mas_equalTo(32);
    }];
    
    [self.verBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.equalTo(_promBtn.mas_right).offset(15);
        make.width.mas_equalTo(62);
        make.height.mas_equalTo(32);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_promBtn.mas_bottom).offset(20);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom).offset(20);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo((kScreenWidth-40)/2);
        make.height.mas_equalTo(32);
    }];
    
    [self.comBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom).offset(20);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo((kScreenWidth-40)/2);
        make.height.mas_equalTo(32);
    }];

}




-(UIButton *)promBtn{
    if (!_promBtn) {
        _promBtn = [[UIButton alloc]init];
        [_promBtn setTitle:@"促销" forState:UIControlStateNormal];
        [_promBtn setTitleColor:k16RGBColor(0x666666) forState:UIControlStateNormal];
        _promBtn.titleLabel.font = kFontWithSize(12);
        _promBtn.layer.borderColor = k16RGBColor(0xCCCCCC).CGColor;
        _promBtn.layer.borderWidth = 0.5;
        _promBtn.tag = 1001;
        _promBtn.layer.cornerRadius =2;
        _promBtn.hidden = YES;
        [_promBtn addTarget:self action:@selector(limitSelectedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _promBtn;
}
-(UIButton *)verBtn{
    if (!_verBtn) {
        _verBtn = [[UIButton alloc]init];
        [_verBtn setTitle:@"实名认证" forState:UIControlStateNormal];
        [_verBtn setTitleColor:k16RGBColor(0x666666) forState:UIControlStateNormal];
        _verBtn.titleLabel.font = kBoldFontWithSize(12);
        _verBtn.layer.borderColor = k16RGBColor(0xCCCCCC).CGColor;
        _verBtn.layer.borderWidth = 0.5;
        _verBtn.tag = 1002;
        _verBtn.layer.cornerRadius =2;
        _verBtn.hidden = YES;
        [_verBtn addTarget:self action:@selector(limitSelectedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _verBtn;
}
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = kLightGrayColor;
    }
    return _line;
}
-(UIButton *)resetBtn{
    if (!_resetBtn) {
        _resetBtn = [[UIButton alloc]init];
        [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        [_resetBtn setTitleColor:k16RGBColor(0x666666) forState:UIControlStateNormal];
        _resetBtn.titleLabel.font = kBoldFontWithSize(12);
        _resetBtn.layer.borderColor = k16RGBColor(0xCCCCCC).CGColor;
        _resetBtn.layer.borderWidth = 0.5;
        _resetBtn.tag = 1003;
        _resetBtn.layer.cornerRadius =2;
        _resetBtn.hidden = YES;
        [_resetBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetBtn;
}
-(UIButton *)comBtn{
    if (!_comBtn) {
        _comBtn = [[UIButton alloc]init];
        [_comBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_comBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _comBtn.titleLabel.font = kBoldFontWithSize(12);
        _comBtn.layer.borderColor = k16RGBColor(0xCCCCCC).CGColor;
        _comBtn.backgroundColor = k16RGBColor(0xFD962A);
        _comBtn.layer.cornerRadius =2;
        _comBtn.tag = 1004;
        _comBtn.hidden = YES;
        [_comBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _comBtn;
}

@end
