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
    
    UILabel *lab1 = [UILabel zj_labelWithFontSize:14 text:@"点击右边选择按钮" superView: self.view constraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(35);
    }];
    
    [UIButton zj_buttonWithTitle:@"选择地区" titleColor:kLightGrayColor backColor:kWhiteColor fontSize:14 isBold:YES cornerRadius:4 supView:self.view constraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lab1.mas_centerY);
        make.left.equalTo(lab1.mas_right).offset(30);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(35);
    } touchUp:^(id sender) {
        [ZJAddressPickerView zj_showAddressPickerWithDefaultSelected:nil resuleBlock:^(ZJProvinceModel *province, ZJCityModel *city, ZJAreaModel *area) {
            lab1.text = [NSString stringWithFormat:@"%@-%@-%@",province.name,city.name,area.name];
        }];
    }];
    
    
    UILabel *lab2 = [UILabel zj_labelWithFontSize:14 text:@"点击右边选择按钮" superView: self.view constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab1.mas_bottom).offset(25);
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(35);
    }];
    
    
    [UIButton zj_buttonWithTitle:@"选择城市" titleColor:kLightGrayColor backColor:kWhiteColor fontSize:14 isBold:YES cornerRadius:4 supView:self.view constraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lab2.mas_centerY);
        make.left.equalTo(lab2.mas_right).offset(30);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(35);
    } touchUp:^(id sender) {
        
        [ZJAddressPickerView zj_showAddressPickerWithShowType:ZJAddressPickerModeCity dataSource:nil defaultSelected:nil isAutoSelect:YES lineColor:kOrangeColor selectRowTextColor:kRedColor selectRowBGColor:nil resultBlock:^(ZJProvinceModel *province, ZJCityModel *city, ZJAreaModel *area) {
            lab2.text = [NSString stringWithFormat:@"%@-%@-%@",province.name,city.name,area.name];
        } cancelBlock:^{
            
        }];
    }];
    
    UILabel *lab3 = [UILabel zj_labelWithFontSize:14 text:@"点击右边选择按钮" superView: self.view constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab2.mas_bottom).offset(25);
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(35);
    }];
    
    [UIButton zj_buttonWithTitle:@"选择地区自定义" titleColor:kLightGrayColor backColor:kWhiteColor fontSize:14 isBold:YES cornerRadius:4 supView:self.view constraints:^(MASConstraintMaker *make) {
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
