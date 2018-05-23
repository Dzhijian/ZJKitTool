//
//  ZJTimeCountDown.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/25.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

/**
 *  ZJKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下,给个Star。😆
 */

#import "ZJTimeCountDown.h"


@interface ZJTimeCountDown()

@property(nonatomic ,strong) dispatch_source_t timer;
@property(nonatomic ,strong) NSDateFormatter *dateFormatter;

@end

@implementation ZJTimeCountDown


+(instancetype)ShareManager{
    static dispatch_once_t onceToken;
    static ZJTimeCountDown *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[ZJTimeCountDown alloc]init];
    });
    return manager;
}

-(instancetype)init{
    if (self = [super init]) {
        self.dateFormatter = [[NSDateFormatter alloc]init];
        [self.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
        [self.dateFormatter setTimeZone:localTimeZone];
    }
    return self;
}
// 倒计时 参数用NSDate
-(void)zj_timeCountDownWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate completeBlock:(ZJTimeDownCompleteBlock)completeBlock{
    if (self.timer == nil) {
        NSTimeInterval timeInterval = [endDate timeIntervalSinceDate:startDate];
        __block int timeOut = timeInterval; // 倒计时
        if (timeOut!= 0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);// 每秒执行
            
            dispatch_source_set_event_handler(self.timer, ^{
                if (timeOut<=0) {
                    // 倒计时结束，关闭
                    dispatch_source_cancel(self.timer);
                    self.timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(0,0,0,0);
                    });
                }else{
                    int days    = (int)(timeOut/(3600*24));
                    int hours   = (int)((timeOut- days*24*3600)/3600);
                    int minute  = (int)(timeOut- days*24*3600 - hours*3600)/60;
                    int second  = (int)timeOut - days*24*3600 - hours*3600 - minute*60;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(days,hours,minute,second);
                    });
                    timeOut--;
                }
            });
            dispatch_resume(self.timer);
        }
    }
}

// 倒计时 参数用时间戳
-(void)zj_timeCountDownWithStartTimeStamp:(long long)startTimeStamp endTimeStamp:(long long)endTimeStamp completeBlock:(ZJTimeDownCompleteBlock)completeBlock{
    if (self.timer == nil) {
        NSDate *finishDate = [self zj_timeDateWithLongLong:endTimeStamp];
        NSDate *startDate  = [self zj_timeDateWithLongLong:startTimeStamp];
        NSTimeInterval timeInterval =[finishDate timeIntervalSinceDate:startDate];
        __block int timeOut = timeInterval; // 倒计时
        if (timeOut!= 0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);// 每秒执行
            
            dispatch_source_set_event_handler(self.timer, ^{
                if (timeOut<=0) {
                    // 倒计时结束，关闭
                    dispatch_source_cancel(self.timer);
                    self.timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(0,0,0,0);
                    });
                }else{
                    int days    = (int)(timeOut/(3600*24));
                    int hours   = (int)((timeOut- days*24*3600)/3600);
                    int minute  = (int)(timeOut- days*24*3600 - hours*3600)/60;
                    int second  = (int)timeOut - days*24*3600 - hours*3600 - minute*60;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(days,hours,minute,second);
                    });
                    timeOut--;
                }
            });
            dispatch_resume(self.timer);
        }
    }
}

// 倒计时 参数用秒
-(void)zj_timeCountDownWithSecondTime:(long long)secondTime completeBlock:(ZJTimeDownCompleteBlock)completeBlock{
    if (self.timer == nil) {
        NSTimeInterval timeInterval = secondTime;
        __block int timeOut = timeInterval; // 倒计时
        if (timeOut!= 0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);// 每秒执行
            
            dispatch_source_set_event_handler(self.timer, ^{
                if (timeOut<=0) {
                    // 倒计时结束，关闭
                    dispatch_source_cancel(self.timer);
                    self.timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(0,0,0,0);
                    });
                }else{
                    int days    = (int)(timeOut/(3600*24));
                    int hours   = (int)((timeOut- days*24*3600)/3600);
                    int minute  = (int)(timeOut- days*24*3600 - hours*3600)/60;
                    int second  = (int)timeOut - days*24*3600 - hours*3600 - minute*60;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(days,hours,minute,second);
                    });
                    timeOut--;
                }
            });
            dispatch_resume(self.timer);
        }
    }
}

