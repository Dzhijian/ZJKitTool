//
//  ZJNormalPickerView.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/6/30.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJPickBaseView.h"

@interface ZJNormalPickerView : ZJPickBaseView

typedef void(^ZJNormalResultBlock)(id selectValue);

typedef void(^ZJNormalCancelBlock)(void);

/**
 *
 */
#pragma mark - 1.显示自定义字符串选择器,支持title,默认选择,选择回调
+ (void)showStringPickerWithTitle:(NSString *)title
                       dataSource:(id)dataSource
                  defaultSelValue:(id)defaultSelValue
                      resultBlock:(ZJNormalResultBlock)resultBlock;

#pragma mark - 显示自定义字符串选择器,设置自动选择、默认值、取消选择的回调
+ (void)zj_showStringPickerWithTitle:(NSString *)title
                          dataSource:(id)dataSource
                     defaultSelValue:(id)defaultSelValue
                        isAutoSelect:(BOOL)isAutoSelect
                         resultBlock:(ZJNormalResultBlock)resultBlock
                         cancelBlock:(ZJNormalCancelBlock)cancelBlock;


#pragma mark - 显示自定义字符串选择器,设置自动选择、默认值、取消选择的回调,分割线颜色,行高
+ (void)zj_showStringPickerWithTitle:(NSString *)title
                          dataSource:(id)dataSource
                     defaultSelValue:(id)defaultSelValue
                        isAutoSelect:(BOOL)isAutoSelect
                           rowHeight:(CGFloat)rowHeight
                           lineColor:(UIColor *)lineColor
                         resultBlock:(ZJNormalResultBlock)resultBlock
                         cancelBlock:(ZJNormalCancelBlock)cancelBlock;

/**
 * 显示自定义字符串选择器,设置自动选择、默认值、取消选择的回调,分割线颜色,行高,按钮颜色
 *
 */
+ (void)zj_showStringPickerWithTitle:(NSString *)title
                          dataSource:(id)dataSource
                     defaultSelValue:(id)defaultSelValue
                        isAutoSelect:(BOOL)isAutoSelect
                           rowHeight:(CGFloat)rowHeight
                           lineColor:(UIColor *)lineColor
                confirmBtnTitleColor:(UIColor *)confirmBtnTitleColor
                 cancelBtnTitleColor:(UIColor *)cancelBtnTitleColor
                         resultBlock:(ZJNormalResultBlock)resultBlock
                         cancelBlock:(ZJNormalCancelBlock)cancelBlock;
@end
