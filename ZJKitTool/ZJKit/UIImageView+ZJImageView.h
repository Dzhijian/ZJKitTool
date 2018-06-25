//
//  UIImageView+ZJImageView.h
//  ZJUIKit
//
//  Created by dzj on 2017/12/4.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (ZJImageView)
/** 创建UIImageView */
+(instancetype)zj_imageViewWithFrame:(CGRect)frame
                           imageName:(NSString *)imageName
                         contentMode:(UIViewContentMode)contentMode;


@end
