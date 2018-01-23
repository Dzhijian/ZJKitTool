//
//  ZJChooseOneRightCell.m
//  ZJUIKit
//
//  Created by dzj on 2017/12/25.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import "ZJChooseOneRightCell.h"

@implementation ZJChooseOneRightCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllView];
    }
    return self;
}


-(void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    if (isSelected) {
        self.titleLab.font = kBoldFontWithSize(14);
        self.titleLab.textColor = kOrangeColor;
    }else{
        self.titleLab.font = kFontWithSize(14);
        self.titleLab.textColor = kLightGrayColor;
    }
}


// 添加所子控件
-(void)setUpAllView{
    self.titleLab = [[UILabel alloc]init];
    _titleLab.font = kFontWithSize(14);
    _titleLab.textColor = kBlackColor;
    [self.contentView addSubview:self.titleLab];
    
    
    self.detailLab = [[UILabel alloc]init];
    _detailLab.font = kFontWithSize(13);
    _detailLab.textColor = kLightGrayColor;
    [self.contentView addSubview:self.detailLab];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.right.mas_lessThanOrEqualTo(-30);
    }];
    
    [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleLab.mas_centerY);
        make.left.equalTo(_titleLab.mas_right).offset(2);
        make.right.mas_equalTo(-10);
    }];
    
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"ZJChooseOneRightCell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
