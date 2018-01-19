//
//  UITableView+ZJMarsonryKit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/17.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//



@interface UITableView (ZJMarsonryKit)

/**
 *
 *    Create a table view, if superview is not nil, it will be added constraints
 *  and it's edge will be always equal to super view.
 *
 *    @param superView    The super view for table view.
 *
 *    @return The table view instance.
 */
+ (instancetype)zj_tableViewWithSuperview:(UIView *)superView;

/**
 *
 *    Create a table view, if superview is nil, constraints will be ignored.
 *
 *    @param superView        The super view for table view.
 *    @param constraints    Make constraints for table view.
 *
 *    @return The table view instance.
 */
+ (instancetype)zj_tableViewWithSuperview:(UIView *)superView
                               constraints:(ZJConstrainMaker)constraints;

/**
 *
 *    Create a table view, if superview is not nil, it will be added constraints
 *  and it's edge will be always equal to super view.
 *
 *    @param superView    The super view for table view.
 *    @param delegate   Delgate and dataSource.
 *
 *    @return The table view instance.
 */
+ (instancetype)zj_tableViewWithSuperview:(UIView *)superView delegate:(id)delegate;

/**
 *
 *    Create a table view, if superview is nil, constraints will be ignored.
 *
 *    @param superView        The super view for table view.
 *    @param delegate     Delgate and dataSource.
 *    @param constraints    Make constraints for table view.
 *
 *    @return The table view instance.
 */
+ (instancetype)zj_tableViewWithSuperview:(UIView *)superView
                                  delegate:(id)delegate
                               constraints:(ZJConstrainMaker)constraints;

/**
 *
 *    Create a table view, if superview is nil, constraints will be ignored. Can
 *  specify table view style.
 *
 *    @param superView        The super view for table view.
 *    @param delegate     Delgate and dataSource.
 *    @param style         UITableViewStyle.
 *    @param constraints    Make constraints for table view.
 *
 *    @return The table view instance.
 */
+ (instancetype)zj_tableViewWithSuperview:(UIView *)superView
                                  delegate:(id)delegate
                                     style:(UITableViewStyle)style
                               constraints:(ZJConstrainMaker)constraints;

@end
