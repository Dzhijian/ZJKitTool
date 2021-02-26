//
//  ZJPickerViewController.m
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/6/27.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJPickerViewController.h"
#import "ZJPickBaseView.h"
#import "ZJAddressPickerView.h"

@interface ZJPickerViewController ()

@end

@implementation ZJPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self setUpAllView];
    
}


-(void)setUpAllView{
    UILabel *lab1 = [[UILabel alloc]init];
    lab1.zj_chain.superView(self.view).text(@"点击右边选择地区").font([UIFont systemFontOfSize:14]).makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(35);
    });
    
    UIButton *btn1 = [[UIButton alloc]init];
    btn1.zj_chain.title(@"选择地区", UIControlStateNormal).titleColor(kLightGrayColor, UIControlStateNormal).titleFont([UIFont boldSystemFontOfSize:14]).cornerRadius(4).superView(self.view).makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.centerY.equalTo(lab1.mas_centerY);
        make.left.equalTo(lab1.mas_right).offset(30);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(35);
    }).onTouchUp(^(id  _Nonnull sender) {
        // 地区选择弹窗,推荐用这种形式创建
        ZJAddressPickerView *address = [[ZJAddressPickerView alloc]initWithPickerMode:(ZJAddressPickerModeArea)];
        address.leftBtnTitleColor = [UIColor orangeColor];
        address.rightBtnTitleColor = [UIColor purpleColor];
        address.selectRowBGColor = [UIColor lightGrayColor];
        address.selecteRowTextColor = [UIColor orangeColor];
        address.isAutoSelect = true;
        address.rowHeight = 40;
        [address showPickerViewWithAnimation:true];
        address.resultBlock = ^(ZJProvinceModel *province, ZJCityModel *city, ZJAreaModel *area) {
            lab1.text = [NSString stringWithFormat:@"%@-%@-%@",province.name,city.name,area.name];
            
        };
    });
    
    UILabel *lab2 = [[UILabel alloc]init];
    lab2.zj_chain.superView(self.view)
    .text(@"点击右边选择地区")
    .font([UIFont systemFontOfSize:14])
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.top.equalTo(lab1.mas_bottom).offset(25);
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(35);
    });
    
    UIButton *btn2 = [[UIButton alloc]init];
    btn2.zj_chain.title(@"选择地区自定义", UIControlStateNormal).titleColor(kLightGrayColor, UIControlStateNormal).titleFont([UIFont boldSystemFontOfSize:14]).cornerRadius(4).superView(self.view).makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.centerY.equalTo(lab2.mas_centerY);
        make.left.equalTo(lab2.mas_right).offset(30);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(35);
    }).onTouchUp(^(id  _Nonnull sender) {
        // 地区选择弹窗,推荐用这种形式创建
        ZJAddressPickerView *address = [[ZJAddressPickerView alloc]initWithPickerMode:(ZJAddressPickerModeProvince)];
        address.leftBtnTitleColor = [UIColor orangeColor];
        address.rightBtnTitleColor = [UIColor purpleColor];
        address.selectRowBGColor = [UIColor lightGrayColor];
        address.selecteRowTextColor = [UIColor orangeColor];
        address.isAutoSelect = true;
        address.rowHeight = 40;
        [address showPickerViewWithAnimation:true];
        address.resultBlock = ^(ZJProvinceModel *province, ZJCityModel *city, ZJAreaModel *area) {
            lab2.text = [NSString stringWithFormat:@"%@-%@-%@",province.name,city.name,area.name];
        };
    });

    UILabel *lab3 = [[UILabel alloc]init];
    lab3.zj_chain.superView(self.view)
    .text(@"点击右边选择日期")
    .font([UIFont systemFontOfSize:14])
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.top.equalTo(lab2.mas_bottom).offset(25);
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(35);
    });
    
    UIButton *btn3 = [[UIButton alloc]init];
    btn3.zj_chain.title(@"选择日期", UIControlStateNormal).titleColor(kLightGrayColor, UIControlStateNormal).titleFont([UIFont boldSystemFontOfSize:14]).cornerRadius(4).superView(self.view).makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.centerY.equalTo(lab3.mas_centerY);
        make.left.equalTo(lab3.mas_right).offset(30);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(35);
    }).onTouchUp(^(id  _Nonnull sender) {
        ZJDatePickerView *date = [[ZJDatePickerView alloc]initWithPickerMode:(ZJDatePickerModeDate)];
        date.title = @"选择日期";
        date.minLimitDate = [NSDate dateWithString:@"1990-01-02 12:12:00" format:@"yyyy-MM-dd hh:mm:ss"];
        date.maxLimitDate = [NSDate dateWithString:@"2050-12-12 18:12:00" format:@"yyyy-MM-dd hh:mm:ss"];
        [date showView];
        date.resultBlock = ^(NSString * _Nonnull selectValue) {
            lab3.text = [NSString stringWithFormat:@"%@",selectValue];
        };
    });

    UILabel *lab4 = [[UILabel alloc]init];
    lab4.zj_chain.superView(self.view)
    .text(@"点击右边选择时间")
    .font([UIFont systemFontOfSize:14])
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.top.equalTo(lab3.mas_bottom).offset(25);
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(35);
    });
    
    UIButton *btn4 = [[UIButton alloc]init];
    btn4.zj_chain.title(@"选择时间", UIControlStateNormal).titleColor(kLightGrayColor, UIControlStateNormal).titleFont([UIFont boldSystemFontOfSize:14]).cornerRadius(4).superView(self.view).makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.centerY.equalTo(lab4.mas_centerY);
        make.left.equalTo(lab4.mas_right).offset(30);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(35);
    }).onTouchUp(^(id  _Nonnull sender) {
        ZJDatePickerView *date = [[ZJDatePickerView alloc]initWithPickerMode:(ZJDatePickerModeHM)];
        date.title = @"请选择时间";
        date.minLimitDate = [NSDate dateWithString:@"1990-01-02 12:12:00" format:@"yyyy-MM-dd hh:mm:ss"];
        date.maxLimitDate = [NSDate dateWithString:@"2050-12-12 18:12:00" format:@"yyyy-MM-dd hh:mm:ss"];
        [date showView];
        date.resultBlock = ^(NSString * _Nonnull selectValue) {
            lab4.text = [NSString stringWithFormat:@"%@",selectValue];
        };
    });
    
    UILabel *lab5 = [[UILabel alloc]init];
    lab5.zj_chain.superView(self.view)
    .text(@"点击右边选择性别")
    .font([UIFont systemFontOfSize:14])
    .makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.top.equalTo(lab4.mas_bottom).offset(25);
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(35);
    });
    
    UIButton *btn5 = [[UIButton alloc]init];
    btn5.zj_chain.title(@"选择性别", UIControlStateNormal).titleColor(kLightGrayColor, UIControlStateNormal).titleFont([UIFont boldSystemFontOfSize:14]).cornerRadius(4).superView(self.view).makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.centerY.equalTo(lab5.mas_centerY);
        make.left.equalTo(lab5.mas_right).offset(30);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(35);
    }).onTouchUp(^(id  _Nonnull sender) {
        ZJNormalPickerView *custom = [[ZJNormalPickerView alloc]init];
        custom.title = @"请选择性别";
        custom.defaultValue = @"女";
        custom.dataSource = @[@"男",@"女",@"未知"];
        custom.rowHeight = 40;
        custom.rightBtnTitleColor = [UIColor orangeColor];
        custom.leftBtnTitleColor = [UIColor blueColor];
        [custom showView];
        
        custom.resultBlock = ^(id selectValue, NSInteger index) {
            NSLog(@"selectValue---%@,  index---%ld",selectValue,index);
        };
    });
    
    
    UIView *testView = [UIView new];
    testView.zj_chain.superView(self.view).backgroundColor([UIColor orangeColor]).makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.top.equalTo(lab5.mas_bottom).offset(50);
        make.left.mas_equalTo(100);
        make.width.height.mas_equalTo(100);
    }).onTap(^(UITapGestureRecognizer *gesture){
        NSLog(@"11111");
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
