//
//  NSMutableArray+ZJHelperKit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//



@interface NSMutableArray (ZJHelperKit)


/**
 * 添加一个元素

 @param object 对象
 @return BOOL
 */
- (BOOL)zj_addObject:(id)object;


/**
 * 插入一个对象到数组中
 
 @param index 索引
 @return BOOL
 */

- (BOOL)zj_insertObject:(id)anObject atIndex:(NSUInteger)index;


/**
 * 安全移除对象

 @param index 索引
 @return BOOL
 */
- (BOOL)zj_removeObjectAtIndex:(NSUInteger)index;



/**
 *  Exchange double elements.
 *
 *  @param fromIndex The index to move from
 *  @param toIndex   The index to move to
 *
 *  @return YES if exchange successfully, otherwise NO.
 */
- (BOOL)zj_exchangeObjectFromIndex:(NSUInteger)fromIndex
                            toIndex:(NSUInteger)toIndex;
@end
