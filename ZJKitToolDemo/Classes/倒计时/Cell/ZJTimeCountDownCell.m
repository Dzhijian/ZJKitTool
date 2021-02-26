//
//  ZJTimeCountDownCell.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/25.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJTimeCountDownCell.h"

@interface ZJTimeCountDownCell()

@end

@implementation ZJTimeCountDownCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllView];
    }
    return self;
}

// 添加所子控件
-(void)setUpAllView{
    self.titleLab = [UILabel new];
    self.titleLab.zj_chain.text(@"这是第一个倒计时").font([UIFont systemFontOfSize:16]).superView(self.contentView).makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
    });
    
    self.detailLab = [UILabel new];
    self.detailLab.zj_chain.text(@"还剩多少小时").font([UIFont systemFontOfSize:15]).textColor(kOrangeColor).superView(self.contentView).makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
        make.top.equalTo(_titleLab.mas_bottom).offset(10);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
    });
}



+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"ZJTimeCountDownCell";
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
