//
//  ZJAddressPickerView.m
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/6/28.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//
/**
 *  ZJKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下,给个Star。😆
 */

#import "ZJAddressPickerView.h"
#import "ZJPickerViewMacro.h"

@interface ZJAddressPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIView *_selectBackView;
    BOOL _isDataSourceValid;    // 数据源是否合法
    NSInteger _provinceIndex;   // 记录省选中的位置
    NSInteger _cityIndex;       // 记录市选中的位置
    NSInteger _areaIndex;       // 记录区选中的位置
    NSArray * _defaultSelectedArr;
}
// 地址选择器
@property (nonatomic, strong) UIPickerView          *pickerView;
// 省模型数组
@property (nonatomic, strong) NSArray               *provinceArr;
// 市模型数组
@property (nonatomic, strong) NSArray               *cityArr;
// 区模型数组
@property (nonatomic, strong) NSArray               *areaArr;
// 数据源
@property (nonatomic, strong) NSArray               *dataSource;
// 选中的省
@property(nonatomic, strong) ZJProvinceModel        *selectProvinceModel;
// 选中的市
@property(nonatomic, strong) ZJCityModel            *selectCityModel;
// 选中的区
@property(nonatomic, strong) ZJAreaModel            *selectAreaModel;
// 选中后的回调
@property (nonatomic, copy) ZJAddressResultBlock    resultBlock;
// 取消选择的回调
@property (nonatomic, copy) ZJAddressCancelBlock    cancelBlock;
// 展示类型
@property (nonatomic, assign) ZJAddressPickerMode   pickerViewMode;
// 是否开启自动选择
@property (nonatomic, assign) BOOL                  isAutoSelect;
// 分割线的颜色
@property (nonatomic, strong) UIColor               *lineColor;
// 选中行文本的颜色
@property (nonatomic, strong) UIColor               *selecteRowTextColor;
// 选中行背景颜色
@property (nonatomic, strong) UIColor               *selectRowBGColor;
// 行高
@property (nonatomic, assign) CGFloat               rowHeight;
@end


@implementation ZJAddressPickerView

#pragma mark - 1.显示地址选择器
+(void)zj_showAddressPickerWithDefaultSelected:(NSArray *)defaultSeleArr
                                   resuleBlock:(ZJAddressResultBlock)resultBlock{
    
    [self zj_showAddressPickerWithDefaultSelected:defaultSeleArr
                                     isAutoSelect:NO
                                      resultBlock:resultBlock];
    
}


+ (void)zj_showAddressPickerWithDefaultSelected:(NSArray *)defaultSelectedArr
                                   isAutoSelect:(BOOL)isAutoSelect
                                    resultBlock:(ZJAddressResultBlock)resultBlock{
    
    [self zj_showAddressPickerWithShowType:ZJAddressPickerModeArea
                           defaultSelected:defaultSelectedArr
                              isAutoSelect:isAutoSelect
                               resultBlock:resultBlock
                               cancelBlock:nil];
    
}
+ (void)zj_showAddressPickerWithShowType:(ZJAddressPickerMode)pickerMode
                         defaultSelected:(NSArray *)defaultSelectedArr
                            isAutoSelect:(BOOL)isAutoSelect
                             resultBlock:(ZJAddressResultBlock)resultBlock
                             cancelBlock:(ZJAddressCancelBlock)cancelBlock{
    
    [self zj_showAddressPickerWithShowType:pickerMode
                                dataSource:nil
                           defaultSelected:defaultSelectedArr
                              isAutoSelect:isAutoSelect
                               resultBlock:resultBlock
                               cancelBlock:cancelBlock];
}

