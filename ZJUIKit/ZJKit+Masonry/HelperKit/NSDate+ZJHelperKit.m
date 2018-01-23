//
//  NSDate+ZJHelperKit.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "NSDate+ZJHelperKit.h"

@implementation NSDate (ZJHelperKit)

- (NSUInteger)zj_day {
    return [NSDate zj_day:self];
}

- (NSUInteger)zj_month {
    return [NSDate zj_month:self];
}

- (NSUInteger)zj_year {
    return [NSDate zj_year:self];
}

- (NSUInteger)zj_hour {
    return [NSDate zj_hour:self];
}

- (NSUInteger)zj_minute {
    return [NSDate zj_minute:self];
}

- (NSUInteger)zj_second {
    return [NSDate zj_second:self];
}

+ (NSUInteger)zj_day:(NSDate *)zj_date {
    return [[self zj_dateComponentsWithDate:zj_date] day];
}

+ (NSUInteger)zj_month:(NSDate *)zj_date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth)fromDate:zj_date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit)fromDate:zj_date];
#endif
    
    return [dayComponents month];
}

+ (NSUInteger)zj_year:(NSDate *)zj_date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear)fromDate:zj_date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit)fromDate:zj_date];
#endif
    
    return [dayComponents year];
}

+ (NSUInteger)zj_hour:(NSDate *)zj_date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour)fromDate:zj_date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit)fromDate:zj_date];
#endif
    
    return [dayComponents hour];
}

+ (NSUInteger)zj_minute:(NSDate *)zj_date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute)fromDate:zj_date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit)fromDate:zj_date];
#endif
    
    return [dayComponents minute];
}

+ (NSUInteger)zj_second:(NSDate *)zj_date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond)fromDate:zj_date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit)fromDate:zj_date];
#endif
    
    return [dayComponents second];
}

- (NSUInteger)zj_daysInYear {
    return [NSDate zj_daysInYear:self];
}

+ (NSUInteger)zj_daysInYear:(NSDate *)zj_date {
    return [self zj_isLeapYear:zj_date] ? 366 : 365;
}

- (BOOL)zj_isLeapYear {
    return [NSDate zj_isLeapYear:self];
}

+ (BOOL)zj_isLeapYear:(NSDate *)zj_date {
    int year = (int)[zj_date zj_year];
    return [self zj_isLeapYearWithYear:year];
}

+ (BOOL)zj_isLeapYearWithYear:(int)year {
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    
    return NO;
}

- (NSString *)zj_toStringWithFormatYMD {
    return [NSDate zj_toStringWithFormatYMD:self];
}

+ (NSString *)zj_toStringWithFormatYMD:(NSDate *)zj_date {
    return [NSString stringWithFormat:@"%ld-%02ld-%02ld",
            (long)[zj_date zj_year],
            (long)[zj_date zj_month],
            (long)[zj_date zj_day]];
}

- (NSUInteger)zj_howManyWeeksOfMonth {
    return [NSDate zj_howManyWeeksOfMonth:self];
}

+ (NSUInteger)zj_howManyWeeksOfMonth:(NSDate *)zj_date {
    return [[zj_date zj_lastDayOfMonth] zj_weekOfYear] - [[zj_date zj_beginDayOfMonth] zj_weekOfYear] + 1;
}

- (NSUInteger)zj_weekOfYear {
    return [NSDate zj_weekOfYear:self];
}

+ (NSUInteger)zj_weekOfYear:(NSDate *)zj_date {
    NSUInteger i;
    NSUInteger year = [zj_date zj_year];
    
    NSDate *lastdate = [zj_date zj_lastDayOfMonth];
    
    for (i = 1;[[lastdate zj_dateAfterDay:-7 * i] zj_year] == year; i++) {
        
    }
    
    return i;
}

- (NSDate *)zj_dateAfterDay:(NSUInteger)zj_day {
    return [NSDate zj_dateAfterDate:self day:zj_day];
}

+ (NSDate *)zj_dateAfterDate:(NSDate *)zj_date day:(NSInteger)zj_day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:zj_day];
    
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:zj_date options:0];
    
    return dateAfterDay;
}

