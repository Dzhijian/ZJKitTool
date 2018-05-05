//
//  NSMutableDictionary+ZJHelperKit.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "NSMutableDictionary+ZJHelperKit.h"

@implementation NSMutableDictionary (ZJHelperKit)

- (BOOL)zj_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (aKey == nil || anObject == nil) {
        return NO;
    }
    
    [self setObject:anObject forKey:aKey];
    
    return YES;
}

- (BOOL)zj_setValue:(id)value forKey:(NSString *)key {
    if (key == nil || value == nil) {
        return NO;
    }
    
    [self setValue:value forKey:key];
    
    return YES;
}
@end
