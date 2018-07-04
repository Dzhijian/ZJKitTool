//
//  ZJDatePickerView.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/7/4.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJPickBaseView.h"


typedef enum : NSUInteger {
    // 以下四个为系统自带样式,不能修改文字颜色和背景颜色
    ZJDatePickerModeTime,           // UIDatePickerModeTime             HH:mm
    ZJDatePickerModeDate,           // UIDatePickerModeDate             yyyy-MM-dd
    ZJDatePickerModeDateAndTime,    // UIDatePickerModeDateAndTime      yyyy-MM-dd HH:mm
    ZJDatePickerModeCountDownTimer, // UIDatePickerModeCountDownTimer   HH:mm
    
    // 以下是自定义样式,可以修改文本颜色,背景颜色,行高等
    ZJDatePickerModeYMDHM,      // 年月日时分    yyyy-MM-dd HH:mm
    ZJDatePickerModeMDHM,       // 月日时分      MM-dd HH:mm
    ZJDatePickerModeYMD,        // 年月日        yyyy-MM-dd
    ZJDatePickerModeYM,         // 年月         yyyy-MM
    ZJDatePickerModeY,          // 年           yyyy
    ZJDatePickerModeMD,         // 月日          MM-dd
    ZJDatePickerModeHM          // 时分          HH:mm
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

/**
 5.显示时间选择器（支持 设置自动选择、最大值、最小值、自定义分割线颜色、行高、按钮的文本颜色、取消选择的回调）
 
 @param title    标题
 @param dateType pickerView显示类型,
 @param defaultSelValue 默认值
 @param minDate 时间最小值
 @param maxDate 时间最大值
 @param isAutoSelect 是否自动选择
 @param lineColor 分割线的颜色,默认为灰色
 @param rowHeight 行高
 @param leftBtnTitleColor 左边的按钮颜色
 @param rightBtnTitleColor 右边的按钮颜色
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
                 leftBtnTitleColor:(UIColor *)leftBtnTitleColor
                rightBtnTitleColor:(UIColor *)rightBtnTitleColor
                       resultBlock:(ZJDateResultBlock)resultBlock
                       cancelBlock:(ZJDateCancelBlock)cancelBlock;


/**
 6.显示时间选择器（支持 设置自动选择、最大值、最小值、自定义分割线颜色、选中文本行颜色、行高、按钮的颜色、取消选择的回调）
 
 @param title    标题
 @param dateType pickerView显示类型,
 @param defaultSelValue 默认值
 @param minDate 时间最小值
 @param maxDate 时间最大值
 @param isAutoSelect 是否自动选择
 @param lineColor 分割线的颜色,默认为灰色
 @param rowHeight 行高
 @param leftBtnTitleColor 左边的按钮颜色
 @param rightBtnTitleColor 右边的按钮颜色
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
                 leftBtnTitleColor:(UIColor *)leftBtnTitleColor
                rightBtnTitleColor:(UIColor *)rightBtnTitleColor
               selecteRowTextColor:(UIColor *)selecteRowTextColor
                  selectRowBGColor:(UIColor *)selectRowBGColor
                       resultBlock:(ZJDateResultBlock)resultBlock
                       cancelBlock:(ZJDateCancelBlock)cancelBlock;
@end
