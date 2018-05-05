//
//  ZJTimeCountDownCell.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/25.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJTimeCountDownCell : UITableViewCell

@property(nonatomic ,strong) UILabel *titleLab;

@property(nonatomic ,strong) UILabel *detailLab;

//重用cell
+(instancetype)cellWithTableView:(UITableView *)tableView;



@end
