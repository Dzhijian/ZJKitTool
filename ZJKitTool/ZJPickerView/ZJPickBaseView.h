//
//  ZJPickBaseView.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/6/27.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJPickBaseView : UIView
/**
 *  背景图层
 */
@property (nonatomic, strong) UIView        *backView;
/**
 *  顶部视图
 */
@property (nonatomic, strong) UIView        *topView;
/**
 *  弹出的视图
 */
@property (nonatomic, strong) UIView        *alertView;
/**
 *  左边的按钮
 */
@property (nonatomic, strong) UIButton      *leftBtn;
/**
 *  右边的按钮
 */
@property (nonatomic, strong) UIButton      *rightBtn;
/**
 *  标题
 */
@property (nonatomic, strong) UILabel       *titleLab;
/**
 *  分割线
 */
@property (nonatomic, strong) UIView        *lineView;



/**
 *  初始化视图
 */
-(void)initWithAllView;

/**
 * 点击背景图
 */
-(void)backViewTapAction:(UITapGestureRecognizer *)gesture;
/**
 * 点击左边的按钮
 */
-(void)leftBtnClickAction:(UIButton *)sender;
/**
 * 点击右边的按钮
 */
-(void)rightBtnClickAction:(UIButton *)sender;
/**
 *  设置按钮的文本颜色
 */
-(void)setUpConfirmTitleColor:(UIColor *)confirmColor cancelColor:(UIColor *)cancelColor;
@end
