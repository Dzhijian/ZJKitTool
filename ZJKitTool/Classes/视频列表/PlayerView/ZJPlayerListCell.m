//
//  ZJPlayerListCell.m
//  ZJUIKit
//
//  Created by dzj on 2018/2/27.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//
/**
 *  ZJUIKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJUIKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下,给个Star。😆
 */
#import "ZJPlayerListCell.h"
#define kVideoHeight kScreenWidth*9/16
@interface ZJPlayerListCell()

@property(nonatomic ,strong) UIImageView        *avatar;

@property(nonatomic ,strong) UILabel            *nameLab;
@property(nonatomic ,strong) UILabel            *timeLab;
@property(nonatomic ,strong) UILabel            *titleLab;
@property(nonatomic ,strong) UIButton           *playBtn;

@end

@implementation ZJPlayerListCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllView];
    }
    return self;
}

-(void)setModel:(ZJVideoModel *)model{
    [self.picImageV sd_setImageWithURL:[NSURL URLWithString:model.coverForFeed] placeholderImage:[UIImage imageNamed:@"loading_bgView"]];
    self.titleLab.text = model.title;

}

// 添加所子控件
-(void)setUpAllView{
    self.avatar = [UIImageView zj_imageViewWithImageName:@"001" SuperView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
        make.width.height.mas_equalTo(44);
    }];

    
    [self.avatar zj_cornerRadiusAdvance:22 rectCornerType:UIRectCornerAllCorners];
    
    self.nameLab = [UILabel zj_labelWithFontSize:13 text:@"ZJUIKit" superView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatar.mas_right).offset(10);
        make.right.mas_equalTo(-15);
        make.top.equalTo(_avatar.mas_top);
    }];
    
    self.timeLab = [UILabel zj_labelWithFontSize:13 lines:1 text:@"2018-08-08 08:08:08" textColor:kLightGrayColor superView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatar.mas_right).offset(10);
        make.right.mas_equalTo(-15);
        make.bottom.equalTo(_avatar.mas_bottom);
    }];
    
    self.titleLab = [UILabel zj_labelWithFontSize:15 lines:1 text:@"哈哈哈哈哈哈哈哈哈哈" textColor:kBlackColor superView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.equalTo(_avatar.mas_bottom).offset(10);
    }];
    
    self.picImageV = [UIImageView zj_imageViewWithImageName:@"loading_bgView" SuperView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(_titleLab.mas_bottom).offset(10);
        make.height.mas_equalTo(kVideoHeight);
    }];
    self.picImageV.userInteractionEnabled = YES;
    self.picImageV.contentMode = UIViewContentModeScaleAspectFill;
    self.picImageV.clipsToBounds = YES;
    
    // 设置imageView的tag，在PlayerView中取（建议设置100以上）
    self.picImageV.tag = 101;
    
    // 代码添加playerBtn到imageView上
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playBtn setImage:[UIImage imageNamed:@"new_live_paly"] forState:UIControlStateNormal];
    [self.playBtn addTarget:self action:@selector(playBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.picImageV addSubview:self.playBtn];
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.picImageV);
        make.width.height.mas_equalTo(50);
    }];
    
   
}

-(void)playBtnAction:(UIButton *)sender{
    if (self.playBtnBlock) {
        self.playBtnBlock(sender);
    }
}


+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"ZJPlayerListCell";
    
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
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
