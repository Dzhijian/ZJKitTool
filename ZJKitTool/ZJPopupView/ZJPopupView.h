//
//  ZJPopupView.h
//  ZJKitTool
//
//  Created by James on 2018/11/13.
//  Copyright © 2018 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJBasePopupView.h"


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

-(instancetype)initWithShowView:(ZJBasePopupView *)showView viewSize:(CGSize)size delegate:(id<ZJPopupViewDelegate>)delegate style:(ZJPopupAnimationStyle)style;


-(void)zj_showPopupView;

-(void)zj_hiddenPopupView;
@end

NS_ASSUME_NONNULL_END
