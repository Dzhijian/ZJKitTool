//
//  ZJCollectionViewChainModel.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2020/4/1.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJBaseChainModel.h"

NS_ASSUME_NONNULL_BEGIN

@class ZJCollectionViewChainModel;

@interface ZJCollectionViewChainModel : ZJBaseChainModel<ZJCollectionViewChainModel *>

ZJ_CHAIN_PROPERTY ZJCollectionViewChainModel *(^ collectionViewLayout)(UICollectionViewLayout *collectionViewLayout);
ZJ_CHAIN_PROPERTY ZJCollectionViewChainModel *(^ delegate)(id<UICollectionViewDelegate> delegate);
ZJ_CHAIN_PROPERTY ZJCollectionViewChainModel *(^ dataSource)(id<UICollectionViewDataSource> dataSource);

ZJ_CHAIN_PROPERTY ZJCollectionViewChainModel *(^ allowsSelection)(BOOL allowsSelection);
ZJ_CHAIN_PROPERTY ZJCollectionViewChainModel *(^ allowsMultipleSelection)(BOOL allowsMultipleSelection);

#pragma mark - UIScrollView
ZJ_CHAIN_PROPERTY ZJCollectionViewChainModel *(^ contentSize)(CGSize contentSize);
ZJ_CHAIN_PROPERTY ZJCollectionViewChainModel *(^ contentOffset)(CGPoint contentOffset);
ZJ_CHAIN_PROPERTY ZJCollectionViewChainModel *(^ contentInset)(UIEdgeInsets contentInset);

ZJ_CHAIN_PROPERTY ZJCollectionViewChainModel *(^ bounces)(BOOL bounces);
ZJ_CHAIN_PROPERTY ZJCollectionViewChainModel *(^ alwaysBounceVertical)(BOOL alwaysBounceVertical);
ZJ_CHAIN_PROPERTY ZJCollectionViewChainModel *(^ alwaysBounceHorizontal)(BOOL alwaysBounceHorizontal);

ZJ_CHAIN_PROPERTY ZJCollectionViewChainModel *(^ pagingEnabled)(BOOL pagingEnabled);
ZJ_CHAIN_PROPERTY ZJCollectionViewChainModel *(^ scrollEnabled)(BOOL scrollEnabled);

ZJ_CHAIN_PROPERTY ZJCollectionViewChainModel *(^ showsHorizontalScrollIndicator)(BOOL showsHorizontalScrollIndicator);
ZJ_CHAIN_PROPERTY ZJCollectionViewChainModel *(^ showsVerticalScrollIndicator)(BOOL showsVerticalScrollIndicator);

ZJ_CHAIN_PROPERTY ZJCollectionViewChainModel *(^ scrollsToTop)(BOOL scrollsToTop);

@end



@interface UICollectionView (ZJChain)

-(ZJCollectionViewChainModel *)zj_chain;

@end

NS_ASSUME_NONNULL_END
