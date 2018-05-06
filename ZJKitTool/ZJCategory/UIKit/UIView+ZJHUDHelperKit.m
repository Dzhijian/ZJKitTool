//
//  UIView+ZJHUDHelperKit.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/22.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "UIView+ZJHUDHelperKit.h"
#import <MBProgressHUD/MBProgressHUD.h>

#define kWarningDuration   1.8
#define kTimeOutDuration   30
@implementation UIView (ZJHUDHelperKit)

/*
 程序线程原则:所有用户可见的操作必须放置在主线程中执行
 用户不可见的可以放在子线程中执行,来提升程序流畅性.
 */
- (void)zj_showWarning:(NSString *)words{
    //为了避免重复提示的重合现象
    //为了防止调用此方法的线程是子线程,导致项目崩溃, 所以强制让下方代码在主线程中执行
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self animated:NO];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeText;
        //这个显示单行文字
        //  hud.label.text = words;
        //这个可以显示多行文字
        
        hud.detailsLabel.text = words;
        hud.detailsLabel.font =[UIFont systemFontOfSize:16];
        [hud hideAnimated:YES afterDelay:kWarningDuration];
        
        //  [hud hide:YES afterDelay:kWarningDuration];
    });
    
    
    /*
     多线程实现方式:
     1.pThread :纯c的, 跨平台
     2.NSThread:苹果官方有一个已失效的文档, 显示NSThread就是对pThread的封装
     3.GCD: iOS专有的多线程技术, 认为 GCD对于iOS的CPU的线程技术有各种优化. 纯C语法的
     4.NSOperation:就是对GCD的封装, 不过多了几个功能.
     */
}
- (void)zj_showBusyHUD{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self animated:NO];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeCustomView;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        NSArray *imageNames = @[@"001", @"002",@"003",@"004",@"005",@"006", @"007"];
        NSMutableArray<UIImage *> *imgs = [NSMutableArray new];
        for (NSString *imageName in imageNames) {
            if ([UIImage imageNamed:imageName]!= nil) {
                 [imgs addObject:[UIImage imageNamed:imageName]];
            }
           
        }
        imageView.animationImages = imgs;
        hud.customView = imageView;
        imageView.animationDuration = 1.0;
        [imageView startAnimating];
//         hud.color = [UIColor clearColor];
        hud.backgroundColor=[UIColor clearColor];
        //[hud hide:YES afterDelay:kTimeOutDuration];
        [hud hideAnimated:YES afterDelay:kWarningDuration];
    });
}
- (void)zj_hideBusyHUD{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self animated:YES];
    });
}
-(void)zj_showText:(NSString*)word
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self animated:NO];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode =  MBProgressHUDModeIndeterminate;
        hud.label.text=word;
        // hud.labelText = word;
        //[hud hide:YES afterDelay:kWarningDuration];
        
    });
}
- (void)zj_showWarning:(NSString *)words and:(CGFloat )time{
    //为了避免重复提示的重合现象
    //为了防止调用此方法的线程是子线程,导致项目崩溃, 所以强制让下方代码在主线程中执行
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self animated:NO];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeText;
        //这个显示单行文字
        //  hud.label.text = words;
        //这个可以显示多行文字
        hud.detailsLabel.text = words;
        hud.detailsLabel.font =[UIFont systemFontOfSize:16];
        [hud hideAnimated:YES afterDelay:time];
        //  [hud hide:YES afterDelay:kWarningDuration];
    });
    
}


@end
