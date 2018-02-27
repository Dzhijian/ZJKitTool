
//
//  ZJVideoModel.m
//  ZJUIKit
//
//  Created by dzj on 2018/2/27.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJVideoModel.h"

@implementation ZJVideoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    // 转换系统关键字description
    if ([key isEqualToString:@"description"]) {
        self.video_description = [NSString stringWithFormat:@"%@",value];
    }
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"playInfo"]) {
        self.playInfo = @[].mutableCopy;
        NSMutableArray *array = @[].mutableCopy;
        for (NSDictionary *dataDic in value) {
            ZJVideoResolution *resolution = [[ZJVideoResolution alloc] init];
            [resolution setValuesForKeysWithDictionary:dataDic];
            [array addObject:resolution];
        }
        [self.playInfo removeAllObjects];
        [self.playInfo addObjectsFromArray:array];
    } else if ([key isEqualToString:@"title"]) {
        self.title = value;
    } else if ([key isEqualToString:@"playUrl"]) {
        self.playUrl = value;
    } else if ([key isEqualToString:@"coverForFeed"]) {
        self.coverForFeed = value;
    }
    
}

@end
