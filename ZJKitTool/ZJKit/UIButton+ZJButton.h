//
//  UIButton+ZJButton.h
//  ZJUIKit
//
//  Created by dzj on 2017/12/1.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    ZJButtonImagePositionLeft,              // 图片在左
    ZJButtonImagePositionRight,             // 图片在右
    ZJButtonImagePositionTop,               // 图片在上
    ZJButtonImagePositionBottom             // 图片在下
} ZJButtonImagePosition;


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


/**
 *  设置Button的背景色
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;


/**
 *  image和title图文混排
 *
 *  @param  position    图片的位置，默认left
 *  @param  spacing     图片和标题的间隔
 *
 *  @return     返回button最小的size
 *
 *  注意，需要先设置好image、title、font。网络图片需要下载完成后再调用此方法，或设置同大小的placeholder
 */
- (CGSize)zj_setButtonImagePosition:(ZJButtonImagePosition)position spacing:(CGFloat)spacing;

/** 多久之后开始执行 */
- (void)zj_startTime:(NSInteger)timeout waitBlock:(void(^)(NSInteger remainTime))waitBlock finishBlock:(void(^)(void))finishBlock;

/** 点击按钮Block */
-(void)zj_addBtnActionHandler:(ButtonTouchUpInsideBlock)touchHandler;

/** 显示菊花 */
-(void)zj_showIndicator;

/** 隐藏菊花 */
-(void)zj_hideIndicator;



@end
