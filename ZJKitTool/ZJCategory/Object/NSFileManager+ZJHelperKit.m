//
//  NSFileManager+ZJHelperKit.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "NSFileManager+ZJHelperKit.h"
#import "NSDictionary+ZJHelperKit.h"

@implementation NSFileManager (ZJHelperKit)

- (BOOL)zj_isFileAtPath:(NSString *)filePath hasTimeOut:(NSTimeInterval)timeout {
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSError *error = nil;
        NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath
                                                                                    error:&error];
        if (error) {
            return YES;
        }
        
        if ([attributes isKindOfClass:[NSDictionary class]] && attributes) {
            NSString *createDate = [attributes objectForKey:@"NSFileModificationDate"];
            createDate = [NSString stringWithFormat:@"%@", createDate];
            if (createDate.length >= 19) {
                createDate = [createDate substringToIndex:19];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                
                NSDate *sinceDate = [formatter dateFromString:createDate];
                NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:sinceDate];
                BOOL isTimeOut = (long)interval > timeout;
                
                return isTimeOut;
            }
        }
    }
    
    return YES;
}

- (NSDictionary *)zj_fileAttributesAtPath:(NSString *)path {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:path
                                                                           error:&error];
    if (error) {
        return nil;
    }
    
    return attrs;
}

- (unsigned long long)zj_fileSizeAtPath:(NSString *)path {
    NSDictionary *attrs = [self zj_fileAttributesAtPath:path];
    
    if (attrs == nil) {
        return 0;
    }
    
    return [attrs zj_unsignedLongLongValue:NSFileSize];
}

+(NSURL *)URLForDirectory:(NSSearchPathDirectory)directory{
    return [self.defaultManager URLsForDirectory:directory inDomains:NSUserDomainMask].lastObject;
}

+(NSString *)pathForDirectory:(NSSearchPathDirectory)directory{
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES).firstObject;
}



+ (NSURL *)zj_documentsURL
{
    return [self URLForDirectory:NSDocumentDirectory];
}

+ (NSString *)zj_documentsPath
{
    return [self pathForDirectory:NSDocumentDirectory];
}

+ (NSURL *)zj_libraryURL
{
    return [self URLForDirectory:NSLibraryDirectory];
}

+ (NSString *)zj_libraryPath
{
    return [self pathForDirectory:NSLibraryDirectory];
}

+ (NSURL *)zj_cachesURL
{
    return [self URLForDirectory:NSCachesDirectory];
}

+ (NSString *)zj_cachesPath
{
    return [self pathForDirectory:NSCachesDirectory];
}

@end