- (NSDate *)zj_dateAfterMonth:(NSUInteger)zj_month {
    return [NSDate zj_dateAfterDate:self month:zj_month];
}

+ (NSDate *)zj_dateAfterDate:(NSDate *)zj_date month:(NSInteger)zj_month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:zj_month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:zj_date options:0];
    
    return dateAfterMonth;
}

- (NSDate *)zj_beginDayOfMonth {
    return [NSDate zj_beginDayOfMonth:self];
}

+ (NSDate *)zj_beginDayOfMonth:(NSDate *)zj_date {
    return [self zj_dateAfterDate:zj_date day:-[zj_date zj_day] + 1];
}

- (NSDate *)zj_lastDayOfMonth {
    return [NSDate zj_lastDayOfMonth:self];
}

+ (NSDate *)zj_lastDayOfMonth:(NSDate *)zj_date {
    NSDate *lastDate = [self zj_beginDayOfMonth:zj_date];
    return [[lastDate zj_dateAfterMonth:1] zj_dateAfterDay:-1];
}

- (NSUInteger)zj_daysAgo {
    return [NSDate zj_daysAgo:self];
}

+ (NSUInteger)zj_daysAgo:(NSDate *)zj_date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:zj_date
                                                 toDate:[NSDate date]
                                                options:0];
#else
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:zj_date
                                                 toDate:[NSDate date]
                                                options:0];
#endif
    
    return [components day];
}

- (NSInteger)zj_weekday {
    return [NSDate zj_weekday:self];
}

+ (NSInteger)zj_weekday:(NSDate *)zj_date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:zj_date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
}

- (NSString *)zj_dayFromWeekday {
    return [NSDate zj_dayFromWeekday:self];
}

+ (NSString *)zj_dayFromWeekday:(NSDate *)zj_date {
    switch([zj_date zj_weekday]) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return @"";
}

- (BOOL)zj_isSameDate:(NSDate *)zj_anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:zj_anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}

- (BOOL)zj_isToday {
    return [self zj_isSameDate:[NSDate date]];
}

- (NSDate *)zj_dateByAddingDays:(NSUInteger)zj_days {
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = zj_days;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
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
+ (NSString *)zj_monthWithMonthNumber:(NSInteger)zj_month {
    switch(zj_month) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)zj_stringWithDate:(NSDate *)zj_date format:(NSString *)zj_format {
    return [zj_date zj_stringWithFormat:zj_format];
}

- (NSString *)zj_stringWithFormat:(NSString *)zj_format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:zj_format];
    [outputFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *retStr = [outputFormatter stringFromDate:self];
    
    return retStr;
}

+ (NSDate *)zj_dateWithString:(NSString *)zj_string format:(NSString *)zj_format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:zj_format];
    [inputFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate *date = [inputFormatter dateFromString:zj_string];
    
    return date;
}

- (NSUInteger)zj_daysInMonth:(NSUInteger)zj_month {
    return [NSDate zj_daysInMonth:self month:zj_month];
}

+ (NSUInteger)zj_dayInYear:(NSUInteger)year month:(NSUInteger)month {
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [self zj_isLeapYearWithYear:(int)year] ? 29 : 28;
    }
    
    return 30;
}

+ (NSUInteger)zj_daysInMonth:(NSDate *)zj_date month:(NSUInteger)zj_month {
    switch (zj_month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [zj_date zj_isLeapYear] ? 29 : 28;
    }
    return 30;
}

- (NSUInteger)zj_daysInMonth {
    return [NSDate zj_daysInMonth:self];
}

+ (NSUInteger)zj_daysInMonth:(NSDate *)zj_date {
    return [self zj_daysInMonth:zj_date month:[zj_date zj_month]];
}

- (NSString *)zj_timeInfo {
    return [NSDate zj_timeInfoWithDate:self];
}

+ (NSString *)zj_timeInfoWithDate:(NSDate *)zj_date {
    return [self zj_timeInfoWithDateString:[self zj_stringWithDate:zj_date format:[self zj_ymdHmsFormat]]];
}

