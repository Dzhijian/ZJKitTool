//
//  UICollectionViewCell+ZJBaseFunctions.h
//  Community_Pharmacy
//
//  Created by 邓志坚 on 2018/5/5.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

#import <UIKit/UIKit.h>
#pragma mark - ZJBaseCollectionCellClas
/**
 类方法协议
 */
@protocol ZJBaseCollectionCellClassProtocol <NSObject>
@optional
/**
 根据模型返回重用标识符
 
 @param model 模型
 @return 重用标识符
 */
+ (NSString *)identifierWithModel:(id)model;
/**
 单一的重用标识符
 
 @return 重用标识符
 */
+ (NSString *)identifier;
/**
 根据模型返回单元格尺寸
 
 @param model 模型
 @return 尺寸
 */
+ (CGSize)itemSizeWithModel:(id)model;
/**
 单元格高度（定高）
 
 @return 尺寸
 */
+ (CGSize)itemSize;

@end
#pragma mark - ZJBaseTableCellNotification
/**
 通知协议
 */
@protocol ZJBaseCollectionCellNotificationProtocol <NSObject>
@optional
/**
 *   注册通知
 */
- (void)registerNotification;
/**
 *   移除通知
 */
- (void)removeNotification;
@end

@interface UICollectionViewCell (ZJBaseFunctions)<ZJBaseCollectionCellClassProtocol,ZJBaseCollectionCellNotificationProtocol>

-(void)zj_initWithAllView NS_REQUIRES_SUPER;
@end