// 倒计时每秒执行一次
-(void)zj_timeCountDownWithPER_SECBlock:(void (^)(void))PER_SECBlock{
    if (self.timer==nil) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(self.timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(self.timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                PER_SECBlock();
            });
        });
        dispatch_resume(self.timer);
    }
}


// 用当前的时间与最后的时间作比较
-(NSString *)zj_timeGetNowTimeWithString:(NSString *)timeString{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 截止时间date格式
    NSDate  *expireDate = [formater dateFromString:timeString];
    NSDate  *nowDate = [NSDate date];
    // 当前时间字符串格式
    NSString *nowDateStr = [formater stringFromDate:nowDate];
    // 当前时间date格式
    nowDate = [formater dateFromString:nowDateStr];
    
    NSTimeInterval timeInterval =[expireDate timeIntervalSinceDate:nowDate];
    
    int days = (int)(timeInterval/(3600*24));
    int hours = (int)((timeInterval-days*24*3600)/3600);
    int minutes = (int)(timeInterval-days*24*3600-hours*3600)/60;
    int seconds = timeInterval-days*24*3600-hours*3600-minutes*60;
    
    NSString *dayStr;NSString *hoursStr;NSString *minutesStr;NSString *secondsStr;
    //天
    dayStr = [NSString stringWithFormat:@"%d",days];
    //小时
    hoursStr = [NSString stringWithFormat:@"%d",hours];
    //分钟
    if(minutes<10)
        minutesStr = [NSString stringWithFormat:@"0%d",minutes];
    else
        minutesStr = [NSString stringWithFormat:@"%d",minutes];
    //秒
    if(seconds < 10)
        secondsStr = [NSString stringWithFormat:@"0%d", seconds];
    else
        secondsStr = [NSString stringWithFormat:@"%d",seconds];
    if (hours<=0&&minutes<=0&&seconds<=0) {
        return @"倒计时已经结束！";
    }
    if (days) {
        return [NSString stringWithFormat:@"%@天 %@小时 %@分 %@秒", dayStr,hoursStr, minutesStr,secondsStr];
    }
    return [NSString stringWithFormat:@"%@小时 %@分 %@秒",hoursStr , minutesStr,secondsStr];
}

-(void)zj_timeGetNowTimeWithEndString:(NSString *)timeString
                        completeBlock:(ZJTimeDownCompleteBlock)completeBlock{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 截止时间date格式
    NSDate  *expireDate = [formater dateFromString:timeString];
    NSDate  *nowDate = [NSDate date];
    // 当前时间字符串格式
    NSString *nowDateStr = [formater stringFromDate:nowDate];
    // 当前时间date格式
    nowDate = [formater dateFromString:nowDateStr];
    
    NSTimeInterval timeInterval =[expireDate timeIntervalSinceDate:nowDate];
    
    int days = (int)(timeInterval/(3600*24));
    int hours = (int)((timeInterval-days*24*3600)/3600);
    int minutes = (int)(timeInterval-days*24*3600-hours*3600)/60;
    int seconds = timeInterval-days*24*3600-hours*3600-minutes*60;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        completeBlock(days,hours,minutes,seconds);
    });
    
}
/**
 * 根据传入的年份和月份获得该月份的天数
 *
 * @param year
 *            年份-正整数
 * @param month
 *            月份-正整数
 * @return 返回天数
 */
-(NSInteger)zj_getDayNumberWithYear:(NSInteger )year month:(NSInteger )month{
    int days[] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
    if (2 == month && 0 == (year % 4) && (0 != (year % 100) || 0 == (year % 400))) {
        days[1] = 29;
    }
    return (days[month - 1]);
}

/**
 * 主动销毁定时器
 */
-(void)zj_timeDestoryTimer{
    if (self.timer) {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
}

// 时间戳转换为NSDate
-(NSDate *)zj_timeDateWithLongLong:(long long)longlongValue{
    long long value = longlongValue/1000;
    NSNumber *time = [NSNumber numberWithLongLong:value];
    //转换成NSTimeInterval
    NSTimeInterval nsTimeInterval = [time longValue];
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:nsTimeInterval];
    return date;
}

-(void)dealloc{
    NSLog(@"%s dealloc",object_getClassName(self));
}
@end
