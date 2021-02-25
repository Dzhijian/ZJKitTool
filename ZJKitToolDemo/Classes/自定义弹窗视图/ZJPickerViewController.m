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
    lab1.zj_chain.text(@"12314");
    
    UIButton *btn = [[UIButton alloc]init];
    
    btn.zj_chain.title(@"选择地区", UIControlStateNormal).titleColor(kLightGrayColor, UIControlStateNormal).titleFont([UIFont boldSystemFontOfSize:14]).cornerRadius(4).superView(self.view).makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.centerY.equalTo(lab1.mas_centerY);
        make.left.equalTo(lab1.mas_right).offset(30);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(35);
    });
    
    btn.zj_onTouchUp = ^(id sender) {
        
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
    };
    
    
    UILabel *lab3 = [UILabel zj_labelWithFontSize:14 text:@"点击右边选择地区" superView: self.view constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab1.mas_bottom).offset(25);
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(35);
    }];
    
    [UIButton zj_buttonWithTitle:@"选择地区自定义" titleColor:kLightGrayColor
                       backColor:kWhiteColor fontSize:14 isBold:YES cornerRadius:4
                         supView:self.view constraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lab3.mas_centerY);
        make.left.equalTo(lab3.mas_right).offset(30);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(35);
    } touchUp:^(id sender) {
        // 地区选择弹窗,不推荐用这种形式创建
        [ZJAddressPickerView zj_showAddressPickerWithShowType:ZJAddressPickerModeArea
                                                   dataSource:nil
                                              defaultSelected:nil
                                                 isAutoSelect:YES
                                                    lineColor:[UIColor redColor]
                                           selectRowTextColor:[UIColor orangeColor]
                                             selectRowBGColor:kRGBColor(230, 230, 230)
                                         confirmBtnTitleColor:kRGBColor(116, 80, 200)
                                          cancelBtnTitleColor:kRGBColor(116, 80, 200)
                                                    rowHeight:50.0
                                                  resultBlock:^(ZJProvinceModel *province, ZJCityModel *city, ZJAreaModel *area) {
                                                      lab3.text = [NSString stringWithFormat:@"%@-%@-%@",province.name,city.name,area.name];
                                                  } cancelBlock:^{
                                                      
                                                  }];
    }];

    
    UILabel *lab5 = [UILabel zj_labelWithFontSize:14 text:@"点击右边选择日期" superView: self.view constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab3.mas_bottom).offset(25);
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(35);
    }];
    
    [UIButton zj_buttonWithTitle:@"选择日期" titleColor:kLightGrayColor backColor:kWhiteColor fontSize:14 isBold:YES cornerRadius:4 supView:self.view constraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lab5.mas_centerY);
        make.left.equalTo(lab5.mas_right).offset(30);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(35);
    } touchUp:^(id sender) {
        
        ZJDatePickerView *date = [[ZJDatePickerView alloc]initWithPickerMode:(ZJDatePickerModeDate)];
        date.title = @"选择时间";
        date.minLimitDate = [NSDate dateWithString:@"1990-01-02 12:12:00" format:@"yyyy-MM-dd hh:mm:ss"];
        date.maxLimitDate = [NSDate dateWithString:@"2050-12-12 12:12:00" format:@"yyyy-MM-dd hh:mm:ss"];
        [date showView];
        date.resultBlock = ^(NSString * _Nonnull selectValue) {
            lab5.text = [NSString stringWithFormat:@"%@",selectValue];
        };

    }];
    
    UILabel *lab6 = [UILabel zj_labelWithFontSize:14 text:@"点击右边选择时间" superView: self.view constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab5.mas_bottom).offset(25);
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(35);
    }];
    
    [UIButton zj_buttonWithTitle:@"选择时间" titleColor:kLightGrayColor backColor:kWhiteColor fontSize:14 isBold:YES cornerRadius:4 supView:self.view constraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lab6.mas_centerY);
        make.left.equalTo(lab6.mas_right).offset(30);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(35);
    } touchUp:^(id sender) {
        
    }];
    
    
    UILabel *lab7 = [UILabel zj_labelWithFontSize:14 text:@"点击右边选择性别" superView: self.view constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab6.mas_bottom).offset(25);
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(35);
    }];
    
    [UIButton zj_buttonWithTitle:@"选择性别" titleColor:kLightGrayColor backColor:kWhiteColor fontSize:14 isBold:YES cornerRadius:4 supView:self.view constraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lab7.mas_centerY);
        make.left.equalTo(lab7.mas_right).offset(30);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(35);
    } touchUp:^(id sender) {
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
        
    }];
    
    UIView *testView = [UIView new];
    testView.zj_chain.superView(self.view).backgroundColor([UIColor orangeColor]).makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.top.equalTo(lab7.mas_bottom).offset(50);
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
