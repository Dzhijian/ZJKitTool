//
//  UIButton+ZJButton.h
//  ZJUIKit
//
//  Created by dzj on 2017/12/1.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ButtonTouchUpInsideBlock)(void);

@interface UIButton (ZJButton)

// 创建UIButton
+(instancetype)zj_buttonWithFrame:(CGRect)frame
                            title:(NSString *)title
                       titleColor:(UIColor *)titleColor
                        imageName:(NSString *)imageName
                        backColor:(UIColor *)backColor
                         fontSize:(int)fontSize
                     cornerRadius:(CGFloat)radius
                           traget:(id)traget
                           action:(SEL)action;

/** 多久之后开始执行 */
- (void)zj_startTime:(NSInteger)timeout waitBlock:(void(^)(NSInteger remainTime))waitBlock finishBlock:(void(^)(void))finishBlock;

/** 点击按钮Block */
-(void)zj_addBtnActionHandler:(ButtonTouchUpInsideBlock)touchHandler;

/** 显示菊花 */
-(void)zj_showIndicator;

/** 隐藏菊花 */
-(void)zj_hideIndicator;



@end
