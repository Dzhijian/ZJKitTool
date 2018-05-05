//
//  NSMutableArray+ZJHelperKit.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "NSMutableArray+ZJHelperKit.h"

@implementation NSMutableArray (ZJHelperKit)

- (BOOL)zj_addObject:(id)object {
    BOOL ret = NO;
    if (object) {
        ret = YES;
        [self addObject:object];
    }
    
    return ret;
}

- (BOOL)zj_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject == nil|| index > [self count] ) {
        return NO;
    }
    
    if ([self containsObject:anObject]) {
        return NO;
    }
    
    [self insertObject:anObject atIndex:index];
    
    return YES;
}

- (BOOL)zj_removeObjectAtIndex:(NSUInteger)index {
    if (index >= [self count]) {
        return NO;
    }
    
    [self removeObjectAtIndex:index];
    
    return YES;
}

- (BOOL)zj_exchangeObjectFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if ([self count] != 0 && toIndex != fromIndex
        && fromIndex < [self count] && toIndex < [self count]) {
        [self exchangeObjectAtIndex:fromIndex withObjectAtIndex:toIndex];
        
        return YES;
    }
    
    return NO;
}

@end
