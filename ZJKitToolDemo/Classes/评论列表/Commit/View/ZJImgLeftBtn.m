//
//  ZJImgLeftBtn.m
//  Sedu590
//
//  Created by dzj on 2017/12/15.
//  Copyright © 2017年 邓志坚. All rights reserved.
//

#import "ZJImgLeftBtn.h"

/**
 *  ZJKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下。😆
 */

@implementation ZJImgLeftBtn

// 对图片的标题和文字重新布局
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat imgW = CGRectGetWidth(self.imageView.bounds);;
    CGFloat titleH = CGRectGetHeight(self.titleLabel.bounds);
    CGFloat titleW = CGRectGetWidth(self.titleLabel.bounds);

    self.imageView.frame = CGRectMake(0, 0, imgW, CGRectGetHeight(self.imageView.bounds));
    self.titleLabel.frame = CGRectMake(imgW + 4, 0, titleW, titleH);

}

@end
