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
        UILabel *lab = [UILabel zj_labelWithFont:kFontSize(14) lines:1 text:@"ZJPopShowView" textColor:kWhiteColor superView:self constraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
        }];
        
        lab.backgroundColor = kOrangeColor;
        
        UIButton *cancelBtn = [UIButton zj_buttonWithTitle:@"取消" superView:self constraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-10);
            make.left.mas_equalTo(20);
            make.right.equalTo(self.mas_centerX).offset(-10);
            make.height.mas_equalTo(40);
        } touchUp:^(id sender) {
            if (weakObject.closeBlock) {
                weakObject.closeBlock();
            }
        }];
        
        cancelBtn.backgroundColor = kWhiteColor;
        [cancelBtn setTitleColor:kOrangeColor forState:(UIControlStateNormal)];
        cancelBtn.layer.cornerRadius = 20;
        
        UIButton *OKBtn = [UIButton zj_buttonWithTitle:@"确认" superView:self constraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-10);
            make.left.equalTo(cancelBtn.mas_right).offset(20);
            make.right.mas_equalTo(-30);
            make.height.mas_equalTo(40);
        } touchUp:^(id sender) {
            if (weakObject.okBlock) {
                weakObject.okBlock();
            }
        }];
        
        OKBtn.backgroundColor = kWhiteColor;
        [OKBtn setTitleColor:kOrangeColor forState:(UIControlStateNormal)];
        OKBtn.layer.cornerRadius = 20;
        
       
    }
    return self;
}

@end
