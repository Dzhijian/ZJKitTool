//
//  ZJFourChildView.h
//  ZJUIKit
//
//  Created by dzj on 2017/12/8.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZJFourChildViewDelegate <NSObject>

/**
 * 选中后的回调

 @param isprom 是否限量优惠
 @param isVer  是否实名认证
 */
-(void)fourViewBtnSelectedWithIsProm:(BOOL)isprom isVer:(BOOL)isVer;

@end

@interface ZJFourChildView : UIView


@property(nonatomic ,weak) id<ZJFourChildViewDelegate> delegate;

@end
