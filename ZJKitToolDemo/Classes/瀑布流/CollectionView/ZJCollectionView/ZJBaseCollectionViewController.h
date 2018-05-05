//
//  ZJCollectionViewController.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/29.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJKitBaseController.h"
#import "ZJElementsFlowLayout.h"
#import "ZJVerticalFlowLayout.h"
#import "ZJHorizontalFlowLayout.h"

@class ZJBaseCollectionViewController;

@protocol ZJBaseCollectionViewControllerDataSource <NSObject>

@required


/**
 * 指定返回的FlowLayout布局样式 ，自定义了三种，有垂直、水平、和普通三种
 * ZJVerticalFlowLayout，ZJHorizontalFlowLayout，ZJElementsFlowLayout
 
 @param collectionViewController collectionViewController
 @param collectionView collectionView
 @return UICollectionViewLayout
 */
- (UICollectionViewLayout *)zj_collectionViewController:(ZJBaseCollectionViewController *)collectionViewController layoutForCollectionView:(UICollectionView *)collectionView;
@end

@interface ZJBaseCollectionViewController : ZJKitBaseController <UICollectionViewDelegate, UICollectionViewDataSource,ZJBaseCollectionViewControllerDataSource>

// collectionView
@property(nonatomic ,weak) UICollectionView *collectionView;

@end
