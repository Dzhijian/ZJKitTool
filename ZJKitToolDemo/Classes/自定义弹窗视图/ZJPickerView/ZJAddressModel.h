//
//  ZJAddressModel.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/6/28.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

// 省
@interface ZJProvinceModel : NSObject
/**
 * 省对应的code或id
 */
@property (nonatomic, copy) NSString *code;
/**
 * 省的名称
 */
@property (nonatomic, copy) NSString *name;
/**
 * 省的索引
 */
@property (nonatomic, assign) NSInteger index;
/**
 * 城市数组
 */
@property (nonatomic, strong) NSArray *citylist;

@end

// 市
@interface ZJCityModel : NSObject
/**
 * 市对应的code或id
 */
@property (nonatomic, copy) NSString *code;
/**
 * 市的名称
 */
@property (nonatomic, copy) NSString *name;
/**
 * 市的索引
 */
@property (nonatomic, assign) NSInteger index;
/**
 * 地区数组
 */
@property (nonatomic, strong) NSArray *arealist;

@end

// 区
@interface ZJAreaModel : NSObject
/**
 *  区对应的code或id
 */
@property (nonatomic, copy) NSString *code;
/**
 *  区的名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  区的索引
 */
@property (nonatomic, assign) NSInteger index;

@end
