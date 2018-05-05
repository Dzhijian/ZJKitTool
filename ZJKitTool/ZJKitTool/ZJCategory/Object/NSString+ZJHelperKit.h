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
 *    用sha1 argm加密字符串。
 *
 *    @return  sha1 字符串.
 */
- (NSString *)zj_sha1;

/**
 *    用sha256 argm加密字符串。
 *
 *    @return The sha256 字符串.
 */
- (NSString *)zj_sha256;

/**
 *    用sha512 argm加密字符串。
 *
 *    @return The sha512 字符串.
 */
- (NSString *)zj_sha512;

#pragma mark - Data convert to string or string to data.
/**
 *    将当前字符串转换为数据。
 *
 *    @return 如果数据对象成功转换，否则为nil。.
 */
- (NSData *)zj_toData;

/**
 *    将数据对象转换为字符串。
 *
 *    @param data    数据将被转换。
 *
 *    @return 如果转换成功，则为string对象，否则为nil。
 */
+ (NSString *)zj_toStringWithData:(NSData *)data;

#pragma mark - Check email, phone, tel, or persion id.
/**
 *    检查字符串是否是一种有效的电子邮件格式。
 *
 *    返回YES，如果它是有效格式，否则为false。
 */
- (BOOL)zj_isEmail;

/**
 *    检查字符串是否是一种有效的电子邮件格式。
 *
 *    @param email 要检查的字符串。
 *
 *    返回YES，如果它是有效格式，否则为false。
 */
+ (BOOL)zj_isEmail:(NSString *)email;

/**
 *    检查字符串是否是一种有效的移动电话格式。
 *    只检查11个数字，从1开始。
 *
 *    如果通过，返回YES，否则为false。
 */
- (BOOL)zj_isMobilePhone;

/**
 *    检查字符串是否是一种有效的移动电话格式。
 *
 *    @param phone 要检查的电话。
 *
 *    如果通过，返回YES，否则为false。
 */
+ (BOOL)zj_isMobilePhone:(NSString *)phone;

/**
 *    检查它是否是一种有效的电话号码格式。
 *
 *    如果通过，返回YES，否则为false。
 */
- (BOOL)zj_isTelNumber;

/**
 *    检查它是否是一种有效的电话号码格式。
 *
 *    @param telNumber    要检查的电话号码。
 *
 *    如果通过，返回YES，否则为false。
 */
+ (BOOL)zj_isTelNumber:(NSString *)telNumber;

/**
 *    检查它是否是一种有效的中国Persion ID。
 *
 *    如果是有效的PID，则返回YES，否则为false
 */
- (BOOL)zj_isPersonID;

/**
 *    检查它是否是一种有效的中国Persion ID。
 *
 *    @param PID    要检查的是中国的Persion ID。
 *
 *    如果是有效的PID，则返回YES，否则为false
 */
+ (BOOL)zj_isPersonID:(NSString *)PID;

#pragma mark - Trim Character
/**
 *    修剪左边空白区域。
 *
 *    返回新字符串而不留下空格。
 */
- (NSString *)zj_trimLeft;

/**
 *    修剪右边空白区域,返回新字符串而不留下空格。
 */
- (NSString *)zj_trimRight;

/**
 *    修剪左边和右边的空白区域,返回没有左和右空白空间的新字符串。
 */
- (NSString *)zj_trim;

/**
 *    将字符串中的所有空格都修剪掉,返回没有空格的新字符串。
 */
- (NSString *)zj_trimAll;

/**
 *    修剪字母,返回没有字母的返回新的字符串.
 */
- (NSString *)zj_trimLetters;

/**
 *    修剪所有指定的字符。
 *
 *    @param character    要修改的字符。
 *
 *    返回没有指定字符的新字符串。
 */
- (NSString *)zj_trimCharacter:(unichar)character;

/**
 *    修剪空白,返回没有空格的新字符串
 */
- (NSString *)zj_trimWhitespace;

/**
 *    裁剪所有空格和新行,返回没有空格和新行的新字符串。
 */
