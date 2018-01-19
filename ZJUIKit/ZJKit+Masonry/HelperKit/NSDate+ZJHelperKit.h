//
//  NSDate+ZJHelperKit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//



@interface NSDate (ZJHelperKit)



//--------------------------------------------//
// Get day, month, year, hour, minute, second
//--------------------------------------------//
- (NSUInteger)zj_day;
- (NSUInteger)zj_month;
- (NSUInteger)zj_year;
- (NSUInteger)zj_hour;
- (NSUInteger)zj_minute;
- (NSUInteger)zj_second;
+ (NSUInteger)zj_day:(NSDate *)zj_date;
+ (NSUInteger)zj_month:(NSDate *)zj_date;
+ (NSUInteger)zj_year:(NSDate *)zj_date;
+ (NSUInteger)zj_hour:(NSDate *)zj_date;
+ (NSUInteger)zj_minute:(NSDate *)zj_date;
+ (NSUInteger)zj_second:(NSDate *)zj_date;

/**
 *
 *    Get how many days in the year.
 *
 *    @return The days of the year.
 */
- (NSUInteger)zj_daysInYear;

/**
 *
 *    Get how many days in the specified year.
 *
 *    @param zj_date    The specified date
 *
 *    @return The days of the year.
 */
+ (NSUInteger)zj_daysInYear:(NSDate *)zj_date;

/**
 *
 *    Judge whether this year is leap year or not.
 *
 *    @return YES means leap year, otherwise NO.
 */
- (BOOL)zj_isLeapYear;

/**
 *
 *    Judge whether the specified date of year is leap year or not.
 *
 *    @param zj_date    The specified date.
 *
 *    @return YES means leap year, otherwise NO.
 */
+ (BOOL)zj_isLeapYear:(NSDate *)zj_date;

/**
 *
 *    Judge whether this year is leap year or not.
 *
 *    @param year    The specified year
 *
 *    @return YES means leap year, otherwise NO.
 */
+ (BOOL)zj_isLeapYearWithYear:(int)year;

/**
 *
 *    Get which week in the year.
 *
 *    @return Current week of year.
 */
- (NSUInteger)zj_weekOfYear;

/**
 *
 *    Get which week in the specified date.
 *
 *    @param zj_date    The specified date to get which week.
 *
 *    @return Current week of the specified year.
 */
+ (NSUInteger)zj_weekOfYear:(NSDate *)zj_date;

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
/**
 *
 *    Convert the date to a time string with yyyy-MM-dd format.
 *
 *    @return The time string with yyyy-MM-dd
 */
- (NSString *)zj_toStringWithFormatYMD;

/**
 *
 *  Convert the date to a time string with yyyy-MM-dd format.
 *
 *    @param zj_date    The specified date to be converted to time string.
 *
 *    @return The time string with yyyy-MM-dd
 */
+ (NSString *)zj_toStringWithFormatYMD:(NSDate *)zj_date;

/**
 *
 *    Get how many weeks in the month. It might have 4, 5, or 6 weeks.
 *
 *    @return The weeks in the month.
 */
- (NSUInteger)zj_howManyWeeksOfMonth;

/**
 *
 *    Get how many weeks in the month. It might have 4, 5, or 6 weeks.
 *
 *    @param zj_date The specified date
 *
 *    @return The weeks in the month of the specified date.
 */
+ (NSUInteger)zj_howManyWeeksOfMonth:(NSDate *)zj_date;

/**
 *
 *    Get the first date of this month.
 *
 *    @return The first date of this month.
 */
- (NSDate *)zj_beginDayOfMonth;

/**
 *
 *    Get the first date of this month.
 *
 *    @param zj_date    The specified date.
 *
 *    @return The first date of this month.
 */
+ (NSDate *)zj_beginDayOfMonth:(NSDate *)zj_date;

/**
 *
 *    Get the last date of this month.
 *
 *    @return The last date of this month.
 */
- (NSDate *)zj_lastDayOfMonth;

/**
 *
 *    Get the last date of the specified month.
 *
 *    @param zj_date    The specified date.
 *
 *    @return The last date of this month.
 */
+ (NSDate *)zj_lastDayOfMonth:(NSDate *)zj_date;

/**
 *
 *    Add days
 *
 *    @param days    The added days.
 *
 *    @return The new date after add days.
 */
- (NSDate *)zj_dateAfterDay:(NSUInteger)days;

