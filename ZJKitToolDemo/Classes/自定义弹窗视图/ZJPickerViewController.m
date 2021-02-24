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
    
    UIButton *btn = [[UIButton alloc]init];
    
    btn.zj_chain.title(@"选择地区", UIControlStateNormal).titleColor(kLightGrayColor, UIControlStateNormal).titleFont([UIFont boldSystemFontOfSize:14]).cornerRadius(4).superView(self.view).makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.centerY.equalTo(lab1.mas_centerY);
        make.left.equalTo(lab1.mas_right).offset(30);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(35);
    });
    
    btn.zj_onTouchUp = ^(id sender) {
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
    
    
    
    UILabel *lab4 = [UILabel zj_labelWithFontSize:14 text:@"点击右边选择时间" superView: self.view constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab3.mas_bottom).offset(25);
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(35);
    }];
    
    [UIButton zj_buttonWithTitle:@"选择时间" titleColor:kLightGrayColor backColor:kWhiteColor fontSize:14 isBold:YES cornerRadius:4 supView:self.view constraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lab4.mas_centerY);
        make.left.equalTo(lab4.mas_right).offset(30);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(35);
    } touchUp:^(id sender) {
        
        [ZJDatePickerView zj_showDatePickerWithTitle:@"请选择时间" dateType: ZJDatePickerModeMD defaultSelValue:nil resultBlock:^(NSString *selectValue) {
            lab4.text = [NSString stringWithFormat:@"%@",selectValue];
        }];
    }];
    
    
    UILabel *lab5 = [UILabel zj_labelWithFontSize:14 text:@"点击右边选择日期" superView: self.view constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab4.mas_bottom).offset(25);
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
        
        [ZJDatePickerView zj_showDatePickerWithTitle:@"请选择日期" dateType:ZJDatePickerModeYMDHM defaultSelValue:nil minDate:nil maxDate:nil isAutoSelect:YES lineColor:kOrangeColor rowHeight:40 resultBlock:^(NSString *selectValue) {
            NSLog(@"%@",selectValue);
            lab5.text = [NSString stringWithFormat:@"%@",selectValue];
        } cancelBlock:^{
            
        }];
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
        
        [ZJDatePickerView zj_showDatePickerWithTitle:@"请选择时间" dateType:ZJDatePickerModeMDHM defaultSelValue:nil minDate:nil maxDate:nil isAutoSelect:YES lineColor:kOrangeColor rowHeight:40 leftBtnTitleColor:kRedColor rightBtnTitleColor:kBlueColor selecteRowTextColor:kRGB(58, 99, 159) selectRowBGColor:kRGBA(170, 130, 55, 0.6) resultBlock:^(NSString *selectValue) {
            NSLog(@"%@",selectValue);
            lab6.text = [NSString stringWithFormat:@"%@",selectValue];
        } cancelBlock:^{
            
        }];
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
        
        [ZJNormalPickerView zj_showStringPickerWithTitle:@"请选择性别" dataSource:@[@"男",@"女",@"人妖",@"未知"] defaultSelValue:@"人妖" isAutoSelect: NO rowHeight:40 lineColor:kRedColor confirmBtnTitleColor:kGreenColor cancelBtnTitleColor:kPurpleColor selecteRowTextColor:kRGB(130, 60, 50) selectRowBGColor:kRGB(11, 12, 12) leftBtnTitle:@"haha" rightBtnTitle:@"hehe" resultBlock:^(id selectValue, NSInteger index) {
            NSLog(@"index---%ld",index);
        } cancelBlock:^{
            
        }];
        
    }];
    
    
    UILabel *lab8 = [UILabel zj_labelWithFontSize:14 text:@"点击右边选择日期" superView: self.view constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab7.mas_bottom).offset(25);
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(35);
    }];
    
    [UIButton zj_buttonWithTitle:@"选择日期" titleColor:kLightGrayColor backColor:kWhiteColor fontSize:14 isBold:YES cornerRadius:4 supView:self.view constraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lab8.mas_centerY);
        make.left.equalTo(lab8.mas_right).offset(30);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(35);
    } touchUp:^(id sender) {
        
        [ZJDatePickerView zj_showDatePickerWithTitle:@"Selected Date" dateType:(ZJDatePickerModeDate) defaultSelValue:nil language:@"zh-Hant" minDate:[NSDate date] maxDate:nil isAutoSelect:true isShowChinese:false lineColor:kLightGrayColor rowHeight:40 leftBtnTitleColor:kLightGrayColor rightBtnTitleColor:kRedColor selecteRowTextColor:nil selectRowBGColor:nil leftTitle:@"Cancel" rightTitle:@"Done" resultBlock:^(NSString *selectValue) {
            NSLog(@"%@",selectValue);
            NSDate *date = [NSDate dateWithString:selectValue format:@"yyyy-MM-dd"];
            NSString *str = [NSDate dateToString:date format:@"dd/MM/yyyy"];
            NSLog(@"%@",str);
        } cancelBlock:^{
            
        }];
    }];
    
}


-(void)setUpNormalView{
    
    UILabel *lab1 = [UILabel zj_labelWithFontSize:14 text:@"点击右边选择性别" superView: self.view constraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(35);
    }];
    
    [UIButton zj_buttonWithTitle:@"选择性别" titleColor:kLightGrayColor backColor:kWhiteColor fontSize:14 isBold:YES cornerRadius:4 supView:self.view constraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lab1.mas_centerY);
        make.left.equalTo(lab1.mas_right).offset(30);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(35);
    } touchUp:^(id sender) {
        
        [ZJNormalPickerView zj_showStringPickerWithTitle:@"请选择性别" dataSource:@[@"男",@"女",@"未知"] defaultSelValue:@"未知" isAutoSelect: NO resultBlock:^(id selectValue, NSInteger index) {
            lab1.text = selectValue;
            
            NSLog(@"index---%ld",index);
        } cancelBlock:^{
            
        }];
    }];
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
