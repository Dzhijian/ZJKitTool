//
//  BHInfiniteScrollViewCell.m
//  BHInfiniteScrollView
//
//  Created by libohao on 16/3/6.
//  Copyright © 2016年 libohao. All rights reserved.
//
/*
 *********************************************************************************
 *
 * 如果您使用轮播图库的过程中遇到Bug,请联系我,我将会及时修复Bug，为你解答问题。
 * QQ讨论群 :  206177395 (BHInfiniteScrollView讨论群)
 * Email:  375795423@qq.com
 * GitHub: https://github.com/qylibohao
 *
 *
 *********************************************************************************
 */

#import "BHInfiniteScrollViewCell.h"

#if __has_include(<UIImageView+WebCache.h>)
#import <UIImageView+WebCache.h>
#else 
#import "UIImageView+WebCache.h"
#endif

@interface BHInfiniteScrollViewCell()

@property (nonatomic, strong) UIImageView* imageView;

@end

@implementation BHInfiniteScrollViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
    }
    return self;
}


- (void)setupWithUrlString:(NSString*)url placeholderImage:(UIImage*)placeholderImage {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholderImage];
}

- (void)setupWithImageName:(NSString*)imgName placeholderImage:(UIImage*)placeholderImage {
    UIImage* image = [UIImage imageNamed:imgName];
    if (!image) {
        image  = placeholderImage;
    }
    self.imageView.image = image;
}

- (void)setupWithImage:(UIImage*)img placeholderImage:(UIImage*)placeholderImage {
    if (img) {
        self.imageView.image = img;
    }else {
        self.imageView.image = placeholderImage;
    }
    
}

- (void)setupImageView {
    [self.contentView addSubview:self.imageView];
}

- (UIImageView* )imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}

- (void)setContentMode:(UIViewContentMode)pageViewContentMode {
    _contentMode = pageViewContentMode;
    self.imageView.contentMode = pageViewContentMode;
}

@end
