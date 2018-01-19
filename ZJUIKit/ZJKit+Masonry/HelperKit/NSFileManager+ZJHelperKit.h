//
//  NSFileManager+ZJHelperKit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (ZJHelperKit)


/**
 * 判断是否存在路径上的文件，并检查超时与否。

 @param filePath 文件路劲
 @param timeout 超出时间
 @return BOOL
 */
- (BOOL)zj_isFileAtPath:(NSString *)filePath hasTimeOut:(NSTimeInterval)timeout;


/**
 * 获取路径中的文件属性。

 @param path 文件路径
 @return NSDictionary
 */
- (NSDictionary *)zj_fileAttributesAtPath:(NSString *)path;


/**
 * 获取文件大小

 @param path 文件路径
 @return 文件大小
 */
- (unsigned long long)zj_fileSizeAtPath:(NSString *)path;

+ (NSURL *)zj_documentsURL;

+ (NSString *)zj_documentsPath;

+ (NSURL *)zj_libraryURL;

+ (NSString *)zj_libraryPath;

+ (NSURL *)zj_cachesURL;

+ (NSString *)zj_cachesPath;

@end
