//
//  ZJPopupViewController.m
//  ZJKitTool
//
//  Created by James on 2018/11/13.
//  Copyright © 2018 kapokcloud. All rights reserved.
//

#import "ZJPopupViewController.h"
#import "ZJPopupView.h"

@interface ZJPopupViewController ()<ZJPopupViewDelegate>


@property (nonatomic, strong) ZJPopupView *popupView;

@end

@implementation ZJPopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ZJPopupView";

    [self setUpAllView];
    
}

-(void)showViewWithStyle:(ZJPopupAnimationStyle)style{
    
    ZJBasePopupView *view = [[ZJBasePopupView alloc]init];
    view.backgroundColor = kRedColor;
    
    UILabel *lab = [UILabel zj_labelWithFont:kBoldFontWithSize(15) lines:1 text:@"ZJPopupView" textColor:kWhiteColor superView:view constraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    lab.backgroundColor = kClearColor;
    lab.textAlignment = NSTextAlignmentCenter;
    
    ZJPopupView *popView = [[ZJPopupView alloc]initWithShowView:view
                                                       viewSize:CGSizeMake(250, 300)
                                                       delegate:self
                                                   durationTime:0.25
                                                        bgAlpha:0.5
                                                isBGClickAction:YES
                                                          style:style
                                                       closeBtn:nil];
    [popView zj_showPopupView];
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