- (NSString *)zj_trimWhitespaceAndNewLine;

#pragma mark - Check letters, numbers or letter and numbers
/**
 *    检查它是否只包含字母。
 *
 *    返回YES，如果只包含字母，否则不会。
 */
- (BOOL)zj_isOnlyLetters;

/**
 *    检查它是否只包含数字。
 *
 *    返回YES，只包含数字，否则不是。
 */
- (BOOL)zj_isOnlyDigits;

/**
 *    检查它是否只包含字母和数字。
 *
 *    返回YES，如果只包含字母和数字，否则不。
 */
- (BOOL)zj_isOnlyAlphaNumeric;

#pragma mark - URL
/**
 *    尝试将字符串转换为NSURL对象。
 *
 *    返回一个 URL。
 */
- (NSURL *)zj_toURL;

/**
 *    尝试做一个url编码。
 *
 *    返回编码的字符串
 */
- (NSString *)zj_URLEncode;

#pragma mark - HTML
/**
 *    在字符串中过滤html标签。
 *
 *    返回一个没有html标记的新字符串。
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



///  追加文档目录
- (NSString *)appendDocumentPath;
///  追加缓存目录
- (NSString *)appendCachePath;
///  追加临时目录
- (NSString *)appendTempPath;


/**
 根据左边和右边的字符串,获得中间特定字符串
 @param strLeft 左边匹配字符串
 @param strRight 右边匹配的字符串
 */
- (NSString*)zj_substringWithinBoundsLeft:(NSString*)strLeft right:(NSString*)strRight;

/**
 阿拉伯数字转成中文
 
 @param arebic 阿拉伯数字
 @return 返回的中文数字
 */
+(NSString *)zj_translation:(NSString *)arebic;

/**
 字符串反转
 
 @param str 要反转的字符串
 @return 反转之后的字符串
 */
- (NSString*)zj_reverseWordsInString:(NSString*)str;

/**
 获得汉字的拼音
 
 @param chinese 汉字
 @return 拼音
 */
+ (NSString *)zj_transform:(NSString *)chinese;

/** 判断URL中是否包含中文 */
- (BOOL)isContainChinese;

/** 获取字符数量 */
- (int)wordsCount;

/** JSON字符串转成NSDictionary */
-(NSDictionary *)dictionaryValue;


/**
 *  手机号码的有效性:分电信、联通、移动和小灵通
 */
- (BOOL)isMobileNumberClassification;
/**
 *  手机号有效性
 */
- (BOOL)isMobileNumber;

/**
 *  邮箱的有效性
 */
- (BOOL)isEmailAddress;

/**
 *  简单的身份证有效性
 *
 */
- (BOOL)simpleVerifyIdentityCardNum;

/**
 *  精确的身份证号码有效性检测
 *
 *  @param value 身份证号
 */
+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value;

/**
 *  车牌号的有效性
 */
- (BOOL)isCarNumber;

/**
 *  银行卡的有效性
 */
- (BOOL)bankCardluhmCheck;

/**
 *  IP地址有效性
 */
- (BOOL)isIPAddress;

/**
 *  Mac地址有效性
 */
- (BOOL)isMacAddress;

/**
 *  网址有效性
 */
- (BOOL)isValidUrl;

/**
 *  纯汉字
 */
- (BOOL)isValidChinese;

/**
 *  邮政编码
 */
- (BOOL)isValidPostalcode;

/**
 *  工商税号
 */
- (BOOL)isValidTaxNo;



/** 清除html标签 */
- (NSString *)stringByStrippingHTML;

/** 清除js脚本 */
- (NSString *)stringByRemovingScriptsAndStrippingHTML;

/** 去除空格 */
- (NSString *)trimmingWhitespace;

/** 去除空格与空行 */
- (NSString *)trimmingWhitespaceAndNewlines;



/** 加密 */
- (NSString *)toMD5;
- (NSString *)to16MD5;
- (NSString *)sha1;
- (NSString *)sha256;
- (NSString *)sha512;

