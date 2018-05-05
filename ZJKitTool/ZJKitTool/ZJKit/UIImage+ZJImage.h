//
//  UIImage+ZJImage.h
//  ZJUIKit
//
//  Created by dzj on 2017/12/5.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZJImage)

/** 截屏 */
+(instancetype)zj_snapshotCurrentcreen;

/** 高效添加圆角 */
-(UIImage *)zj_imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size;

@end
