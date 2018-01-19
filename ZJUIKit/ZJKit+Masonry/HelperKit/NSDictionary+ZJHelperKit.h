//
//  NSDictionary+ZJHelperKit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//



@interface NSDictionary (ZJHelperKit)


/**
 * 根据键获取所对应的对象

 @param key 键
 @return object
 */
- (id)zj_objectForKey:(id<NSCopying>)key;


/**
 * 根据键获取所对应的值 返回int类型
 
 @param key 键
 @return int
 */
- (int)zj_intForKey:(id<NSCopying>)key;

/**
 * 根据键获取所对应的值 返回double类型
 
 @param key 键
 @return double
 */
- (double)zj_doubleForKey:(id<NSCopying>)key;

/**
 * 根据键获取所对应的值 返回float类型
 
 @param key 键
 @return float
 */
- (float)zj_floatForKey:(id<NSCopying>)key;

/**
 * 根据键获取所对应的值 返回NSInteger类型
 
 @param key 键
 @return NSInteger
 */
- (NSInteger)zj_integerForKey:(id<NSCopying>)key;

/**
 * 根据键获取所对应的值 返回NSString类型
 
 @param key 键
 @return NSString
 */
- (NSString *)zj_stringForKey:(id<NSCopying>)key;

/**
 * 根据键获取所对应的值 返回NSDictionary类型
 
 @param key 键
 @return NSDictionary
 */
- (NSDictionary *)zj_dictionaryForKey:(id<NSCopying>)key;

/**
 * 根据键获取所对应的值 返回NSArray类型
 
 @param key 键
 @return NSArray
 */
- (NSArray *)zj_arrayForKey:(id<NSCopying>)key;

/**
 * 根据键获取所对应的值 返回NSNumber类型
 
 @param key 键
 @return NSNumber
 */
- (NSNumber *)zj_numberForKey:(id<NSCopying>)key;

/**
 * 根据键获取所对应的值 返回BOOL类型
 
 @param key 键
 @return BOOL
 */
- (BOOL)zj_boolForKey:(id<NSCopying>)key;

/**
 * 根据键获取所对应的值 返回unsigned long long类型
 
 @param key 键
 @return unsigned long long
 */
- (unsigned long long)zj_unsignedLongLongValue:(id<NSCopying>)key;

@end
