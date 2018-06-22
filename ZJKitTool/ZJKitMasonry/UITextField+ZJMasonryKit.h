//
//  UITextField+ZJMasonryKit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/17.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ZJKitMasonryTool.h"


@interface UITextField (ZJMasonryKit)

/**
 *
 *   如果您想在光标之前指定一个左边缘，只需定义它。
 *
 *  @default 默认值是8px。
 */
@property (nonatomic, assign) CGFloat zj_leftMarginOfCursor;

/**
 *
 *    创建一个包含holder、super view和约束的文本字段。
 *
 *    @param holder              The place holder.
 *    @param superView        The super view of created text field.
 *    @param constraints    向文本字段添加约束，如果superview是nil，它将被忽略。
 *
 *    @return The text field instance.
 */
+ (instancetype)zj_textFieldWithHolder:(NSString *)holder
                              superView:(UIView *)superView
                            constraints:(ZJConstrainMaker)constraints;

/**
 *
 *    创建一个包含holder、delegate superView和约束的文本字段。
 *
 *    @param holder              The place holder.
 *    @param delegate            The text field delegate.
 *    @param superView        The super view of created text field.
 *    @param constraints    Add constraints to the text field, if superview is nil, it will be ignored.
 *
 *    @return The text field instance.
 */
+ (UITextField *)zj_textFieldWithHolder:(NSString *)holder
                                delegate:(id<UITextFieldDelegate>)delegate
                               superView:(UIView *)superView
                             constraints:(ZJConstrainMaker)constraints;

/**
 *
 *    创建包含holder、text、superview和约束的文本字段。
 *
 *    @param holder              The place holder.
 *    @param text                 The text field default text.
 *    @param superView        The super view of created text field.
 *    @param constraints    Add constraints to the text field, if superview is nil, it will be ignored.
 *
 *    @return The text field instance.
 */
+ (UITextField *)zj_textFieldWithHolder:(NSString *)holder
                                    text:(NSString *)text
                               superView:(UIView *)superView
                             constraints:(ZJConstrainMaker)constraints;

/**
 *
 *    创建包含holder、text、super view和约束的文本字段。
 *
 *    @param holder              The place holder.
 *    @param text                 The text field default text.
 *    @param delegate            The text field delegate.
 *    @param superView        The super view of created text field.
 *    @param constraints    Add constraints to the text field, if superview is nil, it will be ignored.
 *
 *    @return The text field instance.
 */
+ (UITextField *)zj_textFieldWithHolder:(NSString *)holder
                                    text:(NSString *)text
                                delegate:(id<UITextFieldDelegate>)delegate
                               superView:(UIView *)superView
                             constraints:(ZJConstrainMaker)constraints;


@end
