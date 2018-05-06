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
 *    If you want to specify a left margin before cursor, just define this.
 *
 *  @default The default value is 8px.
 */
@property (nonatomic, assign) CGFloat zj_leftMarginOfCursor;

/**
 *
 *    Create a text field with holder, super view and constraints.
 *
 *    @param holder              The place holder.
 *    @param superView        The super view of created text field.
 *    @param constraints    Add constraints to the text field, if superview is nil, it will be ignored.
 *
 *    @return The text field instance.
 */
+ (instancetype)zj_textFieldWithHolder:(NSString *)holder
                              superView:(UIView *)superView
                            constraints:(ZJConstrainMaker)constraints;

/**
 *
 *    Create a text field with holder, super view and constraints.
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
 *    Create a text field with holder, text, super view and constraints.
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
 *    Create a text field with holder, text, super view and constraints.
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
