//
//  UIDevice+ZJDivice.m
//  ZJUIKit
//
//  Created by dzj on 2017/12/5.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import "UIDevice+ZJDivice.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import <sys/socket.h>
#import <sys/param.h>
#import <sys/mount.h>
#import <sys/stat.h>
#import <sys/utsname.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <mach/processor_info.h>

@implementation UIDevice (ZJDivice)


+(NSString *)macAddress{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if(sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. Rrror!\n");
        return NULL;
    }
    
    if(sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}
+ (NSString *)systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}
+ (BOOL)hasCamera
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

+ (NSUInteger)getSysInfo:(uint)typeSpecifier
{
    size_t size = sizeof(int);
    int result;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &result, &size, NULL, 0);
    return (NSUInteger)result;
}

+ (NSUInteger)ramSize {
    return [self getSysInfo:HW_MEMSIZE];
}

+ (NSUInteger)cpuNumber {
    return [self getSysInfo:HW_NCPU];
}


+ (NSUInteger)totalMemoryBytes
{
    return [self getSysInfo:HW_PHYSMEM];
}

+ (NSUInteger)freeMemoryBytes
{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t pagesize;
    vm_statistics_data_t vm_stat;
    
    host_page_size(host_port, &pagesize);
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) {
        return 0;
    }
    unsigned long mem_free = vm_stat.free_count * pagesize;
    return mem_free;
}

+ (NSUInteger)freeDiskSpaceBytes
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *attributes = [fileManager attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSNumber *number = attributes[NSFileSystemFreeSize];
    return [number unsignedIntegerValue];
}

+ (NSUInteger)totalDiskSpaceBytes
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *attributes = [fileManager attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSNumber *number = attributes[NSFileSystemSize];
    return [number unsignedIntegerValue];
}
@end
