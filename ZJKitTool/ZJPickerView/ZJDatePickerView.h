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

typedef enum : NSUInteger {
    ZJDatePickerStyleSystem,    //  系统样式 UIDatePicker 类
    ZJDatePickerStyleCustom     //  自定义样式 UIPickerView 类
} ZJDatePickerStyle;

typedef void(^ZJDateResultBlock)(NSString * _Nonnull selectValue);
typedef void(^ZJDateCancelBlock)(void);


@interface ZJDatePickerView : ZJPickBaseView

/** 显示类型 */
@property (nonatomic, assign) ZJDatePickerMode pickerMode;
/** 时间选择器的类型 */
@property (nonatomic, assign) ZJDatePickerStyle pickerStyle;
/** 限制最小日期 */
@property (nonatomic, strong) NSDate * _Nullable minLimitDate;
/** 限制最大日期 */
@property (nonatomic, strong) NSDate * _Nullable maxLimitDate;
/** 默认值 */
@property (nonatomic, copy) NSString * _Nullable defaultValue;
/// 选中行文本的颜色
@property (nonatomic, strong) UIColor  * _Nullable selecteRowTextColor;
/// 选中行背景颜色
@property (nonatomic, strong) UIColor  * _Nullable selectRowBGColor;
/// 行高
@property (nonatomic, assign) CGFloat  rowHeight;
/** 选中后的回调 */
@property (nonatomic, copy) ZJDateResultBlock _Nullable resultBlock;
/** 取消选择的回调 */
@property (nonatomic, copy) ZJDateCancelBlock _Nullable cancelBlock;
/**  是否显示中文名 */
@property (nonatomic, assign) BOOL isShowChinese;
/// 右边按钮颜色
@property (nonatomic, strong) UIColor               * _Nullable rightBtnTitleColor;
/// 左边按钮颜色
@property (nonatomic, strong) UIColor               * _Nullable leftBtnTitleColor;
/// 弹穿是否需要动画
@property (nonatomic, assign) bool                  animation;
/**文本语言*/
@property (nonatomic, copy) NSString                * _Nullable language;
/**文本语言*/
@property (nonatomic, copy) NSString                * _Nullable title;

/// 是否开启自动选择
@property (nonatomic, assign) BOOL                  isAutoSelect;
/** 选择的日期的格式 */
@property (nonatomic, copy) NSString * _Nullable selectDateFormatter;
- (instancetype _Nullable )initWithPickerMode:(ZJDatePickerMode)pickerMode;

-(void)showView;
@end
