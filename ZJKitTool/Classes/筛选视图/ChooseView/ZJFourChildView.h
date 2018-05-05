//
//  ZJFourChildView.h
//  ZJUIKit
//
//  Created by dzj on 2017/12/8.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//
/**
 *  ZJUIKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJUIKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下。😆
 */

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
