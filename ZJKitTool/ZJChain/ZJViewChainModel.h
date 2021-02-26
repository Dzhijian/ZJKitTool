//
//  ZJViewChainModel.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2020/3/23.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJBaseChainModel.h"
#import "UIGestureRecognizer+ZJActionBlock.h"

NS_ASSUME_NONNULL_BEGIN

#define ZJ_CHAIN_PROPERTY  @property (nonatomic, copy, readonly)

@class ZJViewChainModel;

@interface ZJViewChainModel : ZJBaseChainModel <ZJViewChainModel *>

#pragma mrk - Action
/// 点击事件
ZJ_CHAIN_PROPERTY ZJViewChainModel* (^ onTap)(ZJTapGestureBlock ontap);

@end


@interface UIView (ZJChain)

-(ZJViewChainModel *)zj_chain;

- (void)addTapGestureWithCallback:(ZJTapGestureBlock)onTaped;

//
///**
// *  点击手势
// */
//@property (nonatomic, strong, readonly) UITapGestureRecognizer *zj_tapGesture;
//
///**
// *
// *    长按手势
// */
//@property (nonatomic, strong, readonly) UILongPressGestureRecognizer *zj_longGesure;

@end
NS_ASSUME_NONNULL_END
