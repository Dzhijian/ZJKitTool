//
//  ZJDatePickerView.m
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/7/4.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//
/**
 *  ZJKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下,给个Star。😆
 */

#import "ZJDatePickerView.h"
#import "NSDate+ZJPickerView.h"
#import "ZJPickerViewMacro.h"

@interface ZJDatePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    // 记录 年、月、日、时、分 当前选择的位置
    NSInteger _yearIndex;
    NSInteger _monthIndex;
    NSInteger _dayIndex;
    NSInteger _hourIndex;
    NSInteger _minuteIndex;
    UIDatePickerMode _datePickerMode;
}
/** 时间选择器1 */
@property (nonatomic, strong) UIDatePicker *datePicker;
/** 时间选择器2 */
@property (nonatomic, strong) UIPickerView *pickerView;
/// 日期存储数组
@property(nonatomic, strong) NSArray *yearArr;
@property(nonatomic, strong) NSArray *monthArr;
@property(nonatomic, strong) NSArray *dayArr;
@property(nonatomic, strong) NSArray *hourArr;
@property(nonatomic, strong) NSArray *minuteArr;

/** 当前选择的日期 */
@property (nonatomic, strong) NSDate *selectDate;
/** 存取选中行 */
@property (nonatomic,strong) NSMutableDictionary *selectedRowCache;


@end

@implementation ZJDatePickerView


- (instancetype)initWithPickerMode:(ZJDatePickerMode)pickerMode
{
    self = [super init];
    if (self) {
        self.rowHeight              = 35.0f;
        self.isShowChinese          = false;
        self.animation              = true;
        self.pickerMode             = pickerMode;
        self.isAutoSelect           = false;
        self.leftBtnTitleColor      = [UIColor grayColor];
        self.rightBtnTitleColor     = [UIColor grayColor];
        [self setupSelectDateFormatter:pickerMode];

    }
    return self;
}

- (void)setResultBlock:(ZJDateResultBlock)resultBlock{
    _resultBlock = resultBlock;
}

- (void)setCancelBlock:(ZJDateCancelBlock)cancelBlock{
    _cancelBlock = cancelBlock;
}

- (void)setSelecteRowTextColor:(UIColor *)selecteRowTextColor{
    _selecteRowTextColor = selecteRowTextColor;
}

- (void)setSelectRowBGColor:(UIColor *)selectRowBGColor{
    _selectRowBGColor = selectRowBGColor;
}

- (void)setRowHeight:(CGFloat)rowHeight{
    _rowHeight = rowHeight;
}

- (void)setLeftBtnTitleColor:(UIColor *)leftBtnTitleColor{
    _leftBtnTitleColor = leftBtnTitleColor;
    [self.leftBtn setTitleColor:leftBtnTitleColor forState:(UIControlStateNormal)];

}

- (void)setRightBtnTitleColor:(UIColor *)rightBtnTitleColor {
    _rightBtnTitleColor = rightBtnTitleColor;
    [self.rightBtn setTitleColor:rightBtnTitleColor forState:(UIControlStateNormal)];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLab.text  = title;
}

- (void)setAnimation:(bool)animation{
    _animation = animation;
}

- (void)setDefaultValue:(NSString *)defaultValue{
    _defaultValue = defaultValue;
}

- (void)setMinLimitDate:(NSDate *)minLimitDate{
    _minLimitDate = minLimitDate;
}

- (void)setMaxLimitDate:(NSDate *)maxLimitDate{
    _maxLimitDate = maxLimitDate;
}

- (void)setLanguage:(NSString *)language{
    _language = language;
}

- (void)setIsAutoSelect:(BOOL)isAutoSelect{
    _isAutoSelect = isAutoSelect;
}

- (void)setPickerMode:(ZJDatePickerMode)pickerMode{
    _pickerMode = pickerMode;
    [self setupSelectDateFormatter:pickerMode];
}