+ (void)zj_showAddressPickerWithShowType:(ZJAddressPickerMode)pickerMode
                           dataSource:(NSArray *)dataSource
                      defaultSelected:(NSArray *)defaultSelectedArr
                         isAutoSelect:(BOOL)isAutoSelect
                          resultBlock:(ZJAddressResultBlock)resultBlock
                          cancelBlock:(ZJAddressCancelBlock)cancelBlock{
    
    [self zj_showAddressPickerWithShowType:pickerMode
                                dataSource:dataSource
                           defaultSelected:defaultSelectedArr
                              isAutoSelect:isAutoSelect
                                 lineColor:nil
                        selectRowTextColor:nil
                          selectRowBGColor:nil
                      confirmBtnTitleColor:nil
                       cancelBtnTitleColor:nil
                                 rowHeight:0
                               resultBlock:resultBlock
                               cancelBlock:cancelBlock];
    
}
+ (void)zj_showAddressPickerWithShowType:(ZJAddressPickerMode)pickerMode
                               dataSource:(NSArray *)dataSource
                          defaultSelected:(NSArray *)defaultSelectedArr
                             isAutoSelect:(BOOL)isAutoSelect
                                lineColor:(UIColor *)lineColor
                       selectRowTextColor:(UIColor *)selectRowTextColor
                         selectRowBGColor:(UIColor *)selectRowBGColor
                              resultBlock:(ZJAddressResultBlock)resultBlock
                             cancelBlock:(ZJAddressCancelBlock)cancelBlock{
    
    [self zj_showAddressPickerWithShowType:pickerMode
                                dataSource:dataSource
                           defaultSelected:defaultSelectedArr
                              isAutoSelect:isAutoSelect
                                 lineColor:lineColor
                        selectRowTextColor:selectRowTextColor
                          selectRowBGColor:selectRowBGColor
                      confirmBtnTitleColor:nil
                       cancelBtnTitleColor:nil
                                 rowHeight:0
                               resultBlock:resultBlock
                               cancelBlock:cancelBlock];
}

+ (void)zj_showAddressPickerWithShowType:(ZJAddressPickerMode)pickerMode
                              dataSource:(NSArray *)dataSource
                         defaultSelected:(NSArray *)defaultSelectedArr
                            isAutoSelect:(BOOL)isAutoSelect
                               lineColor:(UIColor *)lineColor
                      selectRowTextColor:(UIColor *)selectRowTextColor
                        selectRowBGColor:(UIColor *)selectRowBGColor
                    confirmBtnTitleColor:(UIColor *)confirmBtnTitleColor
                     cancelBtnTitleColor:(UIColor *)cancelBtnTitleColor
                               rowHeight:(CGFloat)rowHeight
                             resultBlock:(ZJAddressResultBlock)resultBlock
                             cancelBlock:(ZJAddressCancelBlock)cancelBlock{
    
    ZJAddressPickerView *addressPickerView = [[ZJAddressPickerView alloc]
                                              initWithShowPickerViewMode:pickerMode
                                              dataSource:dataSource
                                              defaultSelected:defaultSelectedArr
                                              isAutoSelected:isAutoSelect
                                              lineColor:lineColor
                                              selectRowTextColor:selectRowTextColor
                                              selectRowBGColor:selectRowBGColor
                                              confirmBtnTitleColor:confirmBtnTitleColor
                                              cancelBtnTitleColor:cancelBtnTitleColor
                                              rowHeight:rowHeight
                                              resultBlock:resultBlock
                                              cancelBlock:cancelBlock];
    
    [addressPickerView showPickerViewWithAnimation:YES];
    
}

