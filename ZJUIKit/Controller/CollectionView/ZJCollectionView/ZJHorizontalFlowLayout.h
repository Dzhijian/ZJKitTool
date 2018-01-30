//
//  ZJHorizontalFlowLayout.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/30.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJHorizontalFlowLayout;

@protocol ZJHorizontalFlowLayoutDelegate <NSObject>

@required
/**
 *  cell的高度
 *
 *  @param waterflowLayout 哪个布局需要代理返回高度
 *  @param  indexPath          对应的cell, 的indexPath, 但是indexPath.section == 0
 *  @param itemHeight           layout内部计算的高度
 *
 *  @return 需要代理高度对应的cell的高度
 */
- (CGFloat)zj_waterflowLayout:(ZJHorizontalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView widthForItemAtIndexPath:(NSIndexPath *)indexPath itemHeight:(CGFloat)itemHeight;
@optional

/**
 *  需要显示的行数, 默认3
 */
- (NSInteger)zj_waterflowLayout:(ZJHorizontalFlowLayout *)waterflowLayout linesInCollectionView:(UICollectionView *)collectionView;
/**
 *  列间距, 默认10
 */
- (CGFloat)zj_waterflowLayout:(ZJHorizontalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView columnsMarginForItemAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  行间距, 默认10
 */
- (CGFloat)zj_waterflowLayout:(ZJHorizontalFlowLayout *)waterflowLayout linesMarginInCollectionView:(UICollectionView *)collectionView;

/**
 *  距离collectionView四周的间距, 默认{10, 10, 10, 10}
 */
- (UIEdgeInsets)zj_waterflowLayout:(ZJHorizontalFlowLayout *)waterflowLayout edgeInsetsInCollectionView:(UICollectionView *)collectionView;

@end

@interface ZJHorizontalFlowLayout : UICollectionViewLayout

/**
 *  layout的代理
 */
- (instancetype)initWithDelegate:(id<ZJHorizontalFlowLayoutDelegate>)delegate;

+ (instancetype)flowLayoutWithDelegate:(id<ZJHorizontalFlowLayoutDelegate>)delegate;

@end
