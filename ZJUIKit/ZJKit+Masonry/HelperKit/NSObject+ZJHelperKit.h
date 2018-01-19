//
//  NSObject+ZJHelperKit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ZJHelperKit)

/**
 *    获取currnet对象的类的名称。
 */
- (NSString *)zj_className;

#pragma mark - Json to object and object to jason
/**
 *    将对象转换为json数据。
 *
 *    @param object    Any kind of object.
 *
 *    @return json data object if transform successfully, otherwise return nil.
 */
+ (NSMutableData *)zj_toJsonDataWithObject:(id)object;

/**
 *    将自己转换为json数据。
 *
 *    @return json data if transform successfully, otherwise return nil.
 */
- (NSMutableData *)zj_toJsonData;

/**
 *    将对象转换为json字符串。
 *
 *    @param object    Any kind of object
 *
 *    @return json string if transform successfully, otherwise return nil.
 */
+ (NSString *)zj_toJsonStringWithObject:(id)object;

/**
 *    将自己转换为json字符串。
 *
 *    @return json string if transform successfully, otherwise return nil.
 */
- (NSString *)zj_toJsonString;


#pragma mark - Filter Null and nil 过滤nil和null对象。
/**
 *    过滤所有nil和null对象。
 */
- (id)zj_filterNullNil;

/**
 *    过滤所有nil和null对象。
 *
 *    @param object    The object to be filtered.
 */
+ (id)zj_filterNullNilFromObject:(id)object;

@end