- (void)setSelectDateFormatter:(NSString *)selectDateFormatter{
    _selectDateFormatter = selectDateFormatter;
    
}
#pragma mark - 处理数据
-(void)dealDate{
    // 设置最小值限制
    if (!self.minLimitDate) {
        if (self.pickerMode == ZJDatePickerModeTime || self.pickerMode == ZJDatePickerModeCountDownTimer || self.pickerMode == ZJDatePickerModeHM) {
            self.pickerMode = ZJDatePickerModeHM;
            self.minLimitDate = [NSDate zj_setHour:0 minute:0];
        }else if (self.pickerMode == ZJDatePickerModeMDHM){
            self.minLimitDate = [NSDate zj_setMonth:1 day:1 hour:0 minute:0];
        }else if (self.pickerMode == ZJDatePickerModeMD){
            self.minLimitDate = [NSDate zj_setMonth:1 day:1];
        }else{
            self.minLimitDate = [NSDate distantPast]; // 遥远的过去的一个时间点
        }
        
    }
    
    // 最大值限制
    if (!self.maxLimitDate) {
        if (self.pickerMode == ZJDatePickerModeTime || self.pickerMode == ZJDatePickerModeCountDownTimer || self.pickerMode == ZJDatePickerModeHM) {
            
            self.maxLimitDate = [NSDate zj_setHour:23 minute:59];
            
        } else if (self.pickerMode == ZJDatePickerModeMDHM) {
            
            self.maxLimitDate = [NSDate zj_setMonth:12 day:31 hour:23 minute:59];
        
        } else if (self.pickerMode == ZJDatePickerModeMD) {
          
            self.maxLimitDate = [NSDate zj_setMonth:12 day:31];
        
        } else {
         
            self.maxLimitDate = [NSDate distantFuture]; // 遥远的未来的一个时间点
        }
    }
    
    BOOL minMOreThanMax = [self.minLimitDate zj_compare:self.maxLimitDate format:self.selectDateFormatter] == NSOrderedDescending;
    
    NSAssert(!minMOreThanMax, @"最小日期不能大于最大日期!");
    
    if (minMOreThanMax) {
        // 如果最小日期大于了最大日期，就忽略两个值
        self.minLimitDate = [NSDate distantPast];
        self.maxLimitDate = [NSDate distantFuture];
    }
    
    if (self.language.length > 0) {
         self.datePicker.locale = [[NSLocale alloc]initWithLocaleIdentifier:self.language];
    }
    
    
    // 默认选中的日期
    
    if (self.defaultValue && self.defaultValue.length > 0) {
        
        NSDate *defaultSelDate  = [NSDate zj_getDate:self.defaultValue format:self.selectDateFormatter];
        if (!defaultSelDate) {
            NSLog(@"参数格式错误！参数 defaultValue 的正确格式是：%@", self.selectDateFormatter);
            NSAssert(defaultSelDate, @"参数格式错误！请检查形参 defaultValue 的格式");
            defaultSelDate = [NSDate date]; // 默认值参数格式错误时，重置/忽略默认值，防止在 Release 环境下崩溃！
        }
        
        if (self.pickerMode == ZJDatePickerModeTime || self.pickerMode == ZJDatePickerModeCountDownTimer || self.pickerMode == ZJDatePickerModeHM) {
            self.selectDate = [NSDate zj_setHour:defaultSelDate.zj_hour minute:defaultSelDate.zj_minute];
        } else if (self.pickerMode == ZJDatePickerModeMDHM) {
            self.selectDate = [NSDate zj_setMonth:defaultSelDate.zj_month day:defaultSelDate.zj_day hour:defaultSelDate.zj_hour minute:defaultSelDate.zj_minute];
        } else if (self.pickerMode == ZJDatePickerModeMD) {
            self.selectDate = [NSDate zj_setMonth:defaultSelDate.zj_month day:defaultSelDate.zj_day];
        } else {
            self.selectDate = defaultSelDate;
        }
    }else {
        // 不设置默认日期，就默认选中今天的日期
        self.selectDate = [NSDate date];
    }
    
    BOOL selectLessThanMin = [self.selectDate zj_compare:self.minLimitDate format:self.selectDateFormatter] == NSOrderedAscending;
    BOOL selectMoreThanMax = [self.selectDate zj_compare:self.maxLimitDate format:self.selectDateFormatter] == NSOrderedDescending;
    NSAssert(!selectLessThanMin, @"默认选择的日期不能小于最小日期！");
    NSAssert(!selectMoreThanMax, @"默认选择的日期不能大于最大日期！");
    if (selectLessThanMin) {
        self.selectDate = self.minLimitDate;
    }
    if (selectMoreThanMax) {
        self.selectDate = self.maxLimitDate;
    }
    
#ifdef DEBUG
    NSLog(@"最小时间date：%@", self.minLimitDate);
    NSLog(@"默认时间date：%@", self.selectDate);
    NSLog(@"最大时间date：%@", self.maxLimitDate);
    
    NSLog(@"最小时间：%@", [NSDate zj_getDateString:self.minLimitDate format:self.selectDateFormatter]);
    NSLog(@"默认时间：%@", [NSDate zj_getDateString:self.selectDate format:self.selectDateFormatter]);
    NSLog(@"最大时间：%@", [NSDate zj_getDateString:self.maxLimitDate format:self.selectDateFormatter]);
#endif
    
    if (self.pickerStyle == ZJDatePickerStyleCustom) {
        [self initDefaultDateArray];
    }
    [self initWithAllView];
    
    // 默认滚动的行
    if (self.pickerStyle == ZJDatePickerStyleSystem) {
        [self.datePicker setDate:self.selectDate animated:NO];
    } else if (self.pickerStyle == ZJDatePickerStyleCustom) {
        [self scrollToSelectDate:self.selectDate animated:NO];
    }
}

