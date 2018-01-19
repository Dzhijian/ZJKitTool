//
//  BHInfiniteScrollView.h
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

#import <UIKit/UIKit.h>
#import "BHInfiniteScrollViewTitleView.h"
#import "FXPageControl.h"

typedef NS_ENUM(NSInteger, BHInfiniteScrollViewScrollDirection) {
    BHInfiniteScrollViewScrollDirectionHorizontal,                 /** 水平滚动*/
    BHInfiniteScrollViewScrollDirectionVertical,                   /** 垂直滚动*/
};

typedef NS_ENUM(NSInteger, BHInfiniteScrollViewPageControlAlignHorizontal) {
    BHInfiniteScrollViewPageControlAlignHorizontalCenter,          /** page control 布局 水平居中*/
    BHInfiniteScrollViewPageControlAlignHorizontalRight,           /** page control 布局 水平靠右*/
    BHInfiniteScrollViewPageControlAlignHorizontalLeft,            /** page control 布局 水平靠左*/
};

typedef NS_ENUM(NSInteger, BHInfiniteScrollViewPageControlAlignVertical) {
    BHInfiniteScrollViewPageControlAlignVerticalCenter,            /** page control 布局 垂直居中*/
    BHInfiniteScrollViewPageControlAlignVerticalTop,               /** page control 布局 垂直靠上*/
    BHInfiniteScrollViewPageControlAlignVerticalButtom,            /** page control 布局 垂直靠底*/
};

@class BHInfiniteScrollView;
@protocol BHInfiniteScrollViewDelegate <NSObject>

@optional

/** 点击图片*/
- (void)infiniteScrollView:(BHInfiniteScrollView *)infiniteScrollView didSelectItemAtIndex:(NSInteger)index;

/** 图片滚动*/
- (void)infiniteScrollView:(BHInfiniteScrollView *)infiniteScrollView didScrollToIndex:(NSInteger)index;

@end


@interface BHInfiniteScrollView : UIView

+ (instancetype)infiniteScrollViewWithFrame:(CGRect)frame Delegate:(id<BHInfiniteScrollViewDelegate>)delegate ImagesArray:(NSArray *)images;

+ (instancetype)infiniteScrollViewWithFrame:(CGRect)frame Delegate:(id<BHInfiniteScrollViewDelegate>)delegate
                                ImagesArray:(NSArray *)images PlageHolderImage:(UIImage*)placeHolderImage;

+ (instancetype)infiniteScrollViewWithFrame:(CGRect)frame Delegate:(id<BHInfiniteScrollViewDelegate>)delegate ImagesArray:(NSArray *)images PlageHolderImage:(UIImage*)placeHolderImage InfiniteLoop:(BOOL)loop;

/** 图片数据源 */
@property (nonatomic, copy) NSArray *imagesArray;

/** 标题数据源 */
@property (nonatomic, copy) NSArray *titlesArray;



/** 轮播图Delegete */
@property (nonatomic, assign) id<BHInfiniteScrollViewDelegate> delegate;

/** 轮播图滚动方向 - 默认是水平方向 */
@property (nonatomic, assign) BHInfiniteScrollViewScrollDirection scrollDirection;

/** 轮播图反方向滚动 - 默认为NO */
@property (nonatomic, assign) BOOL reverseDirection;

/** PageControl 水平方向位置 - 默认是Center */
@property (nonatomic, assign) BHInfiniteScrollViewPageControlAlignHorizontal pageControlAlignmentH;

/** PageControl 垂直方向位置 - 默认是Buttom */
@property (nonatomic, assign) BHInfiniteScrollViewPageControlAlignVertical pageControlAlignmentV;


/** PageControl 位置偏移量 - 默认是(0,10) */
@property (nonatomic, assign) CGSize pageControlAlignmentOffset;

/** 轮播图是否自动滚动 - 默认是YES */
@property (nonatomic, assign) BOOL autoScrollToNextPage;

/** 轮播图是否无限循环滚动 - 默认是YES */
@property (nonatomic, assign) BOOL infiniteLoop;


/** 轮播图滚动时间间隔 - 默认是3秒 */
@property (nonatomic, assign) NSTimeInterval scrollTimeInterval;

/** 获取轮播图当前的位置 */
@property (nonatomic, assign, readonly) NSInteger currentPageIndex;

/** 轮播图片占位图 */
@property (nonatomic, strong) UIImage* placeholderImage;

/** 轮播图片ContentMode - 默认为 UIViewContentModeScaleToFill */
@property (nonatomic, assign) UIViewContentMode pageViewContentMode;


/**----- PageControl 设置 -----*/
/** PageControl dot图片 */
@property (nonatomic, strong) UIImage *dotImage;

/** PageControl 形状 */
@property (nonatomic, assign) CGPathRef dotShape;

/** PageControl 大小 */
@property (nonatomic, assign) CGFloat dotSize;

/** PageControl 默认颜色 */
@property (nonatomic, strong) UIColor *dotColor;

/** PageControl 阴影颜色 */
@property (nonatomic, strong) UIColor *dotShadowColor;

/** PageControl 阴影模糊 */
@property (nonatomic, assign) CGFloat dotShadowBlur;

/** PageControl 偏移 */
@property (nonatomic, assign) CGSize dotShadowOffset;

/** PageControl dot选中图片 */
@property (nonatomic, strong) UIImage *selectedDotImage;

/** PageControl dot选中形状 */
@property (nonatomic, assign) CGPathRef selectedDotShape;

/** PageControl dot选中大小 */
@property (nonatomic, assign) CGFloat selectedDotSize;

/** PageControl dot选中颜色 */
@property (nonatomic, strong) UIColor *selectedDotColor;

/** PageControl dot选中阴影颜色 */
@property (nonatomic, strong) UIColor *selectedDotShadowColor;

/** PageControl dot选中阴影模糊 */
@property (nonatomic, assign) CGFloat selectedDotShadowBlur;

/** PageControl dot选中阴影偏移 */
@property (nonatomic, assign) CGSize selectedDotShadowOffset;

/** PageControl dot间距 */
@property (nonatomic, assign) CGFloat dotSpacing;

/** PageControl 隐藏 */
@property (nonatomic, assign) BOOL pageControlHidden;


/** 轮播图片点击回调 */
@property (nonatomic, copy) void (^scrollViewDidSelectBlock)(BHInfiniteScrollView* infiniteScrollView , NSInteger index);


/** 轮播图标题控件 */
@property (nonatomic, strong) BHInfiniteScrollViewTitleView* titleView;

/** 滚动到指定的页面 */
- (void)scrollToPageAtIndex:(NSUInteger)pageIndex Animation:(BOOL)animation;

/** 开始自动滚动 */
- (void)startAutoScrollPage;

/** 停止自动滚动 */
- (void)stopAutoScrollPage;
@end
