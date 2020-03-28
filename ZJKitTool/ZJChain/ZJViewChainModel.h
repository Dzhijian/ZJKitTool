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


@end


@interface UIView (ZJChain)

-(ZJViewChainModel *)zj_chain;

@end
NS_ASSUME_NONNULL_END