- (void)setupSelectDateFormatter:(ZJDatePickerMode)mode{
    switch (mode) {
        case ZJDatePickerModeTime:
        {
            self.selectDateFormatter = @"HH:mm";
            self.pickerStyle = ZJDatePickerStyleSystem;
            _datePickerMode = UIDatePickerModeTime;
        }
            break;
        case ZJDatePickerModeDate:
        {
            self.selectDateFormatter = @"yyyy-MM-dd";
            self.pickerStyle = ZJDatePickerStyleSystem;
            _datePickerMode = UIDatePickerModeDate;
        }
            break;
        case ZJDatePickerModeDateAndTime:
        {
            self.selectDateFormatter = @"yyyy-MM-dd HH:mm";
            self.pickerStyle = ZJDatePickerStyleSystem;
            _datePickerMode = UIDatePickerModeDateAndTime;
        }
            break;
        case ZJDatePickerModeCountDownTimer:
        {
            self.selectDateFormatter = @"HH:mm";
            self.pickerStyle = ZJDatePickerStyleSystem;
            _datePickerMode = UIDatePickerModeCountDownTimer;
        }
            break;
            
        case ZJDatePickerModeYMDHM:
        {
            self.selectDateFormatter = @"yyyy-MM-dd HH:mm";
            self.pickerStyle = ZJDatePickerStyleCustom;
        }
            break;
        case ZJDatePickerModeMDHM:
        {
            self.selectDateFormatter = @"MM-dd HH:mm";
            self.pickerStyle = ZJDatePickerStyleCustom;
        }
            break;
        case ZJDatePickerModeYMD:
        {
            self.selectDateFormatter = @"yyyy-MM-dd";
            self.pickerStyle = ZJDatePickerStyleCustom;
        }
            break;
        case ZJDatePickerModeYM:
        {
            self.selectDateFormatter = @"yyyy-MM";
            self.pickerStyle = ZJDatePickerStyleCustom;
        }
            break;
        case ZJDatePickerModeY:
        {
            self.selectDateFormatter = @"yyyy";
            self.pickerStyle = ZJDatePickerStyleCustom;
        }
            break;
        case ZJDatePickerModeMD:
        {
            self.selectDateFormatter = @"MM-dd";
            self.pickerStyle = ZJDatePickerStyleCustom;
        }
            break;
        case ZJDatePickerModeHM:
        {
            self.selectDateFormatter = @"HH:mm";
            self.pickerStyle = ZJDatePickerStyleCustom;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 初始化子视图
- (void)initWithAllView {
    [super initWithAllView];
    // 添加时间选择器
    if (self.pickerStyle == ZJDatePickerStyleSystem) {
        [self.alertView addSubview:self.datePicker];
        self.datePicker.frame = CGRectMake(0, kZJTopViewHeight + 0.5, self.alertView.frame.size.width, kZJPickerHeight);

    } else if (self.pickerStyle == ZJDatePickerStyleCustom) {
        [self.alertView addSubview:self.pickerView];
    }

}


#pragma mark - 设置日期数据源数组
- (void)initDefaultDateArray {
    // 1. 设置 yearArr 数组
    [self setupYearArr];
    // 2.设置 monthArr 数组
    [self setupMonthArr:self.selectDate.zj_year];
    // 3.设置 dayArr 数组
    [self setupDayArr:self.selectDate.zj_year month:self.selectDate.zj_month];
    // 4.设置 hourArr 数组
    [self setupHourArr:self.selectDate.zj_year month:self.selectDate.zj_month day:self.selectDate.zj_day];
    // 5.设置 minuteArr 数组
    [self setupMinuteArr:self.selectDate.zj_year month:self.selectDate.zj_month day:self.selectDate.zj_day hour:self.selectDate.zj_hour];
    // 根据 默认选择的日期 计算出 对应的索引
    _yearIndex = self.selectDate.zj_year - self.minLimitDate.zj_year;
    _monthIndex = self.selectDate.zj_month - ((_yearIndex == 0) ? self.minLimitDate.zj_month : 1);
    _dayIndex = self.selectDate.zj_day - ((_yearIndex == 0 && _monthIndex == 0) ? self.minLimitDate.zj_day : 1);
    _hourIndex = self.selectDate.zj_hour - ((_yearIndex == 0 && _monthIndex == 0 && _dayIndex == 0) ? self.minLimitDate.zj_hour : 0);
    _minuteIndex = self.selectDate.zj_minute - ((_yearIndex == 0 && _monthIndex == 0 && _dayIndex == 0 && _hourIndex == 0) ? self.minLimitDate.zj_minute : 0);
    
}
#pragma mark - 滚动到指定的时间位置
- (void)scrollToSelectDate:(NSDate *)selectDate animated:(BOOL)animated {
    // 根据 当前选择的日期 计算出 对应的索引
    NSInteger yearIndex = selectDate.zj_year - self.minLimitDate.zj_year;
    NSInteger monthIndex = selectDate.zj_month - ((yearIndex == 0) ? self.minLimitDate.zj_month : 1);
    NSInteger dayIndex = selectDate.zj_day - ((yearIndex == 0 && monthIndex == 0) ? self.minLimitDate.zj_day : 1);
    NSInteger hourIndex = selectDate.zj_hour - ((yearIndex == 0 && monthIndex == 0 && dayIndex == 0) ? self.minLimitDate.zj_hour : 0);
    NSInteger minuteIndex = selectDate.zj_minute - ((yearIndex == 0 && monthIndex == 0 && dayIndex == 0 && hourIndex == 0) ? self.minLimitDate.zj_minute : 0);
    
    NSArray *indexArr = [NSArray array];
    if (self.pickerMode == ZJDatePickerModeYMDHM) {
        indexArr = @[@(yearIndex), @(monthIndex), @(dayIndex), @(hourIndex), @(minuteIndex)];
    } else if (self.pickerMode == ZJDatePickerModeMDHM) {
        indexArr = @[@(monthIndex), @(dayIndex), @(hourIndex), @(minuteIndex)];
    } else if (self.pickerMode == ZJDatePickerModeYMD) {
        indexArr = @[@(yearIndex), @(monthIndex), @(dayIndex)];
    } else if (self.pickerMode == ZJDatePickerModeYM) {
        indexArr = @[@(yearIndex), @(monthIndex)];
    } else if (self.pickerMode == ZJDatePickerModeY) {
        indexArr = @[@(yearIndex)];
    } else if (self.pickerMode == ZJDatePickerModeMD) {
        indexArr = @[@(monthIndex), @(dayIndex)];
    } else if (self.pickerMode == ZJDatePickerModeHM) {
        indexArr = @[@(hourIndex), @(minuteIndex)];
    }
    for (NSInteger i = 0; i < indexArr.count; i++) {
        
        [self.pickerView selectRow:[indexArr[i] integerValue] inComponent:i animated:animated];
        
        //保存选中的行
        [self.selectedRowCache setObject:@([indexArr[i] integerValue]) forKey:@(i)];
    }
}
#pragma mark - UIPickerViewDelegate,UIPickerViewDataSource
// pickerView 有多少列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    switch (self.pickerMode) {
        case ZJDatePickerModeYMDHM:
            return 5;
            break;
        case ZJDatePickerModeMDHM:
            return 4;
            break;
        case ZJDatePickerModeYMD:
            return 3;
            break;
        case ZJDatePickerModeYM:
            return 2;
            break;
        case ZJDatePickerModeY:
            return 1;
            break;
        case ZJDatePickerModeMD:
            return 2;
            break;
        case ZJDatePickerModeHM:
            return 2;
            break;
        
        default:
            break;
    }
    return 0;
}
// pickerView 表盘上有多少行

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray * rowsArr = [NSArray array];
    switch (self.pickerMode) {
        case ZJDatePickerModeYMDHM:
            rowsArr = @[@(self.yearArr.count), @(self.monthArr.count), @(self.dayArr.count), @(self.hourArr.count), @(self.minuteArr.count)];
            break;
        case ZJDatePickerModeMDHM:
            rowsArr = @[@(self.monthArr.count), @(self.dayArr.count), @(self.hourArr.count), @(self.minuteArr.count)];
            break;
        case ZJDatePickerModeYMD:
           rowsArr = @[@(self.yearArr.count), @(self.monthArr.count), @(self.dayArr.count)];
            break;
        case ZJDatePickerModeYM:
            rowsArr = @[@(self.yearArr.count), @(self.monthArr.count)];
            break;
        case ZJDatePickerModeY:
            rowsArr = @[@(self.yearArr.count)];
            break;
        case ZJDatePickerModeMD:
            rowsArr = @[@(self.monthArr.count), @(self.dayArr.count)];
            break;
        case ZJDatePickerModeHM:
            rowsArr = @[@(self.hourArr.count), @(self.minuteArr.count)];
            break;
            
        default:
            break;
    }
    return [rowsArr[component] integerValue];
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    //设置分割线的颜色
//    if (self.lineColor) {
//        // 设置分割线的颜色
//        ((UIView *)[pickerView.subviews objectAtIndex:1]).backgroundColor = self.lineColor;
//        ((UIView *)[pickerView.subviews objectAtIndex:2]).backgroundColor = self.lineColor;
//    }
    
    // 设置选中行的背景色
    if (self.selectRowBGColor) {
        [self setUpPickerView:pickerView customSelectedBGRowColor:self.selectRowBGColor];
    }
    
    UILabel *label = (UILabel *)view;
    if (!label) {
        label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:20.0f * kScaleFit];
        // 字体自适应属性
        label.adjustsFontSizeToFitWidth = YES;
        // 自适应最小字体缩放比例
        label.minimumScaleFactor = 0.5f;
        
        NSInteger selected = [(NSNumber *)[self.selectedRowCache objectForKey:@(component)] integerValue];
        // 设置选中行的文本颜色
        if (self.selecteRowTextColor && selected == row) {
            [label setTextColor:self.selecteRowTextColor];
        };
    }
    
    [self setDateLabelText:label component:component row:row];
    
    return label;
}