#pragma mark - 创建一个 pickerview
-(instancetype)initWithShowPickerViewMode:(ZJAddressPickerMode)pickerViewMode
                               dataSource:(NSArray *)dataSource
                          defaultSelected:(NSArray *)defaultSelectedArr
                           isAutoSelected:(BOOL)isAutoSelect
                                lineColor:(UIColor *)lineColor
                       selectRowTextColor:(UIColor *)selectRowTextColor
                         selectRowBGColor:(UIColor *)selectRowBGColor
                     confirmBtnTitleColor:(UIColor *)confirmBtnTitleColor
                      cancelBtnTitleColor:(UIColor *)cancelBtnTitleColor
                                rowHeight:(CGFloat)rowHeight
                              resultBlock:(ZJAddressResultBlock)resultBlock
                              cancelBlock:(ZJAddressCancelBlock)cancelBlock{
    
    if (self = [super init]) {
        _isDataSourceValid          = YES;
        self.pickerViewMode         = pickerViewMode;
        _defaultSelectedArr         = defaultSelectedArr;
        self.dataSource             = dataSource;
        self.resultBlock            = resultBlock;
        self.cancelBlock            = cancelBlock;
        self.isAutoSelect           = isAutoSelect;
        self.lineColor              = lineColor;
        self.selecteRowTextColor    = selectRowTextColor;
        self.selectRowBGColor       = selectRowBGColor;
        self.rowHeight              = rowHeight ? rowHeight : 35.0f;
        
        
        if (confirmBtnTitleColor || cancelBtnTitleColor) {
            
            [self setUpConfirmTitleColor:confirmBtnTitleColor cancelColor:cancelBtnTitleColor];
        }
        
        [self loadAddressData];
        
        if (_isDataSourceValid) {
            [self initWithAllView];
        }
    }
    
    return self;
    
}
-(void)initWithAllView{
    [super initWithAllView];
    
    if (self.pickerViewMode == ZJAddressPickerModeProvince) {
        self.titleLab.text = @"请选择省份";
    }else if (self.pickerViewMode == ZJAddressPickerModeCity){
        self.titleLab.text = @"请选择城市";
    }else{
        self.titleLab.text = @"请选择地区";
    }
    [self.alertView addSubview:self.pickerView];
    
    [self.pickerView reloadAllComponents];
}

#pragma mark - 加载数据源
-(void)loadAddressData{
    if (!self.dataSource || self.dataSource.count == 0) {
        
        NSString *bundlePath = [[NSBundle mainBundle]pathForResource:@"ZJPickerViewBundle"ofType:@"bundle"];
        
        NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
        
        NSString *filePath = [resourceBundle pathForResource:@"ZJAddress" ofType:@"plist"];
        NSArray *dataSource = [NSArray arrayWithContentsOfFile:filePath];
        
        if (!dataSource || dataSource.count == 0) {
            return;
        }
        self.dataSource = dataSource;
    }
    
    // 解析数据
    [self parseDataSource];
    
    // 设置默认值
    [self setUpDefaultValue];

    // 设置默认滚动
    [self scrollToRow:_provinceIndex secondRow:_cityIndex thirdRow:_areaIndex];
}

-(void)setUpDefaultValue{
    __block NSString *selectProvinceName = nil;
    __block NSString *selectCityName = nil;
    __block NSString *selectAreaName = nil;
    
    // 1. 获取默认选中的省市区名称
    if (_defaultSelectedArr) {
        if (_defaultSelectedArr.count > 0 && [_defaultSelectedArr[0] isKindOfClass:[NSString class]]) {
            selectProvinceName = _defaultSelectedArr[0];
        }
        
        if (_defaultSelectedArr.count > 1 && [_defaultSelectedArr[1] isKindOfClass:[NSString class]]) {
            selectCityName = _defaultSelectedArr[1];
        }
        if (_defaultSelectedArr.count > 2 && [_defaultSelectedArr[2] isKindOfClass:[NSString class]]) {
            selectAreaName = _defaultSelectedArr[2];
        }
    }
    
    // 根据名称快速找到默认选中的省市区索引
    @weakify(self)
    [self.provinceArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        ZJProvinceModel *model = obj;
        
        if ([model.name isEqualToString:selectProvinceName]) {
            _provinceIndex = idx;
            self.selectProvinceModel = model;
            *stop = YES;
        }else{
            if (idx == self.provinceArr.count - 1) {
                _provinceIndex = 0;
                self.selectProvinceModel = [self.provinceArr firstObject];
            }
        }
    }];
    
    if (self.pickerViewMode == ZJAddressPickerModeCity || self.pickerViewMode == ZJAddressPickerModeArea) {
        self.cityArr = [self getCityModelArray:_provinceIndex];
        @weakify(self)
        [self.cityArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self)
            ZJCityModel *model = obj;
            if ([model.name isEqualToString:selectCityName]) {
                _cityIndex = idx;
                self.selectCityModel = model;
                *stop = YES;
            } else {
                if (idx == self.cityArr.count - 1) {
                    _cityIndex = 0;
                    self.selectCityModel = [self.cityArr firstObject];
                }
            }
        }];
    }
    if (self.pickerViewMode == ZJAddressPickerModeArea) {
        self.areaArr = [self getAreaModelArray:_provinceIndex cityIndex:_cityIndex];
        @weakify(self)
        [self.areaArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self)
            ZJAreaModel *model = obj;
            if ([model.name isEqualToString:selectAreaName]) {
                _areaIndex = idx;
                self.selectAreaModel = model;
                *stop = YES;
            } else {
                if (idx == self.cityArr.count - 1) {
                    _areaIndex = 0;
                    self.selectAreaModel = [self.areaArr firstObject];
                }
            }
        }];
    }
    
}
// 根据 省索引 获取 城市模型数组
- (NSArray *)getCityModelArray:(NSInteger)provinceIndex {
    ZJProvinceModel *provinceModel = self.provinceArr[provinceIndex];
    // 返回城市模型数组
    return provinceModel.citylist;
}

