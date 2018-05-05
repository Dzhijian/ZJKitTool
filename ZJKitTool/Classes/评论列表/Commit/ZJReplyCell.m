//
//  ZJReplyCell.m
//  ZJUIKit
//
//  Created by 邓志坚 on 2018/4/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJReplyCell.h"

@interface ZJReplyCell ()
@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation ZJReplyCell


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(7.0);//cell上部距离为3.0个间隙
        }];
    }
    return self;
}

-(void)configData{
    self.contentLabel.text = @"像Mac一样装Win 10！Pixelbook惊现双系统模式";
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
//        _contentLabel.backgroundColor  = [UIColor clearColor];
        _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:13.0];
        _contentLabel.textColor = [UIColor blackColor];
        
    }
    return _contentLabel;
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
