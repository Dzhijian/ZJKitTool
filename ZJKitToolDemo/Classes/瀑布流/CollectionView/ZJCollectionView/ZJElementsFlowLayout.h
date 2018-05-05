//
//  ZJElementsFlowLayout.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/29.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZJElementsFlowLayout;

@protocol ZJElementsFlowLayoutDelegate <NSObject>

@required

/**
 * 要求实现

 @param waterFlowLayout 布局需要代理返回大小
 @param collectionView collectionView
 @param indexPath 对应 cell 的indexPath
 @return 需要代理高度对应的cell的高度
 */
-(CGSize)zj_waterflowLayout:(ZJElementsFlowLayout *)waterFlowLayout
             collectionView:(UICollectionView *)collectionView
     sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional

/**
 *  列间距, 默认10
 */
-(CGFloat)zj_waterflowLayout:(ZJElementsFlowLayout *)waterflowLayout
          collectionView:(UICollectionView *)collectionView
    columnsMarginForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  行间距, 默认10
 */
- (CGFloat)zj_waterflowLayout:(ZJElementsFlowLayout *)waterflowLayout
               collectionView:(UICollectionView *)collectionView
linesMarginForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  距离collectionView四周的间距, 默认{10, 10, 10, 10}
 */
- (UIEdgeInsets)zj_waterflowLayout:(ZJElementsFlowLayout *)waterflowLayout
        edgeInsetsInCollectionView:(UICollectionView *)collectionView;

@end

@interface ZJElementsFlowLayout : UICollectionViewLayout


/**
 * layout的代理
 */
-(instancetype)initWithDelegate:(id<ZJElementsFlowLayoutDelegate>)delegate;

+(instancetype)flowLayoutWithDelegate:(id<ZJElementsFlowLayoutDelegate>)deleagte;

@end
