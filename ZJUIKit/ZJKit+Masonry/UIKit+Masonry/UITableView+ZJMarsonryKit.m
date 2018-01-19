//
//  UITableView+ZJMarsonryKit.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/17.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "UITableView+ZJMarsonryKit.h"

@implementation UITableView (ZJMarsonryKit)

+ (instancetype)zj_tableViewWithSuperview:(UIView *)superView {
    return [self zj_tableViewWithSuperview:superView delegate:nil];
}

+ (instancetype)zj_tableViewWithSuperview:(UIView *)superView
                               constraints:(ZJConstrainMaker)constraints {
    return [self zj_tableViewWithSuperview:superView delegate:nil constraints:constraints];
}

+ (instancetype)zj_tableViewWithSuperview:(UIView *)superView delegate:(id)delegate {
    return [self zj_tableViewWithSuperview:superView
                                   delegate:delegate
                                constraints:^(MASConstraintMaker *make) {
                                    if (superView) {
                                        make.edges.mas_equalTo(superView);
                                    }
                                }];
}

+ (instancetype)zj_tableViewWithSuperview:(UIView *)superView
                                  delegate:(id)delegate
                               constraints:(ZJConstrainMaker)constraints {
    return [self zj_tableViewWithSuperview:superView
                                   delegate:delegate
                                      style:UITableViewStylePlain
                                constraints:constraints];
}

+ (instancetype)zj_tableViewWithSuperview:(UIView *)superView
                                  delegate:(id)delegate
                                     style:(UITableViewStyle)style
                               constraints:(ZJConstrainMaker)constraints {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [superView addSubview:tableView];
    
    if (superView && constraints) {
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            constraints(make);
        }];
    }
    
    return tableView;
}


@end
