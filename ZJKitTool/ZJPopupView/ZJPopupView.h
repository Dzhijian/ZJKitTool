//
//  ZJPopupView.h
//  ZJKitTool
//
//  Created by James on 2018/11/13.
//  Copyright © 2018 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJBasePopupView.h"
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    ZJPopupAnimationTransition,
    ZJPopupAnimationRotation,
    ZJPopupAnimationSacle,
    ZJPopupAnimationAlpha,
} ZJPopupAnimationStyle;


@protocol ZJPopupViewDelegate <NSObject>

@optional
// 将要显示 popview
-(void)zj_willShowPopupView;
// 隐藏 popview
-(void)zj_didHiddenPopupView;
// 点击背景层事件
-(void)zj_clickBgViewAction;
// 点击显示视图事件
-(void)zj_clickShowViewAction;

@end

@interface ZJPopupView : UIView

/// 代理
@property (nonatomic, weak) id<ZJPopupViewDelegate>  delegate;
/** 弹出视图 */
@property (nonatomic, strong) ZJBasePopupView *showView;
/** 弹出视图的宽度 */
@property (nonatomic, assign) CGSize popupViewFrame;
/** 动画时间  默认 0.25 */
@property (nonatomic, assign) double durationTime;
/** 背景颜色透明度 */
@property (nonatomic, assign) double backgroundAlpha;
/** 背景是否可以点击 */
@property (nonatomic, assign) BOOL backgroundIsClick;
/** 动画样式 */
@property (nonatomic, assign) ZJPopupAnimationStyle animationStyle;
/** 是否添加Blur */
@property (nonatomic, assign) BOOL isBlurEffect;
/** 关闭按钮 */
@property (nonatomic, strong) UIButton *closeBtn;
/** 弹窗父视图 */
@property (nonatomic, strong) UIView *superView;


+(instancetype)zj_showWithPopupView:(ZJBasePopupView *)popupView;



/**
 * 3.快速创建弹窗(popView,viewSize,代理,动画类型,时间,背景颜色,允许背景点击)
 
 @param showView 显示的 popView
 @param size popViewSize 大小
 @param delegate 代理
 @param durationTime 动画时间
 @param bgAlpha 背景颜色
 @param isBGClickAction 是否允许点击背景
 @param animaStyle 动画类型
 @return ZJPopUpView
 */
+(instancetype)zj_showPopView:(ZJBasePopupView *)showView
                     viewSize:(CGSize)size
                     delegate:(id<ZJPopupViewDelegate>)delegate
                 durationTime:(double)durationTime
                      bgAlpha:(CGFloat)bgAlpha
              isBGClickAction:(BOOL)isBGClickAction
                   animaStyle:(ZJPopupAnimationStyle)animaStyle;

/**
 * 2.快速创建弹窗(popView,viewSize,代理,动画类型,时间,背景颜色,允许背景点击,毛片玻璃,关闭按钮)
 
 @param showView 显示的 popView
 @param size popViewSize 大小
 @param delegate 代理
 @param durationTime 动画时间
 @param bgAlpha 背景颜色
 @param isBGClickAction 是否允许点击背景
 @param isBlurEffect 毛片玻璃效果
 @param animaStyle 动画类型
 @param closeBtn 关闭按钮
 @return ZJPopUpView
 */
+(instancetype)zj_showPopView:(ZJBasePopupView *)showView
                    superView:(UIView * __nullable)superView
                     viewSize:(CGSize)size
                     delegate:(id<ZJPopupViewDelegate>)delegate
                 durationTime:(double)durationTime
                      bgAlpha:(CGFloat)bgAlpha
              isBGClickAction:(BOOL)isBGClickAction
                 isBlurEffect:(BOOL)isBlurEffect
                   animaStyle:(ZJPopupAnimationStyle)animaStyle
                     closeBtn:(UIButton * __nullable)closeBtn;


/**
 * 1.ZJPopUpView 初始化创建弹窗(popView,viewSize,代理,动画类型,时间,背景颜色,允许背景点击,毛片玻璃,关闭按钮)

 @param showView 显示的 popView
 @param size popViewSize 大小
 @param delegate 代理
 @param durationTime 动画时间
 @param bgAlpha 背景颜色
 @param isBGClickAction 是否允许点击背景
 @param isBlurEffect 毛片玻璃效果
 @param animaStyle 动画类型
 @param closeBtn 关闭按钮
 @return ZJPopUpView
 */
-(instancetype)initWithShowView:(ZJBasePopupView *)showView
                      superView:(UIView * __nullable)superView
                       viewSize:(CGSize)size
                       delegate:(id<ZJPopupViewDelegate>)delegate
                   durationTime:(double)durationTime
                        bgAlpha:(CGFloat)bgAlpha
                isBGClickAction:(BOOL)isBGClickAction
                   isBlurEffect:(BOOL)isBlurEffect
                     animaStyle:(ZJPopupAnimationStyle)animaStyle
                       closeBtn:(UIButton * __nullable)closeBtn; 


/**
 *  显示 popView
 */
-(void)zj_showPopupView;

/**
 * 隐藏 popView
 */
-(void)zj_hiddenPopupView;

@end

NS_ASSUME_NONNULL_END
