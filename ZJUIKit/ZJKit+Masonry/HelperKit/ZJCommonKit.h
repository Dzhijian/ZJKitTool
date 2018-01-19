//
//  ZJCommonKit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/17.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Masonry.h>


// Get weak reference object.
#define kWeakObject(object) __weak __typeof(object) weakObject = object;

// Get weak reference object.
#define kWeak(caller, object) __weak __typeof(object) caller = object;

// Get strong reference object.
#define kStrongObject(object) __strong __typedef(object) strongObject = object;

// 获取主线程
#define kMainThread (dispatch_get_main_queue())

// 获取全局队列
#define kGlobalThread dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

// Radians convert to degress.
#define kRadiansToDegrees(radians) ((radians) * (180.0 / M_PI))

// Degrees convert to randians.
#define kDegreesToRadians(angle) ((angle) / 180.0 * M_PI)

// 获取系统版本号
#define kIOSVersion ([UIDevice currentDevice].systemVersion.floatValue)

//  获取 app delegate
#define kAppDelegate ((AppDelegate *)[[UIApplication  sharedApplication] delegate])


#pragma mark - Device Frame 屏幕相关的frame
// 获取屏幕的高度
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

// 获取屏幕的宽度
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)

// 获取屏幕的 bounds
#define kScreenBounds ([UIScreen mainScreen].bounds)



#pragma mark - Generate Color 颜色

///< format：0xFFFFFF
#define k16RGBColor(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

///< format：22,22,22
#define kRGBColor(r, g, b) ([UIColor colorWithRed:(r) / 255.0  \
green:(g) / 255.0  \
blue:(b) / 255.0  \
alpha:1])

///< format：22,22,22,0.5
#define kRGBAColor(r, g, b, a) ([UIColor colorWithRed:(r) / 255.0  \
green:(g) / 255.0  \
blue:(b) / 255.0  \
alpha:(a)])

// More easy way to use hex color to generate color.
#define kHexRGB(rgb) k16RGBColor(rgb)

// More easy way to generate a color object.
#define kRGB(r,g,b) kRGBColor(r,g,b)

// More easy way to generate a color object with rgb and alpha.
#define kRGBA(r,g,b,a) kRGBAColor(r, g, b, a)


#pragma mark - Load Font 加载字体大小
// 设置常规字体大小
#define kFontWithSize(size) [UIFont systemFontOfSize:size]

// 设置加粗字体大小
#define kBoldFontWithSize(size) [UIFont boldSystemFontOfSize:size]


#pragma mark - Load Image 加载图片
// 加载本地图片
#define kImageName(Name) ([UIImage imageNamed:Name])
// 通过路径加载本地图片
#define kImageOfFile(Name) ([UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:Name ofType:nil]])


#pragma mark - System Singletons  单例
// 偏好设置单例
#define kUserDefaults [NSUserDefaults standardUserDefaults]

//通知单例
#define kNotificationCenter  [NSNotificationCenter defaultCenter]

// 文件管理单例
#define kFileManager [NSFileManager defaultManager]

// 简化通知
#define kPostNotificationWithName(notificationName) \
[kNotificationCenter postNotificationName:notificationName object:nil userInfo:nil]

// 简化通知
#define kPostNotificationWithNameAndUserInfo(notificationName, userInfo) \
[kNotificationCenter postNotificationName:notificationName object:nil userInfo:userInfo]

#pragma mark - Judge 判断

// Judge whether it is an empty string.
#define kIsEmptyString(s) (s == nil || [s isKindOfClass:[NSNull class]] || ([s isKindOfClass:[NSString class]] && s.length == 0))

// Judge whether it is a nil or null object.
#define kIsEmptyObject(obj) (obj == nil || [obj isKindOfClass:[NSNull class]])

// Judge whether it is a vaid dictionary.
#define kIsDictionary(objDict) (objDict != nil && [objDict isKindOfClass:[NSDictionary class]])

// Judge whether it is a valid array.
#define kIsArray(objArray) (objArray != nil && [objArray isKindOfClass:[NSArray class]])

// Judge whether the device it is ipad. 判断是否是ipad
#define kIsIPad \
([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)]\
&& [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

// Judge whether current orientation is landscape. 横屏判断
#define kIsLandscape (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))


#pragma makr - Color

#define kBlackColor       [UIColor blackColor]
#define kDarkGrayColor    [UIColor darkGrayColor]
#define kLightGrayColor   [UIColor lightGrayColor]
#define kWhiteColor       [UIColor whiteColor]
#define kRedColor         [UIColor redColor]
#define kBlueColor        [UIColor blueColor]
#define kGreenColor       [UIColor greenColor]
#define kCyanColor        [UIColor cyanColor]
#define kYellowColor      [UIColor yellowColor]
#define kMagentaColor     [UIColor magentaColor]
#define kOrangeColor      [UIColor orangeColor]
#define kPurpleColor      [UIColor purpleColor]
#define kBrownColor       [UIColor brownColor]
#define kClearColor       [UIColor clearColor]


#pragma mark - Blocks

/**
 * For notification block.
 */
typedef void (^ZJNotificationBlock)(NSNotification *sender);

/**
 *    For return a bool block.
 */
typedef void (^ZJBOOLBlock)(BOOL result);

/**
 * For return a array block.
 */
typedef void (^ZJArrayBlock)(NSArray *list);

/**
 * 编辑改变值block
 * 例如： UITextField
 */
typedef void(^ZJEditChangeBlock)(id sender);

/**
 * 改变值Block
 *
 */
typedef void(^ZJChangeValueBlock)(id sender);

/**
 * Button点击事件Block
 *
 */
typedef void(^ZJButtonBlock)(id sender);

/**
 * For button array block.
 *
 * @param index  index in the array.
 * @param sender The responder.
 */
typedef void(^ZJButtonIndexBlock)(NSUInteger index, UIButton *sender);

/**
 * gesture事件Block
 *
 */
typedef void(^ZJGestureBlock)(UIGestureRecognizer *gesture);


/**
 * Tap点击事件Block
 *
 */
typedef void(^ZJTapGestureBlock)(UITapGestureRecognizer *gesture);

/**
 * Tap长按事件Block
 *
 */
typedef void(^ZJLongGestureBlock)(UILongPressGestureRecognizer *gesture);


/**
 * Masonry Block
 *
 */
typedef void(^ZJConstrainMaker)(MASConstraintMaker *make);

@interface ZJCommonKit : NSObject

@end
