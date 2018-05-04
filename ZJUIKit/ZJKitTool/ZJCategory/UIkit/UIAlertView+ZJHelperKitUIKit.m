//
//  UIAlertView+ZJHelperKitUIKit.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "UIAlertView+ZJHelperKitUIKit.h"
#import <objc/runtime.h>
#import "ZJCommonKit.h"
#import "NSArray+ZJHelperKit.h"

static const void *s_privateAlertViewKey = "s_privateAlertViewKey";
@interface UIApplication (HDFAlertView) <UIAlertViewDelegate>

@end

@implementation UIApplication (HDFAlertView)

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.zj_clickedButtonBlock) {
        alertView.zj_clickedButtonBlock(alertView, buttonIndex);
    }
}

@end


@implementation UIAlertView (ZJHelperKitUIKit)

- (void)setZj_clickedButtonBlock:(ZJAlertClickedButtonBlock)clickedButtonBlock {
    objc_setAssociatedObject(self,
                             s_privateAlertViewKey,
                             clickedButtonBlock,
                             OBJC_ASSOCIATION_COPY);
}

- (ZJAlertClickedButtonBlock)zj_clickedButtonBlock {
    return objc_getAssociatedObject(self, s_privateAlertViewKey);
}

+ (instancetype)zj_showWithTitle:(NSString *)title
                          message:(NSString *)message
                     buttonTitles:(NSArray *)buttonTitles
                            block:(ZJAlertClickedButtonBlock)block {
    NSString *ok = nil;
    if (kIsArray(buttonTitles) && buttonTitles.count > 0) {
        ok = [buttonTitles zj_objectAtIndex:0];
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:[UIApplication sharedApplication]
                                              cancelButtonTitle:ok
                                              otherButtonTitles:
                              [buttonTitles zj_objectAtIndex:1],
                              [buttonTitles zj_objectAtIndex:2],
                              [buttonTitles zj_objectAtIndex:3],
                              [buttonTitles zj_objectAtIndex:4],
                              [buttonTitles zj_objectAtIndex:5],
                              [buttonTitles zj_objectAtIndex:6],
                              [buttonTitles zj_objectAtIndex:7],
                              [buttonTitles zj_objectAtIndex:8],
                              [buttonTitles zj_objectAtIndex:9],
                              [buttonTitles zj_objectAtIndex:10],
                              [buttonTitles zj_objectAtIndex:11],
                              [buttonTitles zj_objectAtIndex:12],
                              [buttonTitles zj_objectAtIndex:13],
                              [buttonTitles zj_objectAtIndex:14],
                              nil];
    alertView.zj_clickedButtonBlock = block;
    
    [alertView show];
    
    return alertView;
}
@end
