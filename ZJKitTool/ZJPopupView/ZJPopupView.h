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

@interface ZJPopupView : UIView

-(instancetype)initWithShowView:(ZJBasePopupView *)showView viewSize:(CGSize)size  style:(ZJPopupAnimationStyle)style;

-(void)zj_showPopupView;
-(void)zj_hiddenPopupView;
@end

NS_ASSUME_NONNULL_END
