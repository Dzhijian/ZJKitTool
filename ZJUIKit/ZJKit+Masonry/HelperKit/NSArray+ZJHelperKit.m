//
//  NSArray+ZJHelperKit.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "NSArray+ZJHelperKit.h"

@implementation NSArray (ZJHelperKit)

/**
 * 返回安全的索引
 
 @param index 索引
 */
-(id)zj_objectAtIndex:(NSInteger)index{
    NSInteger count = [self count];
    if (count > 0 && index < count) {
        return  [self objectAtIndex:index];
    }
    return nil;
}


/**
 * 该数组是否包含这个字符串
 
 @param string 字符串
 @return Bool
 */
-(BOOL)zj_isContainsString:(NSString *)string{
    
    for (NSString *element in self) {
        if ([element isKindOfClass:[NSString class]] && [element isEqualToString:string]) {
            return true;
        }
    }
    return false;
}



/**
 * 数组倒序
 */
-(NSArray *)zj_reverseArray{
    NSMutableArray *arrayTemp = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    
    for (id element  in enumerator) {
        [arrayTemp addObject:element];
    }
    return arrayTemp;
    
}

@end
