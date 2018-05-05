//
//  UIActionSheet+ZJHelperKit.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "UIActionSheet+ZJHelperKit.h"
#import <objc/runtime.h>
#import "NSArray+ZJHelperKit.h"

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
                         [otherTitles zj_objectAtIndex:0],
                         [otherTitles zj_objectAtIndex:1],
                         [otherTitles zj_objectAtIndex:2],
                         [otherTitles zj_objectAtIndex:3],
                         [otherTitles zj_objectAtIndex:4],
                         [otherTitles zj_objectAtIndex:5],
                         [otherTitles zj_objectAtIndex:6],
                         [otherTitles zj_objectAtIndex:7],
                         [otherTitles zj_objectAtIndex:8],
                         [otherTitles zj_objectAtIndex:9],
                         [otherTitles zj_objectAtIndex:10],
                         [otherTitles zj_objectAtIndex:11],
                         [otherTitles zj_objectAtIndex:12],
                         [otherTitles zj_objectAtIndex:13],
                         [otherTitles zj_objectAtIndex:14],
                         [otherTitles zj_objectAtIndex:15],
                         [otherTitles zj_objectAtIndex:16],
                         [otherTitles zj_objectAtIndex:17],
                         [otherTitles zj_objectAtIndex:18],
                         [otherTitles zj_objectAtIndex:19],
                         [otherTitles zj_objectAtIndex:20],
                         [otherTitles zj_objectAtIndex:21],
                         [otherTitles zj_objectAtIndex:22],
                         [otherTitles zj_objectAtIndex:23],
                         [otherTitles zj_objectAtIndex:24],
                         [otherTitles zj_objectAtIndex:25],
                         [otherTitles zj_objectAtIndex:26],
                         [otherTitles zj_objectAtIndex:27],
                         [otherTitles zj_objectAtIndex:28],
                         [otherTitles zj_objectAtIndex:29],nil];
    as.zj_clickedButtonBlock = callback;
    
    [as showInView:inView];
    
    return as;
}
@end
