//
//  UIView+ZJHUDHelperKit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/22.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZJHUDHelperKit)

- (void)zj_showWarning:(NSString *)words;

/** 显示繁忙提示 */
- (void)zj_showBusyHUD;
/** 隐藏繁忙提示 */
- (void)zj_hideBusyHUD;

-(void)zj_showText:(NSString*)word;


- (void)zj_showWarning:(NSString *)words and:(CGFloat )time;



@end
