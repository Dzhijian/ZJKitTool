//
//  ZJChooseShowView.h
//  ZJUIKit
//
//  Created by dzj on 2017/12/8.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ZJChooseShowViewDelegate <NSObject>


/**
 * 第一个View的选中事件

 @param leftIndex 选中的索引
 @param rightIndex 选中的索引
 */
-(void)chooseOneViewWithTableLeftIndex:(NSInteger)leftIndex rightIndex:(NSInteger)rightIndex;
/**
 * 第二个View的选中事件
 
 @param leftindex 选中的索引
 @param rightIndex 选中的索引
 */
-(void)chooseTwoViewCellDidSelectedWithLeftIndex:(NSInteger)leftindex rightIndex:(NSInteger)rightIndex mcid:(NSString *)mc_id;
/**
 * 第三个View的选中事件
 
 @param index 选中的索引
 */
-(void)chooseThreeViewCellDidSelectedWithIndex:(NSInteger)index;
/**
 * 第四个View的选中事件

 */
-(void)chooseFourViewBtnResultWithIsProm:(BOOL)isprom isVer:(BOOL)isver;

@end

@interface ZJChooseShowView : UIView
// 按钮数组
@property(nonatomic ,strong) NSArray        *btnArray;
@property(nonatomic ,strong) UIView         *hiddenView;
@property(nonatomic ,strong) NSArray        *allMerAreaArr;
@property(nonatomic ,strong) NSArray        *childMerArr;
@property(nonatomic ,strong) NSArray        *merCateArray;
@property(nonatomic ,strong) NSArray        *childCateArr;

// 索引
@property(nonatomic ,assign) NSInteger      twoLeftIndex;
@property(nonatomic ,assign) NSInteger      twoRightIndex;

@property(nonatomic ,weak) id<ZJChooseShowViewDelegate> delegate;


/**
 * 初始化筛选View

 @param btnArr 标题数组
 @param sender 辩题按钮
 */
-(void)chooseControlViewBtnArray:(NSArray *)btnArr Action:(UIButton *)sender;

@end
