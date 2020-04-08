//
//  ZJUIViewController.m
//  ZJKitTool
//
//  Created by 邓志坚 on 2020/3/22.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJUIViewController.h"
#import "ZJChainHelper.h"



@interface ZJUIViewController ()

@end

@implementation ZJUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"UI 控件";
        
    [self setUpAllChildView];
}

#pragma mark - 添加所有子控件
-(void)setUpAllChildView{
    
    [self setCustomButtonImagePosition];
    
    [self setUpCustomView];
    
}

-(void)setUpCustomView{
    
    UIView *view = [[UIView alloc]init];
    view.zj_chain.backgroundColor(kRedColor)
    .shadowRadius(6)
    .shadowOffset(CGSizeMake(3, 3))
    .shadowOpacity(0.7)
    .shadowColor(kBlackColor.CGColor)
    .borderColor(kOrangeColor.CGColor)
    .borderWidth(5)
    .superView(self.view)
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.bottom.mas_equalTo(-100);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.height.mas_equalTo(100);
    });

    
    UILabel *label = [[UILabel alloc]init];
    label.zj_chain
    .frame(CGRectMake(50, 500, 220, 30))
    .backgroundColor(kOrangeColor)
    .text(@"James is the champion")
    .font(kBoldFontWithSize(18))
    .textAlignment(NSTextAlignmentRight)
    .superView(self.view)
    .textColor(kWhiteColor).makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.bottom.equalTo(view.mas_top).offset(-30);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(40);
        NSLog(@"%@",sender);
    });

    
    UIImageView *imageV = [[UIImageView alloc]init];
    imageV.zj_chain.image([UIImage imageNamed:@"003"])
    .highlightedImage([UIImage imageNamed:@"004"])
    .highlighted(false)
    .superView(self.view)
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.top.mas_equalTo(200);
        make.left.mas_equalTo(20);
        make.height.width.mas_equalTo(120);
    });

    UITextField *textField = [[UITextField alloc]init];
    textField.zj_chain.text(@"ZJKitTool")
    .backgroundColor(kRGB(250, 240, 250))
    .superView(self.view)
    .borderStyle(UITextBorderStyleLine)
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.centerY.equalTo(imageV.mas_centerY);
        make.left.equalTo(imageV.mas_right).offset(20);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(40);
    });
    
    UISwitch *swi = [[UISwitch alloc]init];
    swi.zj_chain.on(true)
    .superView(self.view)
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.top.equalTo(imageV.mas_bottom).offset(20);
        make.left.mas_equalTo(50);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(35);
    });
}

-(void)setCustomButtonImagePosition{
    
    UIButton *leftbtn = [[UIButton alloc]init];
    leftbtn.zj_chain.title(@"图片在左", UIControlStateNormal)
    .image(kImageName(@"message_click"), UIControlStateNormal)
    .titleFont(kFontSize(14))
    .backgroundColorState(kLightGrayColor, UIControlStateNormal)
    .masksToBounds(true)
    .cornerRadius(5)
    .superView(self.view)
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(50);
        make.width.mas_offset(150);
    });

    [leftbtn zj_setButtonImagePosition:(ZJButtonImagePositionLeft) spacing:10];

    
    UIButton *rightbtn = [[UIButton alloc]init];
    rightbtn.zj_chain.title(@"图片在右", UIControlStateNormal)
    .image(kImageName(@"message_click"), UIControlStateNormal)
    .titleFont(kFontSize(14))
    .backgroundColorState(kLightGrayColor, UIControlStateNormal)
    .masksToBounds(true)
    .cornerRadius(5)
    .superView(self.view)
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
       make.top.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(50);
        make.width.mas_offset(150);
    });

    [rightbtn zj_setButtonImagePosition:(ZJButtonImagePositionRight) spacing:10];

    
    UIButton *topbtn = [[UIButton alloc]init];
    topbtn.zj_chain.title(@"图片在上", UIControlStateNormal)
    .image(kImageName(@"home_all"), UIControlStateNormal)
    .titleFont(kFontSize(14))
    .backgroundColorState(kLightGrayColor, UIControlStateNormal)
    .masksToBounds(true)
    .cornerRadius(5)
    .superView(self.view)
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.top.mas_equalTo(80);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(100);
        make.width.mas_offset(150);
    });
    [topbtn zj_setButtonImagePosition:(ZJButtonImagePositionTop) spacing:10];

    
    
    UIButton *botbtn = [[UIButton alloc]init];
    botbtn.zj_chain.title(@"图片在下", UIControlStateNormal)
    .image(kImageName(@"home_all"), UIControlStateNormal)
    .backgroundColorState(kLightGrayColor, UIControlStateNormal)
    .titleFont(kFontSize(14))
    .masksToBounds(true)
    .cornerRadius(5)
    .superView(self.view)
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.top.mas_equalTo(80);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(100);
        make.width.mas_offset(150);
    });
    [botbtn zj_setButtonImagePosition:(ZJButtonImagePositionBottom) spacing:10];
}

@end
