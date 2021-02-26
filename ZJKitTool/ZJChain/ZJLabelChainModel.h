//
//  ZJLabelChainModel.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2020/3/27.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJBaseChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class ZJLabelChainModel;

@interface ZJLabelChainModel : ZJBaseChainModel<ZJLabelChainModel *>

ZJ_CHAIN_PROPERTY ZJLabelChainModel *(^ text)(NSString *text);
ZJ_CHAIN_PROPERTY ZJLabelChainModel *(^ font)(UIFont *font);
ZJ_CHAIN_PROPERTY ZJLabelChainModel *(^ textColor)(UIColor *textColor);
ZJ_CHAIN_PROPERTY ZJLabelChainModel *(^ attributedText)(NSAttributedString *attributedText);

ZJ_CHAIN_PROPERTY ZJLabelChainModel *(^ textAlignment)(NSTextAlignment textAlignment);
ZJ_CHAIN_PROPERTY ZJLabelChainModel *(^ numberOfLines)(NSInteger numberOfLines);
ZJ_CHAIN_PROPERTY ZJLabelChainModel *(^ lineBreakMode)(NSLineBreakMode lineBreakMode);
ZJ_CHAIN_PROPERTY ZJLabelChainModel *(^ adjustsFontSizeToFitWidth)(BOOL adjustsFontSizeToFitWidth);

@end

@interface UILabel (ZJChain)

-(ZJLabelChainModel *)zj_chain;

/**
 *  设置字间距
 */
- (void)setColumnSpace:(CGFloat)columnSpace;

/**
 *  设置行距
 */
- (void)setRowSpace:(CGFloat)rowSpace;
@end
NS_ASSUME_NONNULL_END
