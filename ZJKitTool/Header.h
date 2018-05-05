//
//  Header.h
//  ZJUIKit
//
//  Created by dzj on 2017/12/5.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#ifndef Header_h
#define Header_h


#endif /* Header_h */


#import <Masonry.h>

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
// 适配宏
#define HeightRealValue(value) ((value/1334.0)*ScreenHeight)
#define WidthRealValue(value) ((value/750.0)*ScreenWidth)
#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)


#import "UIImageView+WebCache.h"
#import "ZJHelperKit.h"
#import <YYText.h>
#import <YYCategories.h>
#import <YYAsyncLayer.h>
#import <MJRefresh.h>
#import "YYFPSLabel.h"
