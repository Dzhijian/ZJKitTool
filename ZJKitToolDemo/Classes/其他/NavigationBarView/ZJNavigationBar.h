//
//  ZJNavigationBar.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/31.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZJNavigationBarDelegate <NSObject>
@optional


/**
 * 左边返回按钮事件

 @param sender 按钮
 */
-(void)zj_navigationBarLeftBtnAction:(UIButton *)sender;
/**
 * 右边按钮事件
 
 @param sender 按钮
 */
-(void)zj_navigationBarRightBtnAction:(UIButton *)sender;
@end

@interface ZJNavigationBar : UIView
// 标题
@property(nonatomic ,copy)  NSString    *zj_title;
// 左边的返回按钮
@property(nonatomic ,strong) UIButton   *zj_leftBtn;
// 右边的线
@property(nonatomic ,strong) UIButton   *zj_rightBtn;
// 底部的线
@property(nonatomic ,strong) UIView     *lineView;

@property(nonatomic ,weak) id<ZJNavigationBarDelegate> delegate;

// 设置背景颜色  和 控件文本颜色
-(void)zj_setNavBarTint:(UIColor *)tintColor navBackColor:(UIColor *)backColor;

@end