// 设置行高
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return self.rowHeight * kScaleFit;
}

#pragma mark - 配置背景色
- (void)setUpPickerView:(UIPickerView *)pickerView customSelectedBGRowColor:(UIColor *)color
{
    NSArray *subviews = pickerView.subviews;
    if (!(subviews.count > 0)) {
        return;
    }
    if (!color) {
        return;
    }
    NSArray *coloms = subviews.firstObject;
    if (coloms) {
        NSArray *subviewCache = [coloms valueForKey:@"subviewCache"];
        if (subviewCache.count > 0) {
            UIView *middleContainerView = [subviewCache.firstObject valueForKey:@"middleContainerView"];
            if (middleContainerView) {
                middleContainerView.backgroundColor = color;
            }
        }
    }
}

// 4.选中时回调的委托方法，在此方法中实现省份和城市间的联动
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    //保存选中的行
    [self.selectedRowCache setObject:@(row) forKey:@(component)];
    
    [self.pickerView reloadComponent:component];
    
    // 获取滚动后选择的日期
    self.selectDate = [self getDidSelectedDate:component row:row];
    // 设置是否开启自动回调
    if (self.isAutoSelect) {
        // 滚动完成后，执行block回调
        if (self.resultBlock) {
            NSString *selectDateValue = [NSDate zj_getDateString:self.selectDate format:self.selectDateFormatter];
            self.resultBlock(selectDateValue);
        }
    }
    
}

