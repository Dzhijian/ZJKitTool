//
//  ZJDatePickerView.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/7/4.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJPickBaseView.h"


typedef enum : NSUInteger {
    
    ZJDatePickerModeTime,
    ZJDatePickerModeDate,
    ZJDatePickerModeDateAndTime,
    ZJDatePickerModeCountDownTimer,
    
    ZJDatePickerModeYMDHM,
    ZJDatePickerModeMDHM,
    ZJDatePickerModeYMD,
    ZJDatePickerModeYM,
    ZJDatePickerModeY,
    ZJDatePickerModeMD,
    ZJDatePickerModeHM
} ZJDatePickerMode;

typedef void(^ZJDateResultBlock)(NSString *selectValue);
typedef void(^ZJDateCancelBlock)(void);


@interface ZJDatePickerView : ZJPickBaseView

/**
 1.显示时间选择器
 
 @param title    标题
 @param dateType pickerView显示类型,
 @param defaultSelValue 默认值
 @param resultBlock 确认回调
 */
+ (void)zj_showDatePickerWithTitle:(NSString *)title
                          dateType:(ZJDatePickerMode)dateType
                   defaultSelValue:(NSString *)defaultSelValue
                       resultBlock:(ZJDateResultBlock)resultBlock;
/**
 2.显示时间选择器（支持 设置自动选择、取消选择的回调）
 
 @param title    标题
 @param dateType pickerView显示类型,
 @param defaultSelValue 默认值
 @param isAutoSelect 是否自动选择
 @param resultBlock 确认回调
 @param cancelBlock 取消回调
 */
+ (void)zj_showDatePickerWithTitle:(NSString *)title
                          dateType:(ZJDatePickerMode)dateType
                   defaultSelValue:(NSString *)defaultSelValue
                      isAutoSelect:(BOOL)isAutoSelect
                       resultBlock:(ZJDateResultBlock)resultBlock
                       cancelBlock:(ZJDateCancelBlock)cancelBlock;


/**
 3.显示时间选择器（支持 设置自动选择、最大值、最小值、取消选择的回调）
 
 @param title    标题
 @param dateType pickerView显示类型,
 @param defaultSelValue 默认值
 @param minDate 时间最小值
 @param maxDate 时间最大值
 @param isAutoSelect 是否自动选择
 @param resultBlock 确认回调
 @param cancelBlock 取消回调
 */
+ (void)zj_showDatePickerWithTitle:(NSString *)title
                          dateType:(ZJDatePickerMode)dateType
                   defaultSelValue:(NSString *)defaultSelValue
                           minDate:(NSDate *)minDate
                           maxDate:(NSDate *)maxDate
                      isAutoSelect:(BOOL)isAutoSelect
                       resultBlock:(ZJDateResultBlock)resultBlock
                       cancelBlock:(ZJDateCancelBlock)cancelBlock;

/**
 4.显示时间选择器（支持 设置自动选择、最大值、最小值、自定义分割线颜色、行高、取消选择的回调）

 @param title    标题
 @param dateType pickerView显示类型,
 @param defaultSelValue 默认值
 @param minDate 时间最小值
 @param maxDate 时间最大值
 @param isAutoSelect 是否自动选择
 @param lineColor 分割线的颜色,默认为灰色
 @param rowHeight 行高
 @param resultBlock 确认回调
 @param cancelBlock 取消回调
 */
+ (void)zj_showDatePickerWithTitle:(NSString *)title
                          dateType:(ZJDatePickerMode)dateType
                   defaultSelValue:(NSString *)defaultSelValue
                           minDate:(NSDate *)minDate
                           maxDate:(NSDate *)maxDate
                      isAutoSelect:(BOOL)isAutoSelect
                         lineColor:(UIColor *)lineColor
                         rowHeight:(CGFloat)rowHeight
                       resultBlock:(ZJDateResultBlock)resultBlock
                       cancelBlock:(ZJDateCancelBlock)cancelBlock;

@end
