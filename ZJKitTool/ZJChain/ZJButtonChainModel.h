//
//  ZJButtonChainModel.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2020/3/28.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJBaseChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class ZJButtonChainModel;
/**
 * Button点击事件Block
 *
 */
typedef void(^ZJButtonChainBlock)(id sender);

@interface ZJButtonChainModel : ZJBaseChainModel<ZJButtonChainModel *>

ZJ_CHAIN_PROPERTY ZJButtonChainModel *_Nullable(^title)(NSString *title , UIControlState state);
ZJ_CHAIN_PROPERTY ZJButtonChainModel *_Nullable(^titleColor)(UIColor *titleColor , UIControlState state);
ZJ_CHAIN_PROPERTY ZJButtonChainModel *_Nullable(^titleFont)(UIFont *titleFont);
ZJ_CHAIN_PROPERTY ZJButtonChainModel *_Nullable(^attributedTitle)(NSAttributedString *attributedTitle , UIControlState state);

ZJ_CHAIN_PROPERTY ZJButtonChainModel *_Nullable(^image)(UIImage *image , UIControlState state);
ZJ_CHAIN_PROPERTY ZJButtonChainModel *_Nullable(^backgroundImage)(UIImage *image , UIControlState state);
ZJ_CHAIN_PROPERTY ZJButtonChainModel *_Nullable(^backgroundColorState)(UIColor *color , UIControlState state);

ZJ_CHAIN_PROPERTY ZJButtonChainModel *_Nullable(^contentEdgeInsets)(UIEdgeInsets contentEdgeInsets);
ZJ_CHAIN_PROPERTY ZJButtonChainModel *_Nullable(^titleEdgeInsets)(UIEdgeInsets titleEdgeInsets);
ZJ_CHAIN_PROPERTY ZJButtonChainModel *_Nullable(^imageEdgeInsets)(UIEdgeInsets imageEdgeInsets);

ZJ_CHAIN_PROPERTY ZJButtonChainModel *_Nullable(^enabled)(BOOL enabled);
ZJ_CHAIN_PROPERTY ZJButtonChainModel *_Nullable(^selected)(BOOL selected);
ZJ_CHAIN_PROPERTY ZJButtonChainModel *_Nullable(^highlighted)(BOOL highlighted);

/// 点击事件
ZJ_CHAIN_PROPERTY ZJButtonChainModel* _Nullable(^ onTouchUp)(ZJButtonChainBlock onTouchUp);


@end


@interface UIButton (ZJChain)

-(ZJButtonChainModel *)zj_chain;

@property (nonatomic, copy) ZJButtonChainBlock onTouchUp;

@end

NS_ASSUME_NONNULL_END
