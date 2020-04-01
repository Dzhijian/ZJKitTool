//
//  ZJScrollViewChainModel.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2020/4/2.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJBaseChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class ZJScrollViewChainModel;
@interface ZJScrollViewChainModel : ZJBaseChainModel<ZJScrollViewChainModel *>

ZJ_CHAIN_PROPERTY ZJScrollViewChainModel *(^ delegate)(id<UIScrollViewDelegate> delegate);

ZJ_CHAIN_PROPERTY ZJScrollViewChainModel *(^ contentSize)(CGSize contentSize);
ZJ_CHAIN_PROPERTY ZJScrollViewChainModel *(^ contentOffset)(CGPoint contentOffset);
ZJ_CHAIN_PROPERTY ZJScrollViewChainModel *(^ contentInset)(UIEdgeInsets contentInset);

ZJ_CHAIN_PROPERTY ZJScrollViewChainModel *(^ bounces)(BOOL bounces);
ZJ_CHAIN_PROPERTY ZJScrollViewChainModel *(^ alwaysBounceVertical)(BOOL alwaysBounceVertical);
ZJ_CHAIN_PROPERTY ZJScrollViewChainModel *(^ alwaysBounceHorizontal)(BOOL alwaysBounceHorizontal);

ZJ_CHAIN_PROPERTY ZJScrollViewChainModel *(^ pagingEnabled)(BOOL pagingEnabled);
ZJ_CHAIN_PROPERTY ZJScrollViewChainModel *(^ scrollEnabled)(BOOL scrollEnabled);

ZJ_CHAIN_PROPERTY ZJScrollViewChainModel *(^ showsHorizontalScrollIndicator)(BOOL showsHorizontalScrollIndicator);
ZJ_CHAIN_PROPERTY ZJScrollViewChainModel *(^ showsVerticalScrollIndicator)(BOOL showsVerticalScrollIndicator);

ZJ_CHAIN_PROPERTY ZJScrollViewChainModel *(^ scrollsToTop)(BOOL scrollsToTop);

@end

@interface UIScrollView (ZJChain)

-(ZJScrollViewChainModel *)zj_chain;

@end

NS_ASSUME_NONNULL_END
