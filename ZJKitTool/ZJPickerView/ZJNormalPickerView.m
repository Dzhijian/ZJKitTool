
//
//  ZJNormalPickerView.m
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/6/30.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//
/**
 *  ZJKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下,给个Star。😆
 */

#import "ZJNormalPickerView.h"
#import "ZJPickerViewMacro.h"
typedef enum : NSUInteger {
    /// 单列展示
    ZJNormalPickerViewComponentSingle,
    /// 多列展示
    ZJNormalPickerViewComponentMore
} ZJNormalPickerViewMode;

@interface ZJNormalPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    BOOL  _isDataSourceValid;    // 数据源是否合法
//    BOOL  _isAutoSelect;         // 是否开启自动选择
}
// 选择器
@property (nonatomic, strong) UIPickerView          *pickerView;
// 选中行索引
@property (nonatomic, assign) NSInteger             selectedIndex;
// 单列选中的值
@property (nonatomic, strong) NSString              *selectValue;
// 多列选中的值
@property (nonatomic, strong) NSMutableArray        *selectValueArr;
/** 存取选中行 */
@property (nonatomic,strong) NSMutableDictionary    *selectedRowCache;
// pickerView 类型
@property (nonatomic, assign) ZJNormalPickerViewMode pickerViewMode;


@end

@implementation ZJNormalPickerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title                  = @"";
        self.isAutoSelect           = false;
        self.rowHeight              = 35.0f;
        _isDataSourceValid      = YES;
        self.animation              = true;
        if (_isDataSourceValid) {
            [self initWithAllView];
        }

    }
    return self;
}


- (void)setResultBlock:(ZJNormalResultBlock)resultBlock{
    _resultBlock = resultBlock;
}

- (void)setCancelBlock:(ZJNormalCancelBlock)cancelBlock{
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

- (void)setIsAutoSelect:(BOOL)isAutoSelect{
    _isAutoSelect = isAutoSelect;
}

- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    [self configDataSource:dataSource];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLab.text  = title;
}

- (void)setDefaultValue:(NSString *)defaultValue{
    _defaultValue = defaultValue;

}

- (void)setAnimation:(bool)animation{
    _animation = animation;
}

#pragma mark - 设置数据源
- (void)configDataSource:(id)dataSource{
    // 1.先判断传入的数据源是否合法
    if (!dataSource) {
        _isDataSourceValid = NO;
    }
    NSArray *dataArr = nil;
    if ([dataSource isKindOfClass:[NSArray class]] && [dataSource count] > 0) {
        dataArr = [NSArray arrayWithArray:dataSource];
    } else if ([dataSource isKindOfClass:[NSString class]] && [dataSource length] > 0) {
        NSString *plistName = dataSource;
        NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:nil];
        dataArr = [[NSArray alloc] initWithContentsOfFile:path];
        if (!dataArr || dataArr.count == 0) {
            _isDataSourceValid = NO;
        }
    } else {
        _isDataSourceValid = NO;
    }
    // 判断数组是否合法（即数组的所有元素是否是同一种数据类型）
    if (_isDataSourceValid) {
        Class itemClass = [[dataArr firstObject] class];
        for (id obj in dataArr) {
            if (![obj isKindOfClass:itemClass]) {
                _isDataSourceValid = NO;
                break;
            }
        }
    }
    if (!_isDataSourceValid) {
        return;
    }
    // 2. 给数据源赋值
    _dataSource = dataArr;
    
    // 3. 根据数据源 数组元素的类型，判断选择器的显示类型
    if ([[self.dataSource firstObject] isKindOfClass:[NSString class]]) {
        self.pickerViewMode = ZJNormalPickerViewComponentSingle;
    } else if ([[self.dataSource firstObject] isKindOfClass:[NSArray class]]) {
        self.pickerViewMode = ZJNormalPickerViewComponentMore;
    }

}


#pragma mark - 初始化子视图
- (void)initWithAllView {
    [super initWithAllView];
    self.titleLab.text = self.title;
    // 添加字符串选择器
    [self.alertView addSubview:self.pickerView];

}

