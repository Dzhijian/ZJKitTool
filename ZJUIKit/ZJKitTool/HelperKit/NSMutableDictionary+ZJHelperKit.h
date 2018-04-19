//
//  NSMutableDictionary+ZJHelperKit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//



@interface NSMutableDictionary (ZJHelperKit)


/**
 * 使用它来为键设置对象是安全的。

 @param anObject 对象
 @param aKey 键
 @return BOOL
 */
- (BOOL)zj_setObject:(id)anObject forKey:(id<NSCopying>)aKey;


/**
 * 使用它来设置键值是安全的。

 @param value 值
 @param key 键
 @return bool
 */
- (BOOL)zj_setValue:(id)value forKey:(NSString *)key;
@end