// 根据 省索引和城市索引 获取 区域模型数组
- (NSArray *)getAreaModelArray:(NSInteger)provinceIndex cityIndex:(NSInteger)cityIndex {
    ZJProvinceModel *provinceModel = self.provinceArr[provinceIndex];
    ZJCityModel *cityModel = provinceModel.citylist[cityIndex];
    // 返回地区模型数组
    return cityModel.arealist;
}

#pragma mark - 解析数据源
- (void)parseDataSource {
    NSMutableArray *tempArr1 = [NSMutableArray array];
    for (NSDictionary *proviceDic in self.dataSource) {
        ZJProvinceModel *proviceModel = [[ZJProvinceModel alloc]init];
        proviceModel.code = proviceDic[@"code"];
        proviceModel.name = proviceDic[@"name"];
        proviceModel.index = [self.dataSource indexOfObject:proviceDic];
        NSArray *citylist = proviceDic[@"citylist"];
        NSMutableArray *tempArr2 = [NSMutableArray array];
        for (NSDictionary *cityDic in citylist) {
            ZJCityModel *cityModel = [[ZJCityModel alloc]init];
            cityModel.code = cityDic[@"code"];
            cityModel.name = cityDic[@"name"];
            cityModel.index = [citylist indexOfObject:cityDic];
            NSArray *arealist = cityDic[@"arealist"];
            NSMutableArray *tempArr3 = [NSMutableArray array];
            for (NSDictionary *areaDic in arealist) {
                ZJAreaModel *areaModel = [[ZJAreaModel alloc]init];
                areaModel.code = areaDic[@"code"];
                areaModel.name = areaDic[@"name"];
                areaModel.index = [arealist indexOfObject:areaDic];
                [tempArr3 addObject:areaModel];
            }
            cityModel.arealist = [tempArr3 copy];
            [tempArr2 addObject:cityModel];
        }
        proviceModel.citylist = [tempArr2 copy];
        [tempArr1 addObject:proviceModel];
    }
    self.provinceArr = [tempArr1 copy];
}

#pragma mark - 滚动到指定行
- (void)scrollToRow:(NSInteger)provinceIndex secondRow:(NSInteger)cityIndex thirdRow:(NSInteger)areaIndex {
    if (self.pickerViewMode == ZJAddressPickerModeProvince) {
        [self.pickerView selectRow:provinceIndex inComponent:0 animated:YES];
    } else if (self.pickerViewMode == ZJAddressPickerModeCity) {
        [self.pickerView selectRow:provinceIndex inComponent:0 animated:YES];
        [self.pickerView selectRow:cityIndex inComponent:1 animated:YES];
    } else if (self.pickerViewMode == ZJAddressPickerModeArea) {
        [self.pickerView selectRow:provinceIndex inComponent:0 animated:YES];
        [self.pickerView selectRow:cityIndex inComponent:1 animated:YES];
        [self.pickerView selectRow:areaIndex inComponent:2 animated:YES];
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
        self.resultBlock(self.selectProvinceModel, self.selectCityModel, self.selectAreaModel);
    }
}


