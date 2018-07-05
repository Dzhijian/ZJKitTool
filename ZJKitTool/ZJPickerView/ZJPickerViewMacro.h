
//
//  ZJPickerViewMacro.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/6/27.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#ifndef ZJPickerViewMacro_h
#define ZJPickerViewMacro_h

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define kZJPickerHeight 216

#define kZJTopViewHeight 44

// 状态栏高度
#define ZJ_STATUSBAR_HEIGHT ([UIApplication sharedApplication].statusBarFrame.size.height)
#define ZJ_IS_iPhoneX ((ZJ_STATUSBAR_HEIGHT == 44) ? YES : NO)
// 底部安全区域远离高度
#define ZJ_BOTTOM_MARGIN (CGFloat)(ZJ_IS_iPhoneX ? 34 : 0)

#define ZJ_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define ZJ_IS_PAD (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)
// 等比例适配系数
#define kScaleFit (ZJ_IS_IPHONE ? ((ScreenWidth < ScreenHeight) ? ScreenWidth / 375.0f : ScreenWidth / 667.0f) : 1.1f)
// 字体适配
#define kFontSize(value)     [UIFont systemFontOfSize:(value) * kScaleFit]

// 静态库中编写 Category 时的便利宏，用于解决 Category 方法从静态库中加载需要特别设置的问题
#ifndef ZJSYNTH_DUMMY_CLASS

#define ZJSYNTH_DUMMY_CLASS(_name_) \
@interface ZJSYNTH_DUMMY_CLASS_ ## _name_ : NSObject @end \
@implementation ZJSYNTH_DUMMY_CLASS_ ## _name_ @end

#endif
// color  format：0xFFFFFF
#define k16RGBColor(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

// 默认主题颜色
#define kDefaultThemeColor k16RGBColor(0x464646)
// topView视图的背景颜色
#define kBRToolBarColor k16RGBColor(0xFDFDFD)

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif


#endif /* ZJPickerViewMacro_h */
