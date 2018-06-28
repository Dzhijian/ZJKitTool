//
//  ZJAddressPickerView.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/6/28.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJPickBaseView.h"
#import "ZJAddressModel.h"


typedef enum : NSUInteger {
    ZJAddressPickerModeProvince,
    ZJAddressPickerModeCity,
    ZJAddressPickerModeArea,
} ZJAddressPickerMode;


typedef void(^ZJAddressResultBlock)(ZJProvinceModel *province, ZJCityModel *city, ZJAreaModel *area);
typedef void(^ZJAddressCancelBlock)(void);

@interface ZJAddressPickerView : ZJPickBaseView

+(void)zj_showAddressPickerWithDefaultSelected:(NSArray *)defaultSeleArr
                                   resuleBlock:(ZJAddressResultBlock)resultBlock;

@end
