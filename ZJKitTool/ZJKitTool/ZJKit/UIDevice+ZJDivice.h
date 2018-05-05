//
//  UIDevice+ZJDivice.h
//  ZJUIKit
//
//  Created by dzj on 2017/12/5.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (ZJDivice)

/** mac地址 */
+ (NSString *)macAddress;

/** ram的size */
+ (NSUInteger)ramSize;

/** cpu个数 */
+ (NSUInteger)cpuNumber;

/** 系统的版本号 */
+ (NSString *)systemVersion;

/** 是否有摄像头 */
+ (BOOL)hasCamera;

/** 获取手机内存总量, 返回的是字节数 */
+ (NSUInteger)totalMemoryBytes;

/** 获取手机可用内存, 返回的是字节数 */
+ (NSUInteger)freeMemoryBytes;

/** 获取手机硬盘总空间, 返回的是字节数 */
+ (NSUInteger)totalDiskSpaceBytes;

/** 获取手机硬盘空闲空间, 返回的是字节数 */
+ (NSUInteger)freeDiskSpaceBytes;
@end