#pragma mark - 设置pickerView 每一行的文字显示
- (void)setDateLabelText:(UILabel *)label component:(NSInteger)component row:(NSInteger)row {
    
    NSString *year = self.isShowChinese ? @"年" : @"";
    NSString *month = self.isShowChinese ? @"月" : @"";
    NSString *day = self.isShowChinese ? @"日" : @"";
    NSString *hour = self.isShowChinese ? @"时" : @"";
    NSString *minute = self.isShowChinese ? @"分" : @"";
    switch (self.pickerMode) {
        case ZJDatePickerModeYMDHM:
            if (component == 0) {
                label.text = [NSString stringWithFormat:@"%@%@", self.yearArr[row],year];
            } else if (component == 1) {
                label.text = [NSString stringWithFormat:@"%@%@", self.monthArr[row],month];
            } else if (component == 2) {
                label.text = [NSString stringWithFormat:@"%@%@", self.dayArr[row],day];
            } else if (component == 3) {
                label.text = [NSString stringWithFormat:@"%@%@", self.hourArr[row],hour];
            } else if (component == 4) {
                label.text = [NSString stringWithFormat:@"%@%@", self.minuteArr[row],minute];
            }
            break;
        case ZJDatePickerModeMDHM:
            if (component == 0) {
                label.text = [NSString stringWithFormat:@"%@%@", self.monthArr[row],month];
            } else if (component == 1) {
                label.text = [NSString stringWithFormat:@"%@%@", self.dayArr[row],day];
            } else if (component == 2) {
                label.text = [NSString stringWithFormat:@"%@%@", self.hourArr[row],month];
            } else if (component == 3) {
                label.text = [NSString stringWithFormat:@"%@%@", self.minuteArr[row],minute];
            }
            break;
        case ZJDatePickerModeYMD:
            if (component == 0) {
                label.text = [NSString stringWithFormat:@"%@%@", self.yearArr[row],year];
            } else if (component == 1) {
                label.text = [NSString stringWithFormat:@"%@%@", self.monthArr[row],month];
            } else if (component == 2) {
                label.text = [NSString stringWithFormat:@"%@%@", self.dayArr[row],day];
            }
            break;
        case ZJDatePickerModeYM:
            if (component == 0) {
                label.text = [NSString stringWithFormat:@"%@%@", self.yearArr[row],year];
            } else if (component == 1) {
                label.text = [NSString stringWithFormat:@"%@%@", self.monthArr[row],month];
            }
            break;
        case ZJDatePickerModeY:
            if (component == 0) {
                label.text = [NSString stringWithFormat:@"%@%@", self.yearArr[row],year];
            }
            break;
        case ZJDatePickerModeMD:
            if (component == 0) {
                label.text = [NSString stringWithFormat:@"%@%@", self.monthArr[row],month];
            } else if (component == 1) {
                label.text = [NSString stringWithFormat:@"%@%@", self.dayArr[row],day];
            }
            break;
        case ZJDatePickerModeHM:
            if (component == 0) {
                label.text = [NSString stringWithFormat:@"%@%@", self.hourArr[row],hour];
            } else if (component == 1) {
                label.text = [NSString stringWithFormat:@"%@%@", self.minuteArr[row],minute];
            }
            break;
            
        default:
            break;
    }
}


