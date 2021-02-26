//
//  UIDevice+ZJHelperKitUIKit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (ZJHelperKit)

/**
 *  返回设备平台字符串
 *  Example: "iPhone3,2"
 *
 *  @return Return the device platform string
 */
+ (NSString *)zj_devicePlatform;

/**
 *  返回用户友好的设备平台字符串
 *  Example: "iPad Air (Cellular)"
 *
 *  @return Return the user-friendly device platform string
 */
+ (NSString *)zj_devicePlatformString;

/**
 *  检查当前设备是否为iPad
 *
 *  @return Return YES if it's an iPad, NO if not
 */
+ (BOOL)zj_isiPad;

/**
 *  检查当前设备是否为iPhone
 *
 *  @return Return YES if it's an iPhone, NO if not
 */
+ (BOOL)zj_isiPhone;

/**
 *  检查当前设备是否为 iPod
 *
 *  @return Return YES if it's an iPod, NO if not
 */
+ (BOOL)zj_isiPod;

/**
 *  检查当前设备是否为 simulator
 *
 *  @return Return YES if it's the simulator, NO if not
 */
+ (BOOL)zj_isSimulator;

/**
 *  检查当前设备是否是视网膜显示
 *
 *  @return Return YES if it has a Retina display, NO if not
 */
+ (BOOL)zj_isRetina;

/**
 *  检查当前设备是否有视网膜高清显示
 *
 *  @return Return YES if it has a Retina HD display, NO if not
 */
+ (BOOL)zj_isRetinaHD;

/**
 *  Return the iOS version without the subversion
 *  Example: 7
 *
 *  @return Return the iOS version
 */
+ (NSInteger)zj_iOSVersion;

/**
 *  返回当前设备的CPU频率
 *
 *  @return Return the current device CPU frequency
 */
+ (NSUInteger)zj_cpuFrequency;

/**
 *  返回当前设备总线频率
 *
 *  @return Return the current device BUS frequency
 */
+ (NSUInteger)zj_busFrequency;

/**
 *  返回当前设备RAM大小
 *
 *  @return Return the current device RAM size
 */
+ (NSUInteger)zj_ramSize;

/**
 *  返回当前设备CPU号
 *
 *  @return Return the current device CPU number
 */
+ (NSUInteger)zj_cpuNumber;

/**
 *  返回当前设备的总内存
 *
 *  @return Return the current device total memory
 */
+ (NSUInteger)zj_totalMemory;

/**
 *  返回当前设备的非内核内存
 *
 *  @return Return the current device non-kernel memory
 */
+ (NSUInteger)zj_userMemory;

/**
 *  返回当前设备的总磁盘空间
 *
 *  @return Return the current device total disk space
 */
+ (NSNumber *)zj_totalDiskSpace;

/**
 *  返回当前设备的空闲磁盘空间
 *
 *  @return Return the current device free disk space
 */
+ (NSNumber *)zj_freeDiskSpace;

/**
 *  返回当前设备MAC地址
 *
 *  @return Return the current device MAC address
 */
+ (NSString *)zj_macAddress;

/**
 *  生成唯一标识符并将其存储到standardUserDefaults中
 *
 *  @return Return a unique identifier as a NSString
 */
+ (NSString *)zj_uniqueIdentifier;

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
