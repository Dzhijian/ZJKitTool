//
//  UITableViewCell+ZJBaseFunctions.h
//  Community_Pharmacy
//
//  Created by 邓志坚 on 2018/5/5.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

#import <UIKit/UIKit.h>
#pragma mark - ZJBaseTableCellClassProtocol
/**
 类方法协议
 */
@protocol ZJBaseTableCellClassProtocol <NSObject>
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
 根据模型返回单元格高度
 
 @param model 模型
 @return 高度
 */
+ (CGFloat)heightWithModel:(id)model;
/**
 单元格高度（定高）
 
 @return 高度
 */
+ (CGFloat)height;

@end


#pragma mark - CPBaseTableCellNotification
/**
 通知协议
 */
@protocol ZJBaseTableCellNotificationProtocol <NSObject>
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

@interface UITableViewCell (ZJBaseFunctions)<ZJBaseTableCellClassProtocol,ZJBaseTableCellNotificationProtocol>

/**
 配置UI
 */
- (void)zj_initWithAllView NS_REQUIRES_SUPER;


@end