- (NSDate *)getDidSelectedDate:(NSInteger)component row:(NSInteger)row {
    
    NSString *selectDateValue = nil;
    switch (self.pickerMode) {
        case ZJDatePickerModeYMDHM:
            if (component == 0) {
                _yearIndex = row;
                [self updateDateArray];
                [self.pickerView reloadComponent:1];
                [self.pickerView reloadComponent:2];
                [self.pickerView reloadComponent:3];
                [self.pickerView reloadComponent:4];
              
            } else if (component == 1) {
                _monthIndex = row;
                [self updateDateArray];
                [self.pickerView reloadComponent:2];
                [self.pickerView reloadComponent:3];
                [self.pickerView reloadComponent:4];
            } else if (component == 2) {
                _dayIndex = row;
                [self updateDateArray];
                [self.pickerView reloadComponent:3];
                [self.pickerView reloadComponent:4];
            } else if (component == 3) {
                _hourIndex = row;
                [self updateDateArray];
                [self.pickerView reloadComponent:4];
            } else if (component == 4) {
                _minuteIndex = row;
            }
            selectDateValue = [NSString stringWithFormat:@"%@-%02ld-%02ld %02ld:%02ld", self.yearArr[_yearIndex], [self.monthArr[_monthIndex] integerValue], [self.dayArr[_dayIndex] integerValue], [self.hourArr[_hourIndex] integerValue], [self.minuteArr[_minuteIndex] integerValue]];
            break;
        case ZJDatePickerModeMDHM:
            if (component == 0) {
                _monthIndex = row;
                [self updateDateArray];
                [self.pickerView reloadComponent:1];
                [self.pickerView reloadComponent:2];
                [self.pickerView reloadComponent:3];
            } else if (component == 1) {
                _dayIndex = row;
                [self updateDateArray];
                [self.pickerView reloadComponent:2];
                [self.pickerView reloadComponent:3];
            } else if (component == 2) {
                _hourIndex = row;
                [self updateDateArray];
                [self.pickerView reloadComponent:3];
            } else if (component == 3) {
                _minuteIndex = row;
            }
            selectDateValue = [NSString stringWithFormat:@"%02ld-%02ld %02ld:%02ld", [self.monthArr[_monthIndex] integerValue], [self.dayArr[_dayIndex] integerValue], [self.hourArr[_hourIndex] integerValue], [self.minuteArr[_minuteIndex] integerValue]];
            break;
        case ZJDatePickerModeYMD:
            if (component == 0) {
                _yearIndex = row;
                [self updateDateArray];
                [self.pickerView reloadComponent:1];
                [self.pickerView reloadComponent:2];
            } else if (component == 1) {
                _monthIndex = row;
                [self updateDateArray];
                [self.pickerView reloadComponent:2];
            } else if (component == 2) {
                _dayIndex = row;
            }
            selectDateValue = [NSString stringWithFormat:@"%@-%02ld-%02ld", self.yearArr[_yearIndex], [self.monthArr[_monthIndex] integerValue], [self.dayArr[_dayIndex] integerValue]];
            break;
        case ZJDatePickerModeYM:
            if (component == 0) {
                _yearIndex = row;
                [self updateDateArray];
                [self.pickerView reloadComponent:1];
            } else if (component == 1) {
                _monthIndex = row;
            }
            selectDateValue = [NSString stringWithFormat:@"%@-%02ld", self.yearArr[_yearIndex], [self.monthArr[_monthIndex] integerValue]];
            break;
        case ZJDatePickerModeY:
            if (component == 0) {
                _yearIndex = row;
            }
            selectDateValue = [NSString stringWithFormat:@"%@", self.yearArr[_yearIndex]];
            break;
        case ZJDatePickerModeMD:
            if (component == 0) {
                _monthIndex = row;
                [self updateDateArray];
                [self.pickerView reloadComponent:1];
            } else if (component == 1) {
                _dayIndex = row;
            }
            selectDateValue = [NSString stringWithFormat:@"%02ld-%02ld", [self.monthArr[_monthIndex] integerValue], [self.dayArr[_dayIndex] integerValue]];
            break;
        case ZJDatePickerModeHM:
            if (component == 0) {
                _hourIndex = row;
                [self updateDateArray];
                [self.pickerView reloadComponent:1];
            } else if (component == 1) {
                _minuteIndex = row;
            }
            selectDateValue = [NSString stringWithFormat:@"%02ld:%02ld", [self.hourArr[_hourIndex] integerValue], [self.minuteArr[_minuteIndex] integerValue]];
            break;
            
        default:
            break;
    }
    return [NSDate zj_getDate:selectDateValue format:self.selectDateFormatter];
}

