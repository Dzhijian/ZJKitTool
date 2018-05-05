//
//  ZJChooseViewOneLeftCell.h
//  ZJUIKit
//
//  Created by dzj on 2017/12/25.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJChooseViewOneLeftCell : UITableViewCell

@property(nonatomic ,strong) UILabel        *titleLab;
@property(nonatomic ,strong) UIImageView    *arrowImgV;

// oneView isSelected
@property(nonatomic ,assign) BOOL isSelected;

// threeView isSelected
@property(nonatomic ,assign) BOOL threeIsSelected;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
