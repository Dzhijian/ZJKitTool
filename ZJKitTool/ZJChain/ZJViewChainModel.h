//
//  ZJViewChainModel.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2020/3/23.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJBaseChainModel.h"

NS_ASSUME_NONNULL_BEGIN

#define ZJ_CHAIN_PROPERTY  @property (nonatomic, copy, readonly)

@class ZJViewChainModel;

@interface ZJViewChainModel : ZJBaseChainModel <ZJViewChainModel *>

#pragma mrk - Action

ZJ_CHAIN_PROPERTY ZJViewChainModel* (^ gestureOnTap)(void (^constraints)(ZJTapGestureBlock ontap));

@end


@interface UIView (ZJChain)

-(ZJViewChainModel *)zj_chain;


/**
 *  点击手势
 */
@property (nonatomic, strong, readonly) UITapGestureRecognizer *zj_tapGesture;

/**
 *
 *    长按手势
 */
@property (nonatomic, strong, readonly) UILongPressGestureRecognizer *zj_longGesure;

@end
NS_ASSUME_NONNULL_END