#pragma mark - 更新日期数据源数组
- (void)updateDateArray {
    NSInteger year = [self.yearArr[_yearIndex] integerValue];
    // 1.设置 monthArr 数组
    [self setupMonthArr:year];
    // 更新索引：防止更新 monthArr 后数组越界
    _monthIndex = (_monthIndex > self.monthArr.count - 1) ? (self.monthArr.count - 1) : _monthIndex;
    
    NSInteger month = [self.monthArr[_monthIndex] integerValue];
    // 2.设置 dayArr 数组
    [self setupDayArr:year month:month];
    // 更新索引：防止更新 dayArr 后数组越界
    _dayIndex = (_dayIndex > self.dayArr.count - 1) ? (self.dayArr.count - 1) : _dayIndex;
    
    NSInteger day = [self.dayArr[_dayIndex] integerValue];
    // 3.设置 hourArr 数组
    [self setupHourArr:year month:month day:day];
    // 更新索引：防止更新 hourArr 后数组越界
    _hourIndex = (_hourIndex > self.hourArr.count - 1) ? (self.hourArr.count - 1) : _hourIndex;
    
    NSInteger hour = [self.hourArr[_hourIndex] integerValue];
    // 4.设置 minuteArr 数组
    [self setupMinuteArr:year month:month day:day hour:hour];
    // 更新索引：防止更新 monthArr 后数组越界
    _minuteIndex = (_minuteIndex > self.minuteArr.count - 1) ? (self.minuteArr.count - 1) : _minuteIndex;
}

// 设置 yearArr 数组
- (void)setupYearArr {
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSInteger i = self.minLimitDate.zj_year; i <= self.maxLimitDate.zj_year; i++) {
        [tempArr addObject:[@(i) stringValue]];
    }
    self.yearArr = [tempArr copy];
}


// 设置 monthArr 数组
- (void)setupMonthArr:(NSInteger)year {
    NSInteger startMonth = 1;
    NSInteger endMonth = 12;
    if (year == self.minLimitDate.zj_year) {
        startMonth = self.minLimitDate.zj_month;
    }
    if (year == self.maxLimitDate.zj_year) {
        endMonth = self.maxLimitDate.zj_month;
    }
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:(endMonth - startMonth + 1)];
    for (NSInteger i = startMonth; i <= endMonth; i++) {
        [tempArr addObject:[@(i) stringValue]];
    }
    self.monthArr = [tempArr copy];
}

// 设置 dayArr 数组
- (void)setupDayArr:(NSInteger)year month:(NSInteger)month {
    NSInteger startDay = 1;
    NSInteger endDay = [NSDate zj_getDaysInYear:year month:month];
    if (year == self.minLimitDate.zj_year && month == self.minLimitDate.zj_month) {
        startDay = self.minLimitDate.zj_day;
    }
    if (year == self.maxLimitDate.zj_year && month == self.maxLimitDate.zj_month) {
        endDay = self.maxLimitDate.zj_day;
    }
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSInteger i = startDay; i <= endDay; i++) {
        [tempArr addObject:[NSString stringWithFormat:@"%zi",i]];
    }
    self.dayArr = [tempArr copy];
}

// 设置 hourArr 数组
- (void)setupHourArr:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSInteger startHour = 0;
    NSInteger endHour = 23;
    if (year == self.minLimitDate.zj_year && month == self.minLimitDate.zj_month && day == self.minLimitDate.zj_day) {
        startHour = self.minLimitDate.zj_hour;
    }
    if (year == self.maxLimitDate.zj_year && month == self.maxLimitDate.zj_month && day == self.maxLimitDate.zj_day) {
        endHour = self.maxLimitDate.zj_hour;
    }
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:(endHour - startHour + 1)];
    for (NSInteger i = startHour; i <= endHour; i++) {
        [tempArr addObject:[@(i) stringValue]];
    }
    self.hourArr = [tempArr copy];
}

// 设置 minuteArr 数组
- (void)setupMinuteArr:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour {
    NSInteger startMinute = 0;
    NSInteger endMinute = 59;
    if (year == self.minLimitDate.zj_year && month == self.minLimitDate.zj_month && day == self.minLimitDate.zj_day && hour == self.minLimitDate.zj_hour) {
        startMinute = self.minLimitDate.zj_minute;
    }
    if (year == self.maxLimitDate.zj_year && month == self.maxLimitDate.zj_month && day == self.maxLimitDate.zj_day && hour == self.maxLimitDate.zj_hour) {
        endMinute = self.maxLimitDate.zj_minute;
    }
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:(endMinute - startMinute + 1)];
    for (NSInteger i = startMinute; i <= endMinute; i++) {
        [tempArr addObject:[@(i) stringValue]];
    }
    self.minuteArr = [tempArr copy];
}

