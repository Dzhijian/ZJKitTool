//
//  NSArray+ZJHelperKit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//



@interface NSArray (ZJHelperKit)


/**
 * 返回安全的索引

 @param index 索引
 */
-(id)zj_objectAtIndex:(NSInteger)index;


/**
 * 该数组是否包含这个字符串
 
 @param string 字符串
 @return Bool
 */
-(BOOL)zj_isContainsString:(NSString *)string;


/**
 * 数组倒序
 */
-(NSArray *)zj_reverseArray;

@end

