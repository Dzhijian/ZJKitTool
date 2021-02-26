//
//  ZJChainViewController.m
//  ZJKitTool
//
//  Created by 邓志坚 on 2020/3/16.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJChainViewController.h"


@interface ZJChainViewController ()

@end

@implementation ZJChainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc]init];
    view.zj_chain.superView(self.view)
    .backgroundColor([UIColor systemYellowColor])
    .borderColor([UIColor orangeColor].CGColor)
    .borderWidth(5)
    .cornerRadius(5)
    .onTap(^(UITapGestureRecognizer *gesture) {
        NSLog(@"点击 UIView");
    })
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(80);
    });
    
    UILabel *label = [[UILabel alloc]init];
    label.zj_chain.text(@"这是一个 UILabel \n设置行间距 rowSpace 为 5")
    .font([UIFont boldSystemFontOfSize:16])
    .superView(self.view)
    .textColor([UIColor blueColor])
    .backgroundColor([UIColor lightGrayColor])
    .textAlignment(NSTextAlignmentCenter)
    .numberOfLines(2)
    .columnSpace(5)
    .rowSpace(5)
    .onTap(^(UITapGestureRecognizer *gesture) {
        NSLog(@"点击了 UILabel");
    })
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.top.equalTo(view.mas_bottom).offset(20);
        make.left.mas_equalTo(40);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(50);
    });
    
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.zj_chain.superView(self.view)
    .cornerRadius(10)
    .image([UIImage imageNamed:@"006"])
    .onTap(^(UITapGestureRecognizer *gesture) {
        NSLog(@"点击了 UIImageView");
    })
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.top.equalTo(label.mas_bottom).offset(20);
        make.left.mas_equalTo(40);
        make.width.height.mas_equalTo(80);
    });
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
