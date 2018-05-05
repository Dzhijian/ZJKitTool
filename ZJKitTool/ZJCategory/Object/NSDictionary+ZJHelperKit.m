//
//  NSDictionary+ZJHelperKit.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "NSDictionary+ZJHelperKit.h"

@implementation NSDictionary (ZJHelperKit)
- (id)zj_objectForKey:(id<NSCopying>)key {
    if (key == nil) {
        return nil;
    }
    
    return [self objectForKey:key];
}

- (int)zj_intForKey:(id)key {
    if (key == nil) {
        return 0;
    }
    
    NSNumber *number = [self zj_numberForKey:key];
    
    return [number intValue];
}

- (double)zj_doubleForKey:(id)key {
    if (key == nil) {
        return 0;
    }
    
    NSNumber *number = [self zj_numberForKey:key];
    
    return [number doubleValue];
}

- (float)zj_floatForKey:(id)key {
    if (key == nil) {
        return 0;
    }
    
    NSNumber *number = [self zj_numberForKey:key];
    
    return [number floatValue];
}

- (NSInteger)zj_integerForKey:(id)key {
    if (key == nil) {
        return 0;
    }
    
    NSNumber *number = [self zj_numberForKey:key];
    
    return [number integerValue];
}

- (NSString *)zj_stringForKey:(id)key {
    if (key == nil) {
        return 0;
    }
    
    id obj = [self zj_objectForKey:key];
    
    if ([obj isKindOfClass:[NSString class]]) {
        return (NSString *)obj;
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@", obj];
    }
    
    return nil;
}


- (NSDictionary *)zj_dictionaryForKey:(id)key {
    if (key == nil) {
        return 0;
    }
    
    id obj = [self zj_objectForKey:key];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)obj;
    }
    
    return nil;
}

- (NSArray *)zj_arrayForKey:(id)key {
    if (key == nil) {
        return 0;
    }
    
    id obj = [self zj_objectForKey:key];
    if ([obj isKindOfClass:[NSArray class]]) {
        return (NSArray *)obj;
    }
    
    return nil;
}

- (NSNumber *)zj_numberForKey:(id)key {
    if (key == nil) {
        return 0;
    }
    
    id obj = [self zj_objectForKey:key];
    if ([obj isKindOfClass:[NSNumber class]]) {
        return (NSNumber *)obj;
    }
    
    return nil;
}

- (BOOL)zj_boolForKey:(id)key {
    if (key == nil) {
        return NO;
    }
    
    id number = [self zj_objectForKey:key];
    if ([number respondsToSelector:@selector(boolValue)]) {
        return [number boolValue];
    }
    
    return NO;
}

- (unsigned long long)zj_unsignedLongLongValue:(id<NSCopying>)key {
    if (key == nil) {
        return 0;
    }
    
    id number = [self zj_objectForKey:key];
    if ([number respondsToSelector:@selector(unsignedLongLongValue)]) {
        return [number unsignedLongLongValue];
    }
    
    return 0;
}
@end
