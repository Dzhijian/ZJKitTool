//
//  NSString+ZJHelperKit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZJHelperKit)



#pragma mark - Encrypt and decrypt
/**
 *    MD5加密，将字符串转换为32位md5字符串。
 *
 *    @return 32bit md5
 */
- (NSString *)zj_toMD5;

/**
 *    16位MD5加密，将字符串转换为16bit md5字符串。
 *
 *    @return 16bit md5
 */
- (NSString *)zj_to16MD5;

/**
 *    Encrypt the string with sha1 argorithm.
 *
 *    @return The sha1 string.
 */
- (NSString *)zj_sha1;

/**
 *    Encrypt the string with sha256 argorithm.
 *
 *    @return The sha256 string.
 */
- (NSString *)zj_sha256;

/**
 *    Encrypt the string with sha512 argorithm.
 *
 *    @return The sha512 string.
 */
- (NSString *)zj_sha512;

#pragma mark - Data convert to string or string to data.
/**
 *    Convert the current string to data.
 *
 *    @return data object if convert successfully, otherwise nil.
 */
- (NSData *)zj_toData;

/**
 *    Convert a data object to string.
 *
 *    @param data    The data will be converted.
 *
 *    @return string object if convert successfully, otherwise nil.
 */
+ (NSString *)zj_toStringWithData:(NSData *)data;

#pragma mark - Check email, phone, tel, or persion id.
/**
 *    Check whether the string is a valid kind of email format.
 *
 *    @return YES if it is a valid format, otherwise false.
 */
- (BOOL)zj_isEmail;

/**
 *    Check whether the string is a valid kind of email format.
 *
 *    @param email The string to be checked.
 *
 *    @return YES if it is a valid format, otherwise false.
 */
+ (BOOL)zj_isEmail:(NSString *)email;

/**
 *    Check whether the string is a valid kind of mobile phone format.
 *  Now only check 11 numbers and begin with 1.
 *
 *    @return YES if passed, otherwise false.
 */
- (BOOL)zj_isMobilePhone;

/**
 *    Check whether the string is a valid kind of mobile phone format.
 *
 *  @param phone The phone to be checked.
 *
 *    @return YES if passed, otherwise false.
 */
+ (BOOL)zj_isMobilePhone:(NSString *)phone;

/**
 *    Check whether it is a valid kind of tel number format.
 *
 *    @return YES if passed, otherwise false.
 */
- (BOOL)zj_isTelNumber;

/**
 *    Check whether it is a valid kind of tel number format.
 *
 *    @param telNumber    The tel number to be checked.
 *
 *    @return YES if passed, otherwise false.
 */
+ (BOOL)zj_isTelNumber:(NSString *)telNumber;

/**
 *    Check whether it is a valid kind of Chinese Persion ID
 *
 *    @return YES if it is valid kind of PID, otherwise false.
 */
- (BOOL)zj_isPersonID;

/**
 *    Check whether it is a valid kind of Chinese Persion ID
 *
 *    @param PID    The Chinese Persion ID to be checked.
 *
 *    @return YES if it is valid kind of PID, otherwise false.
 */
+ (BOOL)zj_isPersonID:(NSString *)PID;

#pragma mark - Trim Character
/**
 *    Trim the left blank space
 *
 *    @return The new string without left blank space.
 */
- (NSString *)zj_trimLeft;

/**
 *    Trim the right blank space
 *
 *    @return The new string without right blank space.
 */
- (NSString *)zj_trimRight;

/**
 *    Trim the left and the right blank space
 *
 *    @return The new string without left and right blank space.
 */
- (NSString *)zj_trim;

/**
 *    Trim all blank space in the string.
 *
 *    @return The new string without blank space.
 */
- (NSString *)zj_trimAll;

/**
 *    Trim letters.
 *
 *    @return The new string without letters.
 */
- (NSString *)zj_trimLetters;

/**
 *    修剪所有指定的字符。
 *
 *    @param character    The character to be trimed.
 *
 *    @return The new string without the specified character.
 */
- (NSString *)zj_trimCharacter:(unichar)character;

/**
 *    修剪空白。
 *
 *    @return The new string without white space.
 */
- (NSString *)zj_trimWhitespace;

/**
 *    裁剪所有空格和新行。
 *
 *    @return The new string without white space and new line.
 */
- (NSString *)zj_trimWhitespaceAndNewLine;

#pragma mark - Check letters, numbers or letter and numbers
/**
 *    检查它是否只包含字母。
 *
 *    @return YES if only containing letters, otherwise NO.
 */
- (BOOL)zj_isOnlyLetters;

/**
 *    检查它是否只包含数字。
 *
 *    @return YES if only containing digit numbers, otherwise NO.
 */
- (BOOL)zj_isOnlyDigits;

/**
 *    检查它是否只包含字母和数字。
 *
 *    @return YES if only containing letters and digit numbers, otherwise NO.
 */
- (BOOL)zj_isOnlyAlphaNumeric;

#pragma mark - URL
/**
 *    尝试将字符串转换为NSURL对象。
 *
 *    @return NSURL object if converts successfully, otherwise nil.
 */
- (NSURL *)zj_toURL;

/**
 *    尝试做一个url编码。
 *
 *    @return Encoded string.
 */
- (NSString *)zj_URLEncode;

#pragma mark - HTML
/**
 *    在字符串中过滤html标签。
 *
 *    @return A new string without html tags.
 */
- (NSString *)zj_filterHtml;

/**
 *    在指定的字符串中使用Fileter html标记。
 *
 *    @param html    The specified html string.
 *
 *    @return A new string without html tags.
 */
+ (NSString *)zj_filterHTML:(NSString *)html;

#pragma mark - Get document/tmp/Cache path
/**
 *    获取文档的绝对路径。
 *
 *    @return Document path.
 */
+ (NSString *)zj_documentPath;

/**
 *    获取tmp的绝对路径。
 *
 *    @return Tmp path
 */
+ (NSString *)zj_tmpPath;

/**
 *    获取高速缓存的绝对路径。
 *
 *    @return Cache absolute path
 */
+ (NSString *)zj_cachePath;

#pragma mark - String operation
/**
 *    检查当前字符串是否包含子字符串。
 *
 *    @param substring    Substring
 *
 *    @return YES if containing, otherwise NO.
 */
- (BOOL)zj_isContainString:(NSString *)substring;




@end