#pragma mark - UIPickerViewDelegate,UIPickerViewDataSource

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (self.pickerViewMode == ZJNormalPickerViewComponentSingle) {
        return 1;
    }
    
    if (self.pickerViewMode == ZJNormalPickerViewComponentMore) {
        return self.dataSource.count;
    }
    
    return 0;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.pickerViewMode == ZJNormalPickerViewComponentSingle) {
        return self.dataSource.count;
    }else if (self.pickerViewMode == ZJNormalPickerViewComponentMore){
        return [self.dataSource[component] count];
    }else{
        return 0;
    }
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    //设置分割线的颜色
//    if (self.lineColor) {
//        // 设置分割线的颜色
//        ((UIView *)[pickerView.subviews objectAtIndex:1]).backgroundColor = self.lineColor;
//        ((UIView *)[pickerView.subviews objectAtIndex:2]).backgroundColor = self.lineColor;
//    }
     
    if (self.selectRowBGColor) {
        [self setUpPickerView:pickerView customSelectedBGRowColor:self.selectRowBGColor];
    }
    CGFloat width = self.pickerViewMode == ZJNormalPickerViewComponentSingle ? self.alertView.frame.size.width : self.alertView.frame.size.width / 3;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, self.rowHeight * kScaleFit)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18.0f * kScaleFit];
    // 字体自适应属性
    label.adjustsFontSizeToFitWidth = YES;
    // 自适应最小字体缩放比例
    label.minimumScaleFactor = 0.5f;

    if (self.pickerViewMode == ZJNormalPickerViewComponentSingle) {
        label.text =[NSString stringWithFormat:@"%@",self.dataSource[row]];
    } else if (self.pickerViewMode == ZJNormalPickerViewComponentMore) {
        label.text = [NSString stringWithFormat:@"%@",self.dataSource[component][row]];
    }
    
    NSInteger selectedIndex = [(NSNumber *)[self.selectedRowCache objectForKey:@(component)] integerValue];
    if (self.selecteRowTextColor && selectedIndex == row) {
        label.textColor = self.selecteRowTextColor;
    }
    
    return label;
}
// 设置 pickerview 的行高
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return self.rowHeight * kScaleFit;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    //保存选中的行
    [self.selectedRowCache setObject:@(row) forKey:@(component)];
    // 选中的行
    self.selectedIndex = row;
    
    [self.pickerView reloadComponent:component];
    
    if (self.pickerViewMode == ZJNormalPickerViewComponentSingle) {
        
        self.selectValue = self.dataSource[row];
        // 设置是否自动回调
        if (_isAutoSelect) {
            if (self.resultBlock) {
                self.resultBlock(self.selectValue,row);
            }
        }
        
    }else if (self.pickerViewMode == ZJNormalPickerViewComponentMore){
        
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSInteger i = 0; i < self.selectValueArr.count; i++) {
            if (i == component) {
                [tempArr addObject:self.dataSource[component][row]];
            } else {
                [tempArr addObject:self.selectValueArr[i]];
            }
        }
        self.selectValueArr = tempArr;
        
        // 设置是否自动回调
        if (_isAutoSelect) {
            if(self.resultBlock) {
                self.resultBlock([self.selectValueArr copy], row);
            }
        }
        
    }
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


#pragma mark - 背景视图的点击事件
- (void)backViewTapAction:(UITapGestureRecognizer *)sender {
    [self dismissPickerViewWithAnimation:NO];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

#pragma mark - 取消按钮的点击事件
- (void)leftBtnClickAction:(UIButton *)sender {
    [self dismissPickerViewWithAnimation:YES];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

#pragma mark - 确定按钮的点击事件
- (void)rightBtnClickAction:(UIButton *)sender{
    [self dismissPickerViewWithAnimation:YES];
    // 点击确定按钮后，执行回调
    if(self.resultBlock) {
        if(_resultBlock) {
            if (self.pickerViewMode == ZJNormalPickerViewComponentSingle) {
                _resultBlock(self.selectValue,self.selectedIndex);
            } else if (self.pickerViewMode == ZJNormalPickerViewComponentMore) {
                _resultBlock(self.selectValueArr,self.selectedIndex);
            }
        }
    }
}


#pragma mark - 弹出窗口
-(void)showView{
    
    // 4. 给选择器设置默认值
    if (self.pickerViewMode == ZJNormalPickerViewComponentSingle) {
        if (self.defaultValue && [self.defaultValue isKindOfClass:[NSString class]] && [self.defaultValue length] > 0 && [self.dataSource containsObject:self.defaultValue]) {
            self.selectValue = self.defaultValue;
        } else {
            self.selectValue = [self.dataSource firstObject];
        }
        NSInteger row = [self.dataSource indexOfObject:self.selectValue];
        // 默认滚动的行
        [self.pickerView selectRow:row inComponent:0 animated:NO];
        //保存选中的行
        [self.selectedRowCache setObject:@(row) forKey:@(0)];
    } else if (self.pickerViewMode == ZJNormalPickerViewComponentMore) {
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSInteger i = 0; i < self.dataSource.count; i++) {
            NSString *selValue = nil;
            if (self.defaultValue && [self.defaultValue isKindOfClass:[NSArray class]] && [self.defaultValue count] > 0 && i < [self.defaultValue count] && [self.dataSource[i] containsObject:self.defaultValue[i]]) {
                [tempArr addObject:self.defaultValue[i]];
                selValue = self.defaultValue[i];
            } else {
                [tempArr addObject:[self.dataSource[i] firstObject]];
                selValue = [self.dataSource[i] firstObject];
            }
            NSInteger row = [self.dataSource[i] indexOfObject:selValue];
            // 默认滚动的行
            [self.pickerView selectRow:row inComponent:i animated:NO];
            //保存选中的行
            [self.selectedRowCache setObject:@(row) forKey:@(i)];
        }
        self.selectValueArr = [tempArr copy];
    }
    
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
#pragma mark - 字符串选择器
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
        _selectedRowCache = [NSMutableDictionary dictionary];
    }
    return _selectedRowCache;
}

- (NSMutableArray *)selectValueArr {
    if (!_selectValueArr) {
        _selectValueArr = [[NSMutableArray alloc]init];
    }
    return _selectValueArr;
}
@end