+ (NSString *)zj_timeInfoWithDateString:(NSString *)zj_dateString {
    NSDate *date = [self zj_dateWithString:zj_dateString format:[self zj_ymdHmsFormat]];
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    int month = (int)([curDate zj_month] - [date zj_month]);
    int year = (int)([curDate zj_year] - [date zj_year]);
    int day = (int)([curDate zj_day] - [date zj_day]);
    
    NSTimeInterval retTime = 1.0;
    if (time < 3600) { // 小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    } else if (time < 3600 * 24) { // 小于一天，也就是今天
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    } else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDate zj_month] == 1 && [date zj_month] == 12)) {
        int retDay = 0;
        if (year == 0) { // 同年
            if (month == 0) { // 同月
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 获取发布日期中，该月有多少天
            int totalDays = (int)[self zj_daysInMonth:date month:[date zj_month]];
            
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDate zj_day] + (totalDays - (int)[date zj_day]);
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    } else  {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 隔年
            int month = (int)[curDate zj_month];
            int preMonth = (int)[date zj_month];
            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                return @"1年前";
            }
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    
    return @"1小时前";
}

- (NSString *)zj_ymdFormat {
    return [NSDate zj_ymdFormat];
}

- (NSString *)zj_hmsFormat {
    return [NSDate zj_hmsFormat];
}

- (NSString *)zj_ymdHmsFormat {
    return [NSDate zj_ymdHmsFormat];
}

+ (NSString *)zj_ymdFormat {
    return @"yyyy-MM-dd";
}

+ (NSString *)zj_hmsFormat {
    return @"HH:mm:ss";
}

+ (NSString *)zj_ymdHmsFormat {
    return [NSString stringWithFormat:@"%@ %@", [self zj_ymdFormat], [self zj_hmsFormat]];
}

- (NSDate *)zj_offsetYears:(int)zj_numYears {
    return [NSDate zj_offsetYears:zj_numYears fromDate:self];
}

+ (NSDate *)zj_offsetYears:(int)zj_numYears fromDate:(NSDate *)zj_fromDate {
    if (zj_fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:zj_numYears];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:zj_fromDate
                                     options:0];
}

- (NSDate *)zj_offsetMonths:(int)zj_numMonths {
    return [NSDate zj_offsetMonths:zj_numMonths fromDate:self];
}

+ (NSDate *)zj_offsetMonths:(int)zj_numMonths fromDate:(NSDate *)zj_fromDate {
    if (zj_fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:zj_numMonths];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:zj_fromDate
                                     options:0];
}

- (NSDate *)zj_offsetDays:(int)zj_numDays {
    return [NSDate zj_offsetDays:zj_numDays fromDate:self];
}

+ (NSDate *)zj_offsetDays:(int)zj_numDays fromDate:(NSDate *)zj_fromDate {
    if (zj_fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:zj_numDays];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:zj_fromDate
                                     options:0];
}

- (NSDate *)zj_offsetHours:(int)zj_hours {
    return [NSDate zj_offsetHours:zj_hours fromDate:self];
}

+ (NSDate *)zj_offsetHours:(int)zj_numHours fromDate:(NSDate *)zj_fromDate {
    if (zj_fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:zj_numHours];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:zj_fromDate
                                     options:0];
}

+ (NSDateComponents *)zj_dateComponentsWithDate:(NSDate *)date {
    NSCalendar *calendar = nil;
    NSUInteger flags = 0;
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour
    | NSCalendarUnitMinute | NSCalendarUnitSecond;
#else
    calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit
    | NSMinuteCalendarUnit | NSSecondCalendarUnit;
#endif
    [calendar setTimeZone:[NSTimeZone systemTimeZone]];
    
    return [calendar components:flags fromDate:date];
}

- (NSString *)zj_toTimeStamp {
    return [NSString stringWithFormat:@"%lf", [self timeIntervalSince1970]];
}

+ (NSDate *)zj_toDateWithTimeStamp:(NSString *)timeStamp {
    NSString *arg = timeStamp;
    
    if (![timeStamp isKindOfClass:[NSString class]]) {
        arg = [NSString stringWithFormat:@"%@", timeStamp];
    }
    
    if (arg.length > 10) {
        arg = [arg substringToIndex:10];
    }
    
    NSTimeInterval time = [arg doubleValue];
    return [NSDate dateWithTimeIntervalSince1970:time];
}