#pragma mark - 弹出窗口
-(void)showPickerViewWithAnimation:(BOOL)animation{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    if (animation) {
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


#pragma amrk - UIPickerViewDelegate , UIPickerViewDataSource
// 设置 pickerView 上有多少列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    if (self.pickerViewMode == ZJAddressPickerModeProvince) {
    
        return 1;
    
    }else if (self.pickerViewMode == ZJAddressPickerModeCity){
        
        return 2;
    
    }else if(self.pickerViewMode == ZJAddressPickerModeArea){
    
        return 3;
    }
    
    return 0;
    
}

// 设置 pickerview 上有多少行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        // 返回省的个数
        return self.provinceArr.count;
    }
    
    if (component == 1) {
        // 返回市的个数
        return self.cityArr.count;
    }
    
    if (component == 2) {
        // 返回区的个数
        return self.areaArr.count;
    }
    
    return 0;

}


// 配置 pickerView 的显示内容,在此方法中实现省份和城市间的联动
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    if (self.lineColor) {
        // 设置分割线的颜色
        ((UIView *)[pickerView.subviews objectAtIndex:1]).backgroundColor = self.lineColor;
        ((UIView *)[pickerView.subviews objectAtIndex:2]).backgroundColor = self.lineColor;
    }
    

    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.alertView.frame.size.width / 3, self.rowHeight * kScaleFit)];
    backView.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5*kScaleFit, 0, (self.alertView.frame.size.width) / 3 - 10 * kScaleFit, self.rowHeight * kScaleFit)];
    [backView addSubview:label];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = kFontSize(18);
    label.adjustsFontSizeToFitWidth = YES;
    // 字体自适应属性
    label.minimumScaleFactor = 0.5f;
    
    if (component == 0) {
        ZJProvinceModel *model = self.provinceArr[row];
        label.text = model.name;
        
        if (row == _provinceIndex && self.selecteRowTextColor) {
            label.textColor = self.selecteRowTextColor;
        }
        
    }else if (component == 1 ){
        ZJCityModel *model = self.cityArr[row];
        label.text = model.name;
        
        if (row == _cityIndex && self.selecteRowTextColor) {
            label.textColor = self.selecteRowTextColor;
        }
        
    }else if (component == 2 ){
        ZJAreaModel *model = self.areaArr[row];
        label.text = model.name;
        
        if (row == _areaIndex && self.selecteRowTextColor) {
            label.textColor = self.selecteRowTextColor;
        }

    }
    
    return backView;
}

// 设置 pickerview 的行高
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return self.rowHeight * kScaleFit;
}

