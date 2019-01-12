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
    
    self.popupView = [[ZJPopupView alloc]initWithShowView:_showView
                                                superView:self.view
                                                       viewSize:CGSizeMake(250, 300)
                                                       delegate:self
                                                   durationTime:0.25
                                                        bgAlpha:0.5
                                                isBGClickAction:YES
                                                   isBlurEffect:YES
                                                     animaStyle:style
                                                       closeBtn:closeBtn];
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
    UIButton *transBtn =  [UIButton zj_buttonWithTitle:@"弹窗 Transition" titleColor:kWhiteColor norImage:nil selectedImage:nil backColor:kOrangeColor fontSize:14 isBold:true cornerRadius:4 supView:self.view constraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(50);
    } touchUp:^(id sender) {
        [weakObject showViewWithStyle:(ZJPopupAnimationTransition)];
    }];
    
    UIButton *rotaBtn = [UIButton zj_buttonWithTitle:@"弹窗 Rotation" titleColor:kWhiteColor norImage:nil selectedImage:nil backColor:kOrangeColor fontSize:14 isBold:true cornerRadius:4 supView:self.view constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(transBtn.mas_bottom).offset(70);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(50);
    } touchUp:^(id sender) {
        [weakObject showViewWithStyle:(ZJPopupAnimationRotation)];
    }];
    
    UIButton *sacleBtn =[UIButton zj_buttonWithTitle:@"弹窗 Sacle" titleColor:kWhiteColor norImage:nil selectedImage:nil backColor:kOrangeColor fontSize:14 isBold:true cornerRadius:4 supView:self.view constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rotaBtn.mas_bottom).offset(70);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(50);
    } touchUp:^(id sender) {
        [weakObject showViewWithStyle:(ZJPopupAnimationSacle)];
    }];
    
    [UIButton zj_buttonWithTitle:@"弹窗 Alpha" titleColor:kWhiteColor norImage:nil selectedImage:nil backColor:kOrangeColor fontSize:14 isBold:true cornerRadius:4 supView:self.view constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sacleBtn.mas_bottom).offset(70);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(50);
    } touchUp:^(id sender) {
        [weakObject showViewWithStyle:(ZJPopupAnimationAlpha)];
    }];
}
@end