/**
 *
 *    Add days to the specified date.
 *
 *    @param zj_date    The spcified date.
 *    @param days            The added days.
 *
 *    @return The new date after adding days.
 */
+ (NSDate *)zj_dateAfterDate:(NSDate *)zj_date day:(NSInteger)days;

/**
 *
 *    Add months to the date.
 *
 *    @param months    The added months.
 *
 *    @return The new date after adding months.
 */
- (NSDate *)zj_dateAfterMonth:(NSUInteger)months;

/**
 *
 *    Add months to the date.
 *
 *    @param zj_date The specified date.
 *    @param months    The added months.
 *
 *    @return The new date after adding months.
 */
+ (NSDate *)zj_dateAfterDate:(NSDate *)zj_date month:(NSInteger)months;

/**
 * 返回numYears年后的日期
 */
/**
 *
 *    Get new date offset numYears.
 *
 *    @param numYears    The
 *
 */
- (NSDate *)zj_offsetYears:(int)numYears;
+ (NSDate *)zj_offsetYears:(int)zj_numYears fromDate:(NSDate *)zj_fromDate;
- (NSDate *)zj_offsetMonths:(int)zj_numMonths;
+ (NSDate *)zj_offsetMonths:(int)zj_numMonths fromDate:(NSDate *)zj_fromDate;
- (NSDate *)zj_offsetDays:(int)zj_numDays;
+ (NSDate *)zj_offsetDays:(int)zj_numDays fromDate:(NSDate *)zj_fromDate;
- (NSDate *)zj_offsetHours:(int)zj_hours;
+ (NSDate *)zj_offsetHours:(int)zj_numHours fromDate:(NSDate *)zj_fromDate;
- (NSUInteger)zj_daysAgo;
+ (NSUInteger)zj_daysAgo:(NSDate *)zj_date;

/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSInteger)zj_weekday;
+ (NSInteger)zj_weekday:(NSDate *)zj_date;

/**
 *  获取星期几(名称)zj_
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)zj_dayFromWeekday;
+ (NSString *)zj_dayFromWeekday:(NSDate *)zj_date;

/**
 *  Is the same date?
 *
 *  @param zj_anotherDate The another date to compare as NSDate
 *  @return Return YES if is same day, NO if not
 */
- (BOOL)zj_isSameDate:(NSDate *)zj_anotherDate;

/**
 *  Is today?
 *
 *  @return Return if self is today
 */
- (BOOL)zj_isToday;

/**
 *  Add days to self
 *
 *  @return Return self by adding the gived days number
 */
- (NSDate *)zj_dateByAddingDays:(NSUInteger)zj_days;

/**
 *  Get the month as a localized string from the given month number
 *
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)zj_monthWithMonthNumber:(NSInteger)zj_month;

/**
 *  Convert date to string with format.
 */
+ (NSString *)zj_stringWithDate:(NSDate *)zj_date format:(NSString *)zj_format;
- (NSString *)zj_stringWithFormat:(NSString *)zj_format;

/**
 * Convert date string to NSDate instance.
 */
+ (NSDate *)zj_dateWithString:(NSString *)zj_string format:(NSString *)zj_format;

/**
 * Get how many days in the month.
 */
- (NSUInteger)zj_daysInMonth:(NSUInteger)zj_month;
+ (NSUInteger)zj_daysInMonth:(NSDate *)zj_date month:(NSUInteger)zj_month;
+ (NSUInteger)zj_dayInYear:(NSUInteger)year month:(NSUInteger)month;

/**
 * Get how many days in the month.
 */
- (NSUInteger)zj_daysInMonth;
+ (NSUInteger)zj_daysInMonth:(NSDate *)zj_date;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)zj_timeInfo;
+ (NSString *)zj_timeInfoWithDate:(NSDate *)zj_date;
+ (NSString *)zj_timeInfoWithDateString:(NSString *)zj_dateString;

/**
 * yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss
 */
- (NSString *)zj_ymdFormat;
- (NSString *)zj_hmsFormat;
- (NSString *)zj_ymdHmsFormat;
+ (NSString *)zj_ymdFormat;
+ (NSString *)zj_hmsFormat;
+ (NSString *)zj_ymdHmsFormat;

+ (NSDateComponents *)zj_dateComponentsWithDate:(NSDate *)date;

/**
 * Convert date to time stamp.
 */
- (NSString *)zj_toTimeStamp;

/**
 * Convert time stamp to date.
 */
+ (NSDate *)zj_toDateWithTimeStamp:(NSString *)timeStamp;


@end
