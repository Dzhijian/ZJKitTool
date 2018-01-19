//
//  ZJChooseViewOneLeftCell.m
//  ZJUIKit
//
//  Created by dzj on 2017/12/25.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import "ZJChooseViewOneLeftCell.h"



@implementation ZJChooseViewOneLeftCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllView];
    }
    return self;
}

// 添加所子控件
-(void)setUpAllView{
    
}

-+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"ZJChooseViewOneLeftCell";
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
