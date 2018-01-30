//
//  ZJBaseTableViewCell.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/24.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJBaseTableViewCell.h"

@implementation ZJBaseTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpAllView];
    }
    return self;
}

// 添加所子控件
-(void)setUpAllView{
    
}


+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"ZJBaseTableViewCell";
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
