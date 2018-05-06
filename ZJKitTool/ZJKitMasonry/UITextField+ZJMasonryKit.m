//
//  UITextField+ZJMasonryKit.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/17.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "UITextField+ZJMasonryKit.h"
#import <objc/runtime.h>
#import "UIView+ZJMasonryFrame.h"
static const void *s_leftMarginOfCursorKey = "s_leftMarginOfCursor";

@implementation UITextField (ZJMasonryKit)

- (CGFloat)zj_leftMarginOfCursor {
    
    NSNumber *number = objc_getAssociatedObject(self, s_leftMarginOfCursorKey);
    
    if ([number respondsToSelector:@selector(floatValue)]) {
        return [number floatValue];
    }
    
    return 8.0;
}



- (void)setZj_leftMarginOfCursor:(CGFloat)zj_leftMarginOfCursor {
    objc_setAssociatedObject(self,
                             s_leftMarginOfCursorKey,
                             @(zj_leftMarginOfCursor),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (self.leftView) {
        self.leftView.zj_width = zj_leftMarginOfCursor;
    }
}

+ (instancetype)zj_textFieldWithHolder:(NSString *)holder
                              superView:(UIView *)superView
                            constraints:(ZJConstrainMaker)constraints {
    return [self zj_textFieldWithHolder:holder
                                    text:nil
                               superView:superView
                             constraints:constraints];
}

+ (UITextField *)zj_textFieldWithHolder:(NSString *)holder
                                    text:(NSString *)text
                               superView:(UIView *)superView
                             constraints:(ZJConstrainMaker)constraints {
    return [self zj_textFieldWithHolder:holder
                                    text:text
                                delegate:nil
                               superView:superView
                             constraints:constraints];
}

+ (UITextField *)zj_textFieldWithHolder:(NSString *)holder
                                delegate:(id<UITextFieldDelegate>)delegate
                               superView:(UIView *)superView
                             constraints:(ZJConstrainMaker)constraints {
    return [self zj_textFieldWithHolder:holder
                                    text:nil
                                delegate:delegate
                               superView:superView
                             constraints:constraints];
}

+ (UITextField *)zj_textFieldWithHolder:(NSString *)holder
                                    text:(NSString *)text
                                delegate:(id<UITextFieldDelegate>)delegate
                               superView:(UIView *)superView
                             constraints:(ZJConstrainMaker)constraints {
    UITextField *textField = [[UITextField alloc] init];
    textField.borderStyle = UITextBorderStyleNone;
    textField.leftView = [[UIView alloc] init];
    textField.leftView.backgroundColor = [UIColor clearColor];
    textField.leftView.zj_width = textField.zj_leftMarginOfCursor;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.spellCheckingType = UITextSpellCheckingTypeNo;
    textField.delegate = delegate;
    [superView addSubview:textField];
    
    textField.placeholder = holder;
    textField.text = text;
    
    if (superView && constraints) {
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            constraints(make);
        }];
    }
    
    return textField;
}

@end
