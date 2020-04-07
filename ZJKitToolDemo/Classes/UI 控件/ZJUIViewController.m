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
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 230, 200, 100)];
    [self.view addSubview:view];
//    view.clipsToBounds
    view.zj_chain.backgroundColor(kRedColor)
    .shadowRadius(6)
    .shadowOffset(CGSizeMake(3, 3))
    .shadowOpacity(0.7)
    .shadowColor(kBlackColor.CGColor)
    .borderColor(kOrangeColor.CGColor)
    .borderWidth(5)
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.bottom.mas_equalTo(-100);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.height.mas_equalTo(100);
    });
//    view.zj_chain.origin(CGPointMake(self.view.center.x, self.view.origin.y));
    [view setOrigin:CGPointMake(self.view.center.x, self.view.origin.y)];
//    [(UIView *)view setFrame:CGRectMake(0, 0, 0, 0)];
    
//    view.backgroundColor = kRedColor;
//    view.layer.shadowColor = kRedColor.CGColor;
//    view.layer.shadowOffset = CGSizeMake(1, 1);
//    view.layer.shadowRadius = 5;
//    view.layer.shadowOpacity = 0.6;
//    view.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:view.layer.cornerRadius].CGPath;
//    view.zj_chain
//    .frame(CGRectMake(100, 300, 200, 150))
//    .background_color(kGreenColor)
//    .border_color(kLightGrayColor)
//    .border_width(5)
//    .shadowColor(kRedColor.CGColor)
//    .shadowRadius(6)
//    .shadowOffset(CGSizeMake(3, 3))
//    .shadowOpacity(0.6);
    
    UILabel *label = [[UILabel alloc]init];
    [self.view addSubview:label];

    label.zj_chain
    .frame(CGRectMake(50, 500, 220, 30))
    .backgroundColor(kOrangeColor)
    .text(@"James is the champion")
    .font(kBoldFontWithSize(18))
    .textAlignment(NSTextAlignmentRight)
    .textColor(kWhiteColor).makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.bottom.equalTo(view.mas_top).offset(-30);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(40);
        NSLog(@"%@",sender);
    });
    
    UIButton *btn = [[UIButton alloc]init];
    [self.view addSubview:btn];
    btn.zj_chain.frame(CGRectMake(50, 400, 120, 35))
    .backgroundColor(kGreenColor)
    .title(@"ZJKittool", UIControlStateNormal);
    
    UIImageView *imageV = [[UIImageView alloc]init];
    [self.view addSubview:imageV];
    
    imageV.zj_chain.image([UIImage imageNamed:@"003"])
    .highlightedImage([UIImage imageNamed:@"004"])
    .highlighted(false)
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.bottom.equalTo(btn.mas_top).offset(-20);
        make.left.mas_equalTo(30);
        make.height.width.mas_equalTo(100);
    });

    UITextField *textField = [[UITextField alloc]init];
    [self.view addSubview:textField];
    textField.zj_chain.text(@"ZJKitTool")
    .backgroundColor(kRGB(250, 240, 250))
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.centerY.equalTo(btn.mas_centerY);
        make.left.equalTo(btn.mas_right).offset(20);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(40);
    }).borderStyle(UITextBorderStyleLine);
}

-(void)setCustomButtonImagePosition{
    
    UIButton *leftbtn = [[UIButton alloc]init];
    [leftbtn setTitle:@"图片在左" forState:(UIControlStateNormal)];
    [leftbtn setImage:kImageName(@"message_click") forState:(UIControlStateNormal)];
    leftbtn.titleLabel.font = kFontSize(14);
    [leftbtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
    [leftbtn setBackgroundColor:kLightGrayColor forState:(UIControlStateNormal)];
    leftbtn.layer.cornerRadius = 5;
    leftbtn.layer.masksToBounds = true;
    [self.view addSubview:leftbtn];
    [leftbtn  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(50);
        make.width.mas_offset(150);
    }];
    [leftbtn zj_setButtonImagePosition:(ZJButtonImagePositionLeft) spacing:10];

    
    UIButton *rightbtn = [[UIButton alloc]init];
    [rightbtn setTitle:@"图片在右" forState:(UIControlStateNormal)];
    [rightbtn setImage:kImageName(@"message_click") forState:(UIControlStateNormal)];
    rightbtn.titleLabel.font = kFontSize(14);
    [rightbtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
    [rightbtn setBackgroundColor:kLightGrayColor forState:(UIControlStateNormal)];
    rightbtn.layer.cornerRadius = 5;
    rightbtn.layer.masksToBounds = true;

    [self.view addSubview:rightbtn];
    [rightbtn  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(50);
        make.width.mas_offset(150);
    }];
    [rightbtn zj_setButtonImagePosition:(ZJButtonImagePositionRight) spacing:10];

    
    UIButton *topbtn = [[UIButton alloc]init];
    [topbtn setTitle:@"图片在上" forState:(UIControlStateNormal)];
    [topbtn setImage:kImageName(@"home_all") forState:(UIControlStateNormal)];
    topbtn.titleLabel.font = kFontSize(14);
    [topbtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
    [topbtn setBackgroundColor:kLightGrayColor forState:(UIControlStateNormal)];
    topbtn.layer.cornerRadius = 5;
    topbtn.layer.masksToBounds = true;

    [self.view addSubview:topbtn];
    [topbtn  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(100);
        make.width.mas_offset(150);
    }];
    
    [topbtn zj_setButtonImagePosition:(ZJButtonImagePositionTop) spacing:10];

    
    
    UIButton *botbtn = [[UIButton alloc]init];
    [botbtn setTitle:@"图片在下" forState:(UIControlStateNormal)];
    [botbtn setImage:kImageName(@"home_all") forState:(UIControlStateNormal)];
    botbtn.titleLabel.font = kFontSize(14);
    [botbtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
    [botbtn setBackgroundColor:kLightGrayColor forState:(UIControlStateNormal)];
    botbtn.layer.cornerRadius = 5;
    botbtn.layer.masksToBounds = true;

    [self.view addSubview:botbtn];
    [botbtn  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(100);
        make.width.mas_offset(150);
    }];
    [botbtn zj_setButtonImagePosition:(ZJButtonImagePositionBottom) spacing:10];
}

@end