#pragma mark - Data convert to string or string to data.
/**
 *    string与Data转化
 */
- (NSData *)toData;
+ (NSString *)toStringWithData:(NSData *)data;

/**
 *  正则表达式简单说明
 *  语法：
 .       匹配除换行符以外的任意字符
 \w      匹配字母或数字或下划线或汉字
 \s      匹配任意的空白符
 \d      匹配数字
 \b      匹配单词的开始或结束
 ^       匹配字符串的开始
 $       匹配字符串的结束
 *       重复零次或更多次
 +       重复一次或更多次
 ?       重复零次或一次
 {n}     重复n次
 {n,}     重复n次或更多次
 {n,m}     重复n到m次
 \W      匹配任意不是字母，数字，下划线，汉字的字符
 \S      匹配任意不是空白符的字符
 \D      匹配任意非数字的字符
 \B      匹配不是单词开头或结束的位置
 [^x]     匹配除了x以外的任意字符
 [^aeiou]匹配除了aeiou这几个字母以外的任意字符
 *?      重复任意次，但尽可能少重复
 +?      重复1次或更多次，但尽可能少重复
 ??      重复0次或1次，但尽可能少重复
 {n,m}?     重复n到m次，但尽可能少重复
 {n,}?     重复n次以上，但尽可能少重复
 \a      报警字符(打印它的效果是电脑嘀一声)
 \b      通常是单词分界位置，但如果在字符类里使用代表退格
 \t      制表符，Tab
 \r      回车
 \v      竖向制表符
 \f      换页符
 \n      换行符
 \e      Escape
 \0nn     ASCII代码中八进制代码为nn的字符
 \xnn     ASCII代码中十六进制代码为nn的字符
 \unnnn     Unicode代码中十六进制代码为nnnn的字符
 \cN     ASCII控制字符。比如\cC代表Ctrl+C
 \A      字符串开头(类似^，但不受处理多行选项的影响)
 \Z      字符串结尾或行尾(不受处理多行选项的影响)
 \z      字符串结尾(类似$，但不受处理多行选项的影响)
 \G      当前搜索的开头
 \p{name}     Unicode中命名为name的字符类，例如\p{IsGreek}
 (?>exp)     贪婪子表达式
 (?<x>-<y>exp)     平衡组
 (?im-nsx:exp)     在子表达式exp中改变处理选项
 (?im-nsx)       为表达式后面的部分改变处理选项
 (?(exp)yes|no)     把exp当作零宽正向先行断言，如果在这个位置能匹配，使用yes作为此组的表达式；否则使用no
 (?(exp)yes)     同上，只是使用空表达式作为no
 (?(name)yes|no) 如果命名为name的组捕获到了内容，使用yes作为表达式；否则使用no
 (?(name)yes)     同上，只是使用空表达式作为no
 
 捕获
 (exp)               匹配exp,并捕获文本到自动命名的组里
 (?<name>exp)        匹配exp,并捕获文本到名称为name的组里，也可以写成(?'name'exp)
 (?:exp)             匹配exp,不捕获匹配的文本，也不给此分组分配组号
 零宽断言
 (?=exp)             匹配exp前面的位置
 (?<=exp)            匹配exp后面的位置
 (?!exp)             匹配后面跟的不是exp的位置
 (?<!exp)            匹配前面不是exp的位置
 注释
 (?#comment)         这种类型的分组不对正则表达式的处理产生任何影响，用于提供注释让人阅读
 
 *  表达式：\(?0\d{2}[) -]?\d{8}
 *  这个表达式可以匹配几种格式的电话号码，像(010)88886666，或022-22334455，或02912345678等。
 *  我们对它进行一些分析吧：
 *  首先是一个转义字符\(,它能出现0次或1次(?),然后是一个0，后面跟着2个数字(\d{2})，然后是)或-或空格中的一个，它出现1次或不出现(?)，
 *  最后是8个数字(\d{8})
 */

@end
