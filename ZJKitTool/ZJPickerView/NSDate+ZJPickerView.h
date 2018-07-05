//
//  NSDate+ZJPickerView.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/7/4.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define ZJPickerViewDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)
@interface NSDate (ZJPickerView)
/// 获取指定date的详细信息
@property (readonly) NSInteger zj_year;    // 年
@property (readonly) NSInteger zj_month;   // 月
@property (readonly) NSInteger zj_day;     // 日
@property (readonly) NSInteger zj_hour;    // 时
@property (readonly) NSInteger zj_minute;  // 分
@property (readonly) NSInteger zj_second;  // 秒
@property (readonly) NSInteger zj_weekday; // 星期

/** 创建 date */
/** yyyy */
+ (nullable NSDate *)zj_setYear:(NSInteger)year;
/** yyyy-MM */
+ (nullable NSDate *)zj_setYear:(NSInteger)year month:(NSInteger)month;
/** yyyy-MM-dd */
+ (nullable NSDate *)zj_setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
/** yyyy-MM-dd HH:mm */
+ (nullable NSDate *)zj_setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute;
/** MM-dd HH:mm */
+ (nullable NSDate *)zj_setMonth:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute;
/** MM-dd */
+ (nullable NSDate *)zj_setMonth:(NSInteger)month day:(NSInteger)day;
/** HH:mm */
+ (nullable NSDate *)zj_setHour:(NSInteger)hour minute:(NSInteger)minute;

/** yyyy */
+ (nullable NSDate *)setYear:(NSInteger)year ZJPickerViewDeprecated("过期提醒：请使用带zj前缀的方法");
/** yyyy-MM */
+ (nullable NSDate *)setYear:(NSInteger)year month:(NSInteger)month ZJPickerViewDeprecated("过期提醒：请使用带zj前缀的方法");
/** yyyy-MM-dd */
+ (nullable NSDate *)setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day ZJPickerViewDeprecated("过期提醒：请使用带zj前缀的方法");
/** yyyy-MM-dd HH:mm */
+ (nullable NSDate *)setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute ZJPickerViewDeprecated("过期提醒：请使用带zj前缀的方法");
/** MM-dd HH:mm */
+ (nullable NSDate *)setMonth:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute ZJPickerViewDeprecated("过期提醒：请使用带zj前缀的方法");
/** MM-dd */
+ (nullable NSDate *)setMonth:(NSInteger)month day:(NSInteger)day ZJPickerViewDeprecated("过期提醒：请使用带zj前缀的方法");
/** HH:mm */
+ (nullable NSDate *)setHour:(NSInteger)hour minute:(NSInteger)minute ZJPickerViewDeprecated("过期提醒：请使用带zj前缀的方法");

/** 日期和字符串之间的转换：NSDate --> NSString */
+ (nullable  NSString *)zj_getDateString:(NSDate *)date format:(NSString *)format;
/** 日期和字符串之间的转换：NSString --> NSDate */
+ (nullable  NSDate *)zj_getDate:(NSString *)dateString format:(NSString *)format;
/** 获取某个月的天数（通过年月求每月天数）*/
+ (NSUInteger)zj_getDaysInYear:(NSInteger)year month:(NSInteger)month;

/**  获取 日期加上/减去某天数后的新日期 */
- (nullable NSDate *)zj_getNewDate:(NSDate *)date addDays:(NSTimeInterval)days;

/**
 *  比较两个时间大小（可以指定比较级数，即按指定格式进行比较）
 */
- (NSComparisonResult)zj_compare:(NSDate *)targetDate format:(NSString *)format;
@end
NS_ASSUME_NONNULL_END
