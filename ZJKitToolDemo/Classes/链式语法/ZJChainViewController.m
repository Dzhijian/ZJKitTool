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
    self.title = @"链式语法";
    
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
    .image([UIImage imageNamed:@"005"])
    .onTap(^(UITapGestureRecognizer *gesture) {
        NSLog(@"点击了 UIImageView");
    })
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.top.equalTo(label.mas_bottom).offset(20);
        make.left.mas_equalTo(40);
        make.width.height.mas_equalTo(80);
    });
    
    UITextField *textField = [[UITextField alloc]init];
    textField.zj_chain.superView(self.view)
    .font([UIFont systemFontOfSize:15])
    .textColor([UIColor orangeColor])
    .borderStyle(UITextBorderStyleRoundedRect)
    .placeholder(@"这是一个 UITextField")
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.top.equalTo(imageView.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    });
    
    UITextView *textView = [[UITextView alloc]init];
    textView.zj_chain.superView(self.view)
    .textColor([UIColor grayColor])
    .font([UIFont systemFontOfSize:15])
    .borderColor([UIColor blackColor].CGColor)
    .borderWidth(1)
    .placeholder(@"这是一个 UITextView")
    .placeholderColor([UIColor redColor])
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.top.equalTo(textField.mas_bottom).offset(20);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(90);
    });
    
    UIButton *btn  = [[UIButton alloc]init];
    btn.zj_chain.superView(self.view)
    .title(@"返回上一页", UIControlStateNormal)
    .titleColor([UIColor whiteColor], UIControlStateNormal)
    .titleFont([UIFont boldSystemFontOfSize:16])
    .backgroundColor([UIColor systemTealColor])
    .cornerRadius(6)
    .onTouchUp(^(id  _Nonnull sender) {
        [self.navigationController popViewControllerAnimated:true];
    })
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.top.equalTo(textView.mas_bottom).offset(20);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(50);
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