#pragma mark - 时间选择器的滚动响应事件
- (void)didSelectValueChanged:(UIDatePicker *)sender {
    self.selectDate = sender.date;
    BOOL selectLessThanMin = [self.selectDate zj_compare:self.minLimitDate format:self.selectDateFormatter] == NSOrderedAscending;
    BOOL selectMoreThanMax = [self.selectDate zj_compare:self.maxLimitDate format:self.selectDateFormatter] == NSOrderedDescending;
    
    if (selectLessThanMin) {
        self.selectDate = self.minLimitDate;
    }
    if (selectMoreThanMax) {
        self.selectDate = self.maxLimitDate;
    }
    [self.datePicker setDate:self.selectDate animated:YES];
    
    // 设置是否开启自动回调
    if (_isAutoSelect) {
        // 滚动完成后，执行block回调
        if (self.resultBlock) {
            NSString *selectDateValue = [NSDate zj_getDateString:self.selectDate format:self.selectDateFormatter];
            self.resultBlock(selectDateValue);
        }
    }
}


#pragma mark - 背景视图的点击事件
- (void)backViewTapAction:(UITapGestureRecognizer *)sender {
    [self dismissPickerViewWithAnimation:NO];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

#pragma mark - 右边按钮点击事件
-(void)rightBtnClickAction:(UIButton *)sender{
    // 点击确定按钮后，执行block回调
    [self dismissPickerViewWithAnimation:YES];
    if (self.resultBlock) {
        NSString *selectDateValue = [NSDate zj_getDateString:self.selectDate format:self.selectDateFormatter];
        self.resultBlock(selectDateValue);
    }
}

#pragma mark - 左边按钮点击事件
-(void)leftBtnClickAction:(UIButton *)sender{
    [self dismissPickerViewWithAnimation:YES];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

#pragma mark - 弹出窗口
-(void)showView{
    [self dealDate];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    if (self.animation) {
        CGRect rect = self.alertView.frame;
        rect.origin.y = ScreenHeight;
        self.alertView.frame = rect;
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.alertView.frame;
            rect.origin.y -= kZJPickerHeight + kZJTopViewHeight +ZJ_BOTTOM_MARGIN;
            self.alertView.frame = rect;
        }];
    }
}
#pragma mark - 关闭视图方法
- (void)dismissPickerViewWithAnimation:(BOOL)animation {
    // 关闭动画
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.alertView.frame;
        rect.origin.y += kZJPickerHeight + kZJTopViewHeight + ZJ_BOTTOM_MARGIN;
        self.alertView.frame = rect;
        self.backView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Getter && Setter
#pragma mark - 时间选择器 系统样式
-(UIDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = [UIDatePicker new];
        _datePicker.frame = CGRectMake(0, kZJTopViewHeight + 0.5, self.alertView.frame.size.width, kZJPickerHeight);
//        _datePicker.backgroundColor = [UIColor whiteColor];
        _datePicker.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth ;
        _datePicker.datePickerMode = _datePickerMode;
        // 设置 datepicker 的国际化 locale, 以简体中文显示日期
        _datePicker.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CHS_CN"];
        // 设置时间范围
        if (self.minLimitDate) {
            _datePicker.minimumDate = self.minLimitDate;
        }
        if (self.maxLimitDate) {
            _datePicker.maximumDate = self.maxLimitDate;
        }
        if (@available(iOS 13.4, *)) {
            _datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        } else {
            // Fallback on earlier versions
        }
        // 滚动改变值的响应事件
        [_datePicker addTarget:self action:@selector(didSelectValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

#pragma mark - 时间选择器  自定义 pickerView
- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, kZJTopViewHeight + 0.5, self.alertView.frame.size.width, kZJPickerHeight)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        // 设置子视图的大小随着父视图变化
        _pickerView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.showsSelectionIndicator = YES;
    }
    return _pickerView;
}

-(NSMutableDictionary *)selectedRowCache{
    if (!_selectedRowCache) {
        _selectedRowCache =[NSMutableDictionary dictionary];
    }
    return _selectedRowCache;
}
- (NSArray *)yearArr {
    if (!_yearArr) {
        _yearArr = [NSArray array];
    }
    return _yearArr;
}

- (NSArray *)monthArr {
    if (!_monthArr) {
        _monthArr = [NSArray array];
    }
    return _monthArr;
}

- (NSArray *)dayArr {
    if (!_dayArr) {
        _dayArr = [NSArray array];
    }
    return _dayArr;
}

- (NSArray *)hourArr {
    if (!_hourArr) {
        _hourArr = [NSArray array];
    }
    return _hourArr;
}

- (NSArray *)minuteArr {
    if (!_minuteArr) {
        _minuteArr = [NSArray array];
    }
    return _minuteArr;
}
@end
