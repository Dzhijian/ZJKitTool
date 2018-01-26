//
//  ZJMasonryAutolayoutCell.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/26.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJMasonryAutolayoutCell.h"
#import "ZJCommit.h"
#import "ZJCommitPhotoView.h"


@interface ZJMasonryAutolayoutCell()
// 昵称
@property(nonatomic ,strong) UILabel        *nameLab;
// 头像
@property(nonatomic ,strong) UIImageView    *avatar;
// 时间
@property(nonatomic ,strong) UILabel        *timeLab;
// 内容
@property(nonatomic ,strong) UILabel        *contentLab;
// 图片
@property(nonatomic ,strong) ZJCommitPhotoView *photosView;
// 分割线
@property(nonatomic ,strong) UIView         *line;

@end

@implementation ZJMasonryAutolayoutCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllView];
    }
    return self;
}


-(void)setModel:(ZJCommit *)model{
    _model = model;
    
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:model.avatar]];

    self.nameLab.text = model.nickname;
    NSInteger time = [model.add_time integerValue];
    self.timeLab.text = [NSDate dateWithTimeInterval:time format:@"MM月dd日"];
    self.contentLab.text = model.content;
    
    NSInteger count = model.pic_urls.count;
   
    if (count > 0 ) {
        _photosView.pic_urls = model.pic_urls;
        
        // 有图片重新更新约束
        CGFloat oneheight = (kScreenWidth - _nameLab.zj_originX - 15 -20)/3;
        // 三目运算符 小于或等于3张 显示一行的高度 ,大于3张小于或等于6行，显示2行的高度 ，大于6行，显示3行的高度
        CGFloat photoHeight = count<=3 ? oneheight : (count<=6 ? 2*oneheight+10 : oneheight *3+20);

        [_photosView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentLab.mas_bottom).offset(10);
            make.left.equalTo(_nameLab.mas_left);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(photoHeight);
            make.bottom.mas_equalTo(-15);
        }];
        [_line mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
            make.bottom.mas_equalTo(0); // 这句很重要！！！
        }];
        _photosView.hidden = NO;
    }else{
        [_photosView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentLab.mas_bottom).offset(10);
            make.left.equalTo(_nameLab.mas_left);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(0.001);
        }];
        [_line mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_photosView.mas_bottom).offset(0);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
            make.bottom.mas_equalTo(0); // 这句很重要！！！
        }];
    
        _photosView.hidden = YES;
    }
    
}

// 添加所子控件
-(void)setUpAllView{
    // 头像
    self.avatar = [UIImageView zj_imageViewWithImageName:@"" SuperView:self.contentView contentMode:UIViewContentModeScaleAspectFill isClip:YES constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.width.height.mas_equalTo(40);
    }];
    
    
    
    // 昵称
    self.nameLab = [UILabel zj_labelWithFont:15 textColor:kBlackColor superView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_avatar.mas_centerY);
        make.left.equalTo(_avatar.mas_right).offset(15);
        make.right.mas_equalTo(-100);
        make.height.mas_equalTo(20);
    }];
    // 时间
    self.timeLab = [UILabel zj_labelWithFont:12 textColor:kLightGrayColor superView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_avatar.mas_centerY);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
        
    }];
    self.timeLab.textAlignment = NSTextAlignmentRight;
    
    // 内容
    self.contentLab = [UILabel zj_labelWithFont:14 lines:0 text:nil textColor:kBlackColor superView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_avatar.mas_bottom).offset(10);
        make.left.equalTo(_nameLab.mas_left);
        make.right.mas_equalTo(-15);
        make.height.mas_lessThanOrEqualTo(16);
    }];
    
    // 图片
    self.photosView = [[ZJCommitPhotoView alloc]init];
    [self.contentView addSubview:self.photosView];
    [_photosView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentLab.mas_bottom).offset(10);
        make.left.equalTo(_nameLab.mas_left);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(0.001);
    }];
    
#warning 注意  不管你的布局是怎样的 ，一定要有一个(最好是最底部的控件)相对 contentView.bottom的约束，否则计算cell的高度的时候会不正确！
    self.line = [UIView zj_viewWithBackColor:kLightGrayColor supView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_photosView.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
        make.bottom.mas_equalTo(0); // 这句很重要！！！
        
    }];
    
    
}

// 如果你是自动布局子控件，就不需要实现此方法，如果是计算子控件frame的话就需要实现此方法
//- (CGSize)sizeThatFits:(CGSize)size {
//
//    CGFloat cellHeight = 0;
//
//    cellHeight += [self.avatar sizeThatFits:size].height;
//    cellHeight += [self.contentLab sizeThatFits:size].height;
//    cellHeight += [self.photosView sizeThatFits:size].height;
//    cellHeight += [self.line sizeThatFits:size].height;
//    cellHeight += 40;
//
//    return CGSizeMake(size.width, cellHeight);
//}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"ZJMasonryAutolayoutCell";
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