#pragma mark - pickerview 的选中回调
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        // 保存选择的省份的索引
        _provinceIndex = row;
        switch (self.pickerViewMode) {
            case ZJAddressPickerModeProvince:
            {
                self.selectProvinceModel = self.provinceArr[_provinceIndex];
                self.selectCityModel = nil;
                self.selectAreaModel = nil;
                
            }
                break;
            case ZJAddressPickerModeCity:
            {
                self.cityArr = [self getCityModelArray:_provinceIndex];
                [self.pickerView reloadComponent:1];
                [self.pickerView selectRow:0 inComponent:1 animated:YES];
                self.selectProvinceModel = self.provinceArr[_provinceIndex];
                self.selectCityModel = self.cityArr[0];
                self.selectAreaModel = nil;
                _cityIndex = 0;
            }
                break;
            case ZJAddressPickerModeArea:
            {
                self.cityArr = [self getCityModelArray:_provinceIndex];
                self.areaArr = [self getAreaModelArray:_provinceIndex cityIndex:0];
                [self.pickerView reloadComponent:1];
                [self.pickerView selectRow:0 inComponent:1 animated:YES];
                [self.pickerView reloadComponent:2];
                [self.pickerView selectRow:0 inComponent:2 animated:YES];
                self.selectProvinceModel = self.provinceArr[_provinceIndex];
                self.selectCityModel = self.cityArr[0];
                self.selectAreaModel = self.areaArr[0];
                _cityIndex = 0;
                _areaIndex = 0;
            }
                break;
            default:
                break;
        }
    }
    
    if (component == 1) { // 选择市
        // 保存选择的城市的索引
        _cityIndex = row;
        switch (self.pickerViewMode) {
            case ZJAddressPickerModeCity:
            {
                self.selectCityModel = self.cityArr[_cityIndex];
                self.selectAreaModel = nil;
                
            }
                break;
            case ZJAddressPickerModeArea:
            {
                self.areaArr = [self getAreaModelArray:_provinceIndex cityIndex:_cityIndex];
                [self.pickerView reloadComponent:2];
                [self.pickerView selectRow:0 inComponent:2 animated:YES];
                self.selectCityModel = self.cityArr[_cityIndex];
                self.selectAreaModel = self.areaArr[0];
                _areaIndex = 0;
            }
                break;
            default:
                break;
        }
    }
    if (component == 2) { // 选择区
        // 保存选择的地区的索引
        _areaIndex = row;
        if (self.pickerViewMode == ZJAddressPickerModeArea) {
            self.selectAreaModel = self.areaArr[_areaIndex];
        }
    }
    
    // 自动获取数据，滚动完就执行回调
    if (self.isAutoSelect) {
        if (self.resultBlock) {
            self.resultBlock(self.selectProvinceModel, self.selectCityModel, self.selectAreaModel);
        }
    }
    
    [pickerView reloadAllComponents];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.subviews.count) {
        
        NSArray *subviews = self.pickerView.subviews;
        if (!(subviews.count > 0)) {
            return;
        }
        
        NSArray *coloms = subviews.firstObject;
        NSArray *subviewCache = [coloms valueForKey:@"subviewCache"];
        if (subviewCache.count > 0) {
            UIView *middleContainerView = [subviewCache.firstObject valueForKey:@"middleContainerView"];
            if (middleContainerView) {
                middleContainerView.backgroundColor = self.selectRowBGColor;
            }
        }
    }
    
}

#pragma mark - Getter && Setter
-(UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, kZJTopViewHeight + 0.5, self.alertView.frame.size.width, kZJPickerHeight)];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.showsSelectionIndicator = YES;
        // 设置子视图的大小随着父视图变化
        _pickerView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    }
    return _pickerView;
}

-(NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}

-(NSArray *)provinceArr{
    if (!_provinceArr) {
        _provinceArr = [NSArray array];
    }
    return _provinceArr;
}

-(NSArray *)cityArr{
    if (!_cityArr) {
        _cityArr = [NSArray array];
    }
    return _cityArr;
}

-(NSArray *)areaArr{
    if (!_areaArr) {
        _areaArr = [NSArray array];
    }
    return _areaArr;
}

-(ZJProvinceModel *)selectProvinceModel{
    if (!_selectProvinceModel) {
        _selectProvinceModel = [[ZJProvinceModel alloc]init];
    }
    return _selectProvinceModel;
}

-(ZJCityModel *)selectCityModel{
    if (!_selectCityModel) {
        _selectCityModel = [[ZJCityModel alloc]init];
        _selectCityModel.code = @"";
        _selectCityModel.name = @"";
    }
    return _selectCityModel;
}

-(ZJAreaModel *)selectAreaModel{
    if (!_selectAreaModel) {
        _selectAreaModel = [[ZJAreaModel alloc]init];
        _selectAreaModel.code = @"";
        _selectAreaModel.name = @"";
    }
    return _selectAreaModel;
}


@end
