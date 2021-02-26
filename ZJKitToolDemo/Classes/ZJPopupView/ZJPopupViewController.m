//
//  ZJPopupViewController.m
//  ZJKitTool
//
//  Created by James on 2018/11/13.
//  Copyright © 2018 kapokcloud. All rights reserved.
//

#import "ZJPopupViewController.h"
#import "ZJPopupView.h"
#import "ZJPopShowView.h"

@interface ZJPopupViewController ()<ZJPopupViewDelegate>


@property (nonatomic, strong) ZJPopupView *popupView;

@property (nonatomic, strong) ZJPopShowView *showView;
@end

@implementation ZJPopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ZJPopupView";

    [self setUpAllView];
    
}

-(void)showViewWithStyle:(ZJPopupAnimationStyle)style{
    
    self.showView = [[ZJPopShowView alloc]initWithFrame:CGRectMake(0, 0, 250, 300)];
    _showView.layer.cornerRadius = 10;
    _showView.layer.masksToBounds = YES;
    
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [closeBtn setImage:kImageName(@"close") forState:(UIControlStateNormal)];
    [closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    // 新的创建方式
    self.popupView = [[ZJPopupView alloc]init];
    self.popupView.delegate = self;
    self.popupView.durationTime = 0.25;
    self.popupView.backgroundAlpha = 0.5;
    self.popupView.backgroundIsClick = true;
    self.popupView.isBlurEffect = false;
    self.popupView.animationStyle = style;
    self.popupView.closeBtn = closeBtn;
    self.popupView.superView = self.view;
    self.popupView.showView = self.showView;
    [self.popupView zj_showPopupView];
    
    kWeakObject(self);
    self.showView.okBlock = ^{
        [weakObject closeBtnAction];
    };
}

-(void)closeBtnAction{
    [self.popupView zj_hiddenPopupView];
}

-(void)zj_willShowPopupView{
    NSLog(@"将要显示 popView");
}
-(void)zj_didHiddenPopupView{
    NSLog(@"已经隐藏 popView");
}
-(void)zj_clickShowViewAction{
    NSLog(@"点击了 showView");
}

-(void)zj_clickBgViewAction{
    NSLog(@"点击了 bgView");
}

-(void)setUpAllView{
    kWeakObject(self);
    
    UIButton *transBtn =  [UIButton new];
    transBtn.zj_chain
    .title(@"弹窗 Transition", UIControlStateNormal)
    .titleColor(kWhiteColor, UIControlStateNormal)
    .backgroundColor(kOrangeColor)
    .titleFont([UIFont boldSystemFontOfSize:14])
    .superView(self.view)
    .onTouchUp(^(id  _Nonnull sender) {
        [weakObject showViewWithStyle:(ZJPopupAnimationTransition)];
    })
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.top.mas_equalTo(80);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(50);
    });
    
    UIButton *rotaBtn =  [UIButton new];
    rotaBtn.zj_chain
    .title(@"弹窗 Rotation", UIControlStateNormal)
    .titleColor(kWhiteColor, UIControlStateNormal)
    .backgroundColor(kOrangeColor)
    .titleFont([UIFont boldSystemFontOfSize:14])
    .superView(self.view)
    .onTouchUp(^(id  _Nonnull sender) {
        [weakObject showViewWithStyle:(ZJPopupAnimationRotation)];
    })
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.top.equalTo(transBtn.mas_bottom).offset(70);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(50);
    });
    
    UIButton *sacleBtn =  [UIButton new];
    sacleBtn.zj_chain
    .title(@"弹窗 Sacle", UIControlStateNormal)
    .titleColor(kWhiteColor, UIControlStateNormal)
    .backgroundColor(kOrangeColor)
    .titleFont([UIFont boldSystemFontOfSize:14])
    .superView(self.view)
    .onTouchUp(^(id  _Nonnull sender) {
        [weakObject showViewWithStyle:(ZJPopupAnimationSacle)];
    })
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.top.equalTo(rotaBtn.mas_bottom).offset(70);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(50);
    });
    
    UIButton *alphaBtn =  [UIButton new];
    alphaBtn.zj_chain
    .title(@"弹窗 Alpha", UIControlStateNormal)
    .titleColor(kWhiteColor, UIControlStateNormal)
    .backgroundColor(kOrangeColor)
    .titleFont([UIFont boldSystemFontOfSize:14])
    .superView(self.view)
    .onTouchUp(^(id  _Nonnull sender) {
        [weakObject showViewWithStyle:(ZJPopupAnimationAlpha)];
    })
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.top.equalTo(sacleBtn.mas_bottom).offset(70);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(50);
    });
    

}
@end
