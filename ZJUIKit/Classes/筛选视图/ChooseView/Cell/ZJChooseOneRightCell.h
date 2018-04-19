//
//  ZJChooseOneRightCell.h
//  ZJUIKit
//
//  Created by dzj on 2017/12/25.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJChooseOneRightCell : UITableViewCell

@property(nonatomic ,strong) UILabel        *titleLab;

@property(nonatomic ,strong) UILabel        *detailLab;

@property(nonatomic ,assign) BOOL isSelected;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
