//
//  ZJSwitchChainModel.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2020/3/29.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJBaseChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class ZJSwitchChainModel;

@interface ZJSwitchChainModel : ZJBaseChainModel<ZJSwitchChainModel *>

ZJ_CHAIN_PROPERTY ZJSwitchChainModel *(^ on)(BOOL on);
ZJ_CHAIN_PROPERTY ZJSwitchChainModel *(^ onTintColor)(UIColor *onTintColor);
ZJ_CHAIN_PROPERTY ZJSwitchChainModel *(^ thumbTintColor)(UIColor *thumbTintColor);

ZJ_CHAIN_PROPERTY ZJSwitchChainModel *(^ onImage)(UIImage *onImage);
ZJ_CHAIN_PROPERTY ZJSwitchChainModel *(^ offImage)(UIImage *offImage);

#pragma mark - # UIControl
ZJ_CHAIN_PROPERTY ZJSwitchChainModel *(^ enabled)(BOOL enabled);
ZJ_CHAIN_PROPERTY ZJSwitchChainModel *(^ selected)(BOOL selected);
ZJ_CHAIN_PROPERTY ZJSwitchChainModel *(^ highlighted)(BOOL highlighted);

@end
@interface UISwitch (ZJChain)

-(ZJSwitchChainModel *)zj_chain;

@end

NS_ASSUME_NONNULL_END
