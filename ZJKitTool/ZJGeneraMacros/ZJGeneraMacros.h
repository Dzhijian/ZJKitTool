
//
//  ZJGeneraMacros.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/6/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//
/**
 *  ZJKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下。😆
 */


#ifndef ZJGeneraMacros_h
#define ZJGeneraMacros_h
// 获得弱引用对象
#define kWeakObject(object) __weak __typeof(object) weakObject = object;

// 弱引用的对象。
#define kWeak(caller, object) __weak __typeof(object) caller = object;

// 强引用对象。
#define kStrongObject(object) __strong __typedef(object) strongObject = object;

// 获取主线程
#define kMainThread (dispatch_get_main_queue())

// 获取全局队列
#define kGlobalThread dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

// 弧度转换为度。
#define kRadiansToDegrees(radians) ((radians) * (180.0 / M_PI))

// 度转换为randians。
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

// 不同屏幕尺寸字体适配
#define kScreenWidthRatio  (kScreenWidth / 375.0)
#define kScreenHeightRatio (kScreenHeight / 667.0)
#define AdaptedWidth(x)  ceilf((x) * kScreenWidthRatio)
#define AdaptedHeight(x) ceilf((x) * kScreenHeightRatio)
// 字体适配
#define AdaptedFontSize(R)     [UIFont systemFontOfSize:AdaptedWidth(R)]



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

// 更简单的方法是使用十六进制颜色来生成颜色。
#define kHexRGB(rgb) k16RGBColor(rgb)

// 更简单的生成颜色对象的方法。
#define kRGB(r,g,b) kRGBColor(r,g,b)

// 使用rgb和alpha生成颜色对象的更简单方法。
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

// 判断它是否是空字符串。
#define kIsEmptyString(s) (s == nil || [s isKindOfClass:[NSNull class]] || ([s isKindOfClass:[NSString class]] && s.length == 0))

// 判断它是否为nil或null对象。
#define kIsEmptyObject(obj) (obj == nil || [obj isKindOfClass:[NSNull class]])

// 判断它是否是一个有效的字典。
#define kIsDictionary(objDict) (objDict != nil && [objDict isKindOfClass:[NSDictionary class]])

// 判断它是否是一个有效的数组。
#define kIsArray(objArray) (objArray != nil && [objArray isKindOfClass:[NSArray class]])

//  判断是否是ipad
#define kIsIPad \
([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)]\
&& [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

// 判断当前定位是否为横向。
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

#endif /* ZJGeneraMacros_h */
