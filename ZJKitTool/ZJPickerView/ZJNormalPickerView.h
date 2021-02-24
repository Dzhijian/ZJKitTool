//
//  ZJNormalPickerView.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/6/30.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJPickBaseView.h"

@interface ZJNormalPickerView : ZJPickBaseView

typedef void(^ZJNormalResultBlock)(id selectValue , NSInteger index);

typedef void(^ZJNormalCancelBlock)(void);


/// 标题
@property (nonatomic, copy) NSString              *title;
/// 数据源
@property (nonatomic, strong) NSArray               *dataSource;
/// 选中后的回调
@property (nonatomic, copy) ZJNormalResultBlock    resultBlock;
/// 取消选择的回调
@property (nonatomic, copy) ZJNormalCancelBlock    cancelBlock;
/// 是否开启自动选择
@property (nonatomic, assign) BOOL                  isAutoSelect;
/// 选中行文本的颜色
@property (nonatomic, strong) UIColor               *selecteRowTextColor;
/// 选中行背景颜色
@property (nonatomic, strong) UIColor               *selectRowBGColor;
/// 右边按钮颜色
@property (nonatomic, strong) UIColor               *rightBtnTitleColor;
/// 左边按钮颜色
@property (nonatomic, strong) UIColor               *leftBtnTitleColor;
/// 行高
@property (nonatomic, assign) CGFloat               rowHeight;
/// 数据源是否合法
@property (nonatomic, assign) bool                  isDataSourceValid;
/// 默认值
@property (nonatomic, copy) id                      defaultValue;
/// 弹穿是否需要动画
@property (nonatomic, assign) bool                  animation;

/// 显示弹窗
-(void)showView;

/**
 
 1.显示自定义字符串选择器,支持title,默认选择,选择回调
 
 @param title 标题
 @param dataSource 数据源
 @param defaultValue 默认选中的值
 @param resultBlock 确认返回回调
 */

+ (void)zj_showStringPickerWithTitle:(NSString *)title
                       dataSource:(id)dataSource
                  defaultValue:(id)defaultValue
                      resultBlock:(ZJNormalResultBlock)resultBlock;

/**
 
2.显示自定义字符串选择器,设置自动选择、默认值、取消选择的回调
 
 @param title 标题
 @param dataSource 数据源
 @param defaultValue 默认选中的值
 @param isAutoSelect 是否自动选择
 @param resultBlock 确认返回回调
 @param cancelBlock 取消返回回调
 */
+ (void)zj_showStringPickerWithTitle:(NSString *)title
                          dataSource:(id)dataSource
                     defaultValue:(id)defaultValue
                        isAutoSelect:(BOOL)isAutoSelect
                         resultBlock:(ZJNormalResultBlock)resultBlock
                         cancelBlock:(ZJNormalCancelBlock)cancelBlock;


/**
 
 3.显示自定义字符串选择器,设置自动选择、默认值、取消选择的回调,分割线颜色,行高

 @param title 标题
 @param dataSource 数据源
 @param defaultValue 默认选中的值
 @param isAutoSelect 是否自动选择
 @param rowHeight 行高度
 @param lineColor 分割线颜色
 @param resultBlock 确认返回回调
 @param cancelBlock 取消返回回调
 */
+ (void)zj_showStringPickerWithTitle:(NSString *)title
                          dataSource:(id)dataSource
                     defaultValue:(id)defaultValue
                        isAutoSelect:(BOOL)isAutoSelect
                           rowHeight:(CGFloat)rowHeight
                           lineColor:(UIColor *)lineColor
                         resultBlock:(ZJNormalResultBlock)resultBlock
                         cancelBlock:(ZJNormalCancelBlock)cancelBlock;



/**
 
  4.显示自定义字符串选择器,设置自动选择、默认值、取消选择的回调,分割线颜色,行高,按钮颜色

 @param title 标题
 @param dataSource 数据源
 @param defaultValue 默认选中的值
 @param isAutoSelect 是否自动选择
 @param rowHeight 行高度
 @param lineColor 分割线颜色
 @param confirmBtnTitleColor 确认按钮的颜色
 @param cancelBtnTitleColor 取消按钮的文不颜色
 @param resultBlock 确认返回回调
 @param cancelBlock 取消返回回调
 */
+ (void)zj_showStringPickerWithTitle:(NSString *)title
                          dataSource:(id)dataSource
                     defaultValue:(id)defaultValue
                        isAutoSelect:(BOOL)isAutoSelect
                           rowHeight:(CGFloat)rowHeight
                           lineColor:(UIColor *)lineColor
                confirmBtnTitleColor:(UIColor *)confirmBtnTitleColor
                 cancelBtnTitleColor:(UIColor *)cancelBtnTitleColor
                         resultBlock:(ZJNormalResultBlock)resultBlock
                         cancelBlock:(ZJNormalCancelBlock)cancelBlock;


/**
 
 5.显示自定义字符串选择器,设置自动选择、默认值、取消选择的回调,分割线颜色,行高,按钮颜色,选中行背景文本颜色,左右按钮文字
 
 @param title 标题
 @param dataSource 数据源
 @param defaultValue 默认选中的值
 @param isAutoSelect 是否自动选择
 @param rowHeight 行高度
 @param lineColor 分割线颜色
 @param confirmBtnTitleColor 确认按钮的颜色
 @param cancelBtnTitleColor 取消按钮的文不颜色
 @param selecteRowTextColor 选中行文本颜色
 @param selectRowBGColor 选中行背景颜色
 @param leftBtnTitle leftBtnTitle
 @param rightBtnTitle rightBtnTitle
 @param resultBlock 确认返回回调
 @param cancelBlock 取消返回回调
 */
+ (void)zj_showStringPickerWithTitle:(NSString *)title
                       dataSource:(id)dataSource
                  defaultValue:(id)defaultValue
                     isAutoSelect:(BOOL)isAutoSelect
                        rowHeight:(CGFloat)rowHeight
                        lineColor:(UIColor *)lineColor
             confirmBtnTitleColor:(UIColor *)confirmBtnTitleColor
              cancelBtnTitleColor:(UIColor *)cancelBtnTitleColor
              selecteRowTextColor:(UIColor *)selecteRowTextColor
                 selectRowBGColor:(UIColor *)selectRowBGColor
                     leftBtnTitle:(NSString *)leftBtnTitle
                    rightBtnTitle:(NSString *)rightBtnTitle
                      resultBlock:(ZJNormalResultBlock)resultBlock
                      cancelBlock:(ZJNormalCancelBlock)cancelBlock;
    @end
