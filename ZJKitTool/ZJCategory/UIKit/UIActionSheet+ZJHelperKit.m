//
//  UIActionSheet+ZJHelperKit.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "UIActionSheet+ZJHelperKit.h"
#import <objc/runtime.h>

@interface UIApplication (HDFActionSheet) <UIActionSheetDelegate>

@end

@implementation UIApplication (HDFActionSheet)

- (void)actionSheet:(nonnull UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.zj_clickedButtonBlock) {
        actionSheet.zj_clickedButtonBlock(actionSheet, buttonIndex);
    }
}

@end

static const void *s_HdfActionSheetClickedButtonBlock = "s_HdfActionSheetClickedButtonBlock";

@implementation UIActionSheet (ZJHelperKit)

- (void)setZj_clickedButtonBlock:(ZJActionSheetClickedButtonBlock)zj_clickedButtonBlock {
    objc_setAssociatedObject(self,
                             s_HdfActionSheetClickedButtonBlock,
                             zj_clickedButtonBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (ZJActionSheetClickedButtonBlock)zj_clickedButtonBlock {
    return objc_getAssociatedObject(self, s_HdfActionSheetClickedButtonBlock);
}

+ (instancetype)zj_showInView:(UIView *)inView
                         title:(NSString *)title
                   cancelTitle:(NSString *)cancelTitle
              destructiveTitle:(NSString *)destructiveTitle
                   otherTitles:(NSArray *)otherTitles
                      callback:(ZJActionSheetClickedButtonBlock)callback {
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:title
                                                    delegate:[UIApplication sharedApplication]
                                           cancelButtonTitle:cancelTitle
                                      destructiveButtonTitle:destructiveTitle
                                           otherButtonTitles:
                         [self zj_objectWithArray:otherTitles atIndex:0],
                         [self zj_objectWithArray:otherTitles atIndex:1],
                         [self zj_objectWithArray:otherTitles atIndex:2],
                         [self zj_objectWithArray:otherTitles atIndex:3],
                         [self zj_objectWithArray:otherTitles atIndex:4],
                         [self zj_objectWithArray:otherTitles atIndex:5],
                         [self zj_objectWithArray:otherTitles atIndex:6],
                         [self zj_objectWithArray:otherTitles atIndex:7],
                         [self zj_objectWithArray:otherTitles atIndex:8],
                         [self zj_objectWithArray:otherTitles atIndex:9],
                         [self zj_objectWithArray:otherTitles atIndex:10],
                         [self zj_objectWithArray:otherTitles atIndex:11],
                         [self zj_objectWithArray:otherTitles atIndex:12],
                         [self zj_objectWithArray:otherTitles atIndex:13],
                         [self zj_objectWithArray:otherTitles atIndex:14],
                         [self zj_objectWithArray:otherTitles atIndex:15],
                         [self zj_objectWithArray:otherTitles atIndex:16],
                         [self zj_objectWithArray:otherTitles atIndex:17],
                         [self zj_objectWithArray:otherTitles atIndex:18],
                         [self zj_objectWithArray:otherTitles atIndex:19],
                         [self zj_objectWithArray:otherTitles atIndex:20],
                         [self zj_objectWithArray:otherTitles atIndex:21],
                         [self zj_objectWithArray:otherTitles atIndex:22],
                         [self zj_objectWithArray:otherTitles atIndex:23],
                         [self zj_objectWithArray:otherTitles atIndex:24],
                         nil];
    as.zj_clickedButtonBlock = callback;
    
    [as showInView:inView];
    
    return as;
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
