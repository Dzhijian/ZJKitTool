//
//  ZJUIImageViewChainModel.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2020/3/28.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJBaseChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class ZJUIImageViewChainModel;

@interface ZJUIImageViewChainModel : ZJBaseChainModel<ZJUIImageViewChainModel *>

ZJ_CHAIN_PROPERTY  ZJUIImageViewChainModel *_Nullable(^image)(UIImage *image);
ZJ_CHAIN_PROPERTY ZJUIImageViewChainModel *_Nullable(^highlightedImage)(UIImage *image);
ZJ_CHAIN_PROPERTY ZJUIImageViewChainModel *_Nullable(^highlighted)(BOOL highlighted);
/// 点击事件
ZJ_CHAIN_PROPERTY ZJUIImageViewChainModel* (^ onTap)(ZJTapGestureBlock ontap);
@end

@interface UIImageView (ZJChain)

-(ZJUIImageViewChainModel *)zj_chain;
- (void)addTapGestureWithCallback:(ZJTapGestureBlock)onTaped;

@end
NS_ASSUME_NONNULL_END
