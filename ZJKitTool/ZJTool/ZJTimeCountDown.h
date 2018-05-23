//
//  ZJTimeCountDown.h
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

#import <Foundation/Foundation.h>

typedef void(^ZJTimeDownCompleteBlock)(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second);

@interface ZJTimeCountDown : NSObject



/**
 * 单例创建ZJTimeCountDown，适用Cell中的倒计时，
 * 单个倒计时最好使用 alloc init 创建，不要使用单例，避免退出页面时，倒计时没有及时销毁
 
 @return ZJTimeCountDown
 */
+(instancetype)ShareManager;

/**
 * 用NSDate日期倒计时

 @param startDate 开始时间
 @param endDate 结束时间
 @param completeBlock 倒计时结束的回调
 */
-(void)zj_timeCountDownWithStartDate:(NSDate *)startDate
                             endDate:(NSDate *)endDate
                       completeBlock:(ZJTimeDownCompleteBlock)completeBlock;
/**
 * 用时间戳倒计时
 
 @param startTimeStamp 开始时间
 @param endTimeStamp 结束时间
 @param completeBlock 倒计时结束的回调
 */
-(void)zj_timeCountDownWithStartTimeStamp:(long long)startTimeStamp
                             endTimeStamp:(long long)endTimeStamp
                            completeBlock:(ZJTimeDownCompleteBlock)completeBlock;


/**
 * 用秒做倒计时

 @param secondTime 倒计时秒数
 @param completeBlock 倒计时完成回调
 */
-(void)zj_timeCountDownWithSecondTime:(long long)secondTime
                          completeBlock:(ZJTimeDownCompleteBlock)completeBlock;



/**
 * 每秒走一次，回调block

 @param PER_SECBlock 回调
 */
-(void)zj_timeCountDownWithPER_SECBlock:(void (^)(void))PER_SECBlock;

/**
 * 当前时间与结束时间的对比

 @param timeString 时间String
 @return timeString
 */

-(NSString *)zj_timeGetNowTimeWithString:(NSString *)timeString;
/**
 * 当前时间与结束时间的对比,返回天/时/分/秒
 
 @param timeString 时间String

 */

-(void)zj_timeGetNowTimeWithEndString:(NSString *)timeString
                        completeBlock:(ZJTimeDownCompleteBlock)completeBlock;


/**
 * 将时间戳转换为NSDate

 @param longlongValue 时间戳
 @return NSDate
 */
-(NSDate *)zj_timeDateWithLongLong:(long long)longlongValue;

/**
 * 根据传入的年份和月份获得该月份的天数
 *
 * @param year
 *            年份-正整数
 * @param month
 *            月份-正整数
 * @return 返回天数
 */
-(NSInteger)zj_getDayNumberWithYear:(NSInteger )year month:(NSInteger )month;

/**
 * 主动销毁定时器
 */
-(void)zj_timeDestoryTimer;

@end