// 获取当前的时间戳(秒为单位)
+(NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
    
}

// 根据出生日期计算年龄
+(NSString *)dateToCalculateAge:(NSDate *)bornDate{
    //获得当前系统时间
    NSDate *currentDate = [NSDate date];
    //获得当前系统时间与出生日期之间的时间间隔
    NSTimeInterval time = [currentDate timeIntervalSinceDate:bornDate];
    //时间间隔以秒作为单位,求年的话除以60*60*24*356
    int age = ((int)time)/(3600*24*365);
    return [NSString stringWithFormat:@"%d",age];
}

+ (NSDate *)dateWithString:(NSString *)str format:(NSString *)formating
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formating];
    return [dateFormatter dateFromString:str];
}

+ (NSString *)dateToString:(NSDate *)date format:(NSString *)formating
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formating];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)dateWithTimeInterval:(NSTimeInterval)interval format:(NSString *)formating
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formating];
    return [dateFormatter stringFromDate:date];
}

+ (NSTimeInterval)timeIntervalWithString:(NSString *)str format:(NSString *)formating
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formating];
    NSDate *date = [dateFormatter dateFromString:str];
    return [date timeIntervalSince1970];
}

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects:@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday-1];
}
//根据时间戳获取星期几
+ (NSString *)getWeekDayFordate:(NSTimeInterval)dateTime
{
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:dateTime];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:newDate];
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}

+ (NSDate *)dateWithStringMuitiform:(NSString *)str
{
    NSDate *time = nil;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    time = [dateFormatter dateFromString:str];
    if (time == nil) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        time = [dateFormatter dateFromString:str];
    }
    if (time == nil) {
        [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
        time = [dateFormatter dateFromString:str];
    }
    if (time == nil) {
        [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        time = [dateFormatter dateFromString:str];
    }
    if (time == nil) {
        [dateFormatter setDateFormat:@"yyyyMMdd HH:mm:ss"];
        time = [dateFormatter dateFromString:str];
    }
    if (time == nil) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
        time = [dateFormatter dateFromString:str];
    }
    if (time == nil) {
        [dateFormatter setDateFormat:@"MMdd"];
        time = [dateFormatter dateFromString:str];
    }
    return time;
}

+(NSString *)dateToSpecialTime:(NSDate *)time{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDate *nowDate = [NSDate date];
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init] ;
    [inputFormatter setDateStyle:NSDateFormatterMediumStyle];
    [inputFormatter setTimeStyle:NSDateFormatterShortStyle];
    [inputFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    
    NSDateComponents *nowCom = [calendar components:unitFlags fromDate:nowDate];
    NSDateComponents *comCom = [calendar components:unitFlags fromDate:time];
    
    NSString *returnStr =@"";
    
    //如果为同一天
    if (([nowCom day] == [comCom day]) && ([nowCom month] == [comCom month]) && ([nowCom year]  == [comCom year])) {
        [inputFormatter setDateFormat:@"HH:mm"];
        returnStr = [inputFormatter stringFromDate:time];
    }else if(([nowCom year]  == [comCom year]) && ([nowCom day] == [comCom day] -1) && ([nowCom month] == [comCom month])){
        [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        returnStr = [inputFormatter stringFromDate:time];
    }else if(([nowCom year]  == [comCom year])){
        [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        returnStr = [inputFormatter stringFromDate:time];
    }else{
        [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        returnStr = [inputFormatter stringFromDate:time];
        
    }
    return returnStr;
}

+ (NSString *)timeWithSec:(int)totalSeconds format:(NSString*)format{
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    if (format.length == 0) {
        return @"00:00:00";
    }else{
        if ([format isEqualToString:@"HH:mm:ss"]) {
            return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
        }else if ([format isEqualToString:@"mm:ss"]){
            return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
        }
    }
    return @"00:00:00";
}

+ (NSString *) compareCurrentTime:(NSTimeInterval)time
{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:formating];
    //
    //
    //    //把字符串转为NSdate
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSDate *timeDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:date]];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    timeInterval = timeInterval; //- 8*60*60;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}


@end
