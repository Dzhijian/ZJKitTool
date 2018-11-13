//
//  ZJPopupViewController.m
//  ZJKitTool
//
//  Created by James on 2018/11/13.
//  Copyright © 2018 kapokcloud. All rights reserved.
//

#import "ZJPopupViewController.h"
#import "ZJPopupView.h"

@interface ZJPopupViewController ()

@property (nonatomic, strong) ZJPopupView *popupView;

@end

@implementation ZJPopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kWeakObject(self);
    [UIButton zj_buttonWithTitle:@"弹窗" titleColor:kWhiteColor norImage:nil selectedImage:nil backColor:kOrangeColor fontSize:14 isBold:true cornerRadius:4 supView:self.view constraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(50);
    } touchUp:^(id sender) {
        [weakObject showView];
    }];
    
}

-(void)showView{
    
    ZJBasePopupView *view = [[ZJBasePopupView alloc]init];
    view.backgroundColor = kRedColor;
    
    ZJPopupView *popView = [[ZJPopupView alloc]initWithShowView:view viewSize:CGSizeMake(250, 300) style:(ZJPopupAnimationSacle)];
    
    [popView zj_showPopupView];
}

@end
