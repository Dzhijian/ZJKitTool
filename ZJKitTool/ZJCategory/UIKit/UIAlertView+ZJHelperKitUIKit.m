//
//  UIAlertView+ZJHelperKitUIKit.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "UIAlertView+ZJHelperKitUIKit.h"
#import <objc/runtime.h>

// 判断它是否是一个有效的数组。
#define kIsArray(objArray) (objArray != nil && [objArray isKindOfClass:[NSArray class]])
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
//    if (kIsArray(buttonTitles) && buttonTitles.count > 0) {
//        ok = [self zj_objectWithArray:buttonTitles atIndex:0];
//    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:[UIApplication sharedApplication]
                                              cancelButtonTitle:ok
                                              otherButtonTitles:
                              [self zj_objectWithArray:buttonTitles atIndex:0],
                              [self zj_objectWithArray:buttonTitles atIndex:1],
                              [self zj_objectWithArray:buttonTitles atIndex:2],
                              [self zj_objectWithArray:buttonTitles atIndex:3],
                              [self zj_objectWithArray:buttonTitles atIndex:4],
                              [self zj_objectWithArray:buttonTitles atIndex:5],
                              [self zj_objectWithArray:buttonTitles atIndex:6],
                              [self zj_objectWithArray:buttonTitles atIndex:7],
                              [self zj_objectWithArray:buttonTitles atIndex:8],
                              [self zj_objectWithArray:buttonTitles atIndex:9],
                              [self zj_objectWithArray:buttonTitles atIndex:10],
                              
                              nil];
    alertView.zj_clickedButtonBlock = block;
    
    [alertView show];
    
    return alertView;
}

/**
 * 返回安全的索引
 
 @param index 索引
 */
+(id)zj_objectWithArray:(NSArray *)array atIndex:(NSInteger)index{
    NSInteger count = [array count];
    if (count > 0 && index < count) {
        return  [array objectAtIndex:index];
    }
    return nil;
}

@end
