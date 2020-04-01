//
//  ZJTabeleviewChainModel.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2020/3/29.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJBaseChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class ZJTabeleviewChainModel;
@interface ZJTabeleviewChainModel : ZJBaseChainModel<ZJTabeleviewChainModel *>

ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ delegate)(id<UITableViewDelegate> delegate);
ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ dataSource)(id<UITableViewDataSource> dataSource);

ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ rowHeight)(CGFloat rowHeight);
ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ sectionHeaderHeight)(CGFloat sectionHeaderHeight);
ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ sectionFooterHeight)(CGFloat sectionFooterHeight);
ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ estimatedRowHeight)(CGFloat estimatedRowHeight);
ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ estimatedSectionHeaderHeight)(CGFloat estimatedSectionHeaderHeight);
ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ estimatedSectionFooterHeight)(CGFloat estimatedSectionFooterHeight);
ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ separatorInset)(UIEdgeInsets separatorInset);

ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ editing)(BOOL editing);
ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ allowsSelection)(BOOL allowsSelection);
ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ allowsMultipleSelection)(BOOL allowsMultipleSelection);
ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ allowsSelectionDuringEditing)(BOOL allowsSelectionDuringEditing);
ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ allowsMultipleSelectionDuringEditing)(BOOL allowsMultipleSelectionDuringEditing);

ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ separatorStyle)(UITableViewCellSeparatorStyle separatorStyle);
ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ separatorColor)(UIColor *separatorColor);

ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ tableHeaderView)(UIView * tableHeaderView);
ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ tableFooterView)(UIView * separatorStyle);

ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ sectionIndexBackgroundColor)(UIColor *sectionIndexBackgroundColor);
ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ sectionIndexColor)(UIColor *sectionIndexColor);

#pragma mark - UIScrollView
ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ contentSize)(CGSize contentSize);
ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ contentOffset)(CGPoint contentOffset);
ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ contentInset)(UIEdgeInsets contentInset);

ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ bounces)(BOOL bounces);
ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ alwaysBounceVertical)(BOOL alwaysBounceVertical);
ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ alwaysBounceHorizontal)(BOOL alwaysBounceHorizontal);

ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ pagingEnabled)(BOOL pagingEnabled);
ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ scrollEnabled)(BOOL scrollEnabled);

ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ showsHorizontalScrollIndicator)(BOOL showsHorizontalScrollIndicator);
ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ showsVerticalScrollIndicator)(BOOL showsVerticalScrollIndicator);

ZJ_CHAIN_PROPERTY ZJTabeleviewChainModel *(^ scrollsToTop)(BOOL scrollsToTop);
@end

@interface UITableView (ZJChain)

-(ZJTabeleviewChainModel *)zj_chain;

@end
NS_ASSUME_NONNULL_END
