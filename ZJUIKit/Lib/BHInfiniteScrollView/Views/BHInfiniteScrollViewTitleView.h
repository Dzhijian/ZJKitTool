//
//  BHInfiniteScrollViewTitleView.h
//  BHInfiniteScrollView
//
//  Created by libohao on 16/3/7.
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

#import <UIKit/UIKit.h>

@interface BHInfiniteScrollViewTitleView : UIView

@property (nonatomic, strong) UIColor* defaultBackgroundColor;

@property (nonatomic, strong) UIColor* textColor;

@property (nonatomic, strong) UIFont* font;

@property (nonatomic, assign) NSTextAlignment alignment;

@property (nonatomic, strong) NSString* titleText;

@property (nonatomic, assign) CGFloat margin;


@end
