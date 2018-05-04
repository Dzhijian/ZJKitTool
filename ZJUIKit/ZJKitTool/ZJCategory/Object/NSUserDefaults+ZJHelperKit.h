//
//  NSUserDefaults+ZJHelperKit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (ZJHelperKit)


/**
 *    将安全对象设置为用户默认值，它将过滤所有nil或Null对象,为了防止应用程序崩溃。
 *
 *    @param value                The object to be saved.
 *    @param key          The only key.
 */
- (BOOL)zj_setSafeObject:(id)value forKey:(NSString *)key;

@end
