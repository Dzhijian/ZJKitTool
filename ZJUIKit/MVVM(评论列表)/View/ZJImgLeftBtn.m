//
//  ZJImgLeftBtn.m
//  Sedu590
//
//  Created by dzj on 2017/12/15.
//  Copyright © 2017年 邓志坚. All rights reserved.
//

#import "ZJImgLeftBtn.h"

@implementation ZJImgLeftBtn


-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat imgW = CGRectGetWidth(self.imageView.bounds);;
    CGFloat titleH = CGRectGetHeight(self.titleLabel.bounds);
    CGFloat titleW = CGRectGetWidth(self.titleLabel.bounds);

    self.imageView.frame = CGRectMake(0, 0, imgW, CGRectGetHeight(self.imageView.bounds));
    self.titleLabel.frame = CGRectMake(imgW + 4, 0, titleW, titleH);
    
    
}

@end
