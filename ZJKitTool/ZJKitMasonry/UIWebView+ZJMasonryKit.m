//
//  UIWebview+ZJMasonryKit.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/17.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "UIWebView+ZJMasonryKit.h"

@implementation UIWebView (ZJMasonryKit)

+ (instancetype)zj_webViewWithDelegate:(id)delegate {
    return [self zj_webViewWithDelegate:delegate superView:nil];
}

+ (instancetype)zj_webViewWithDelegate:(id)delegate superView:(UIView *)superView {
    return [self zj_webViewWithDelegate:delegate superView:superView edges:UIEdgeInsetsZero];
}

+ (instancetype)zj_webViewWithDelegate:(id)delegate superView:(UIView *)superView edges:(UIEdgeInsets)edges {
    return [self zj_webViewWithDelegate:delegate superView:superView constraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(superView).insets(edges);
    }];
}

+ (instancetype)zj_webViewWithDelegate:(id)delegate
                              superView:(UIView *)superView
                            constraints:(ZJConstrainMaker)constraints {
    UIWebView *webView = [[UIWebView alloc] init];
    
    // 自适应屏幕大小进行缩放
    webView.userInteractionEnabled = YES;
    webView.delegate = delegate;
    webView.scalesPageToFit = YES;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    [superView addSubview:webView];
    
    if (superView) {
        if (constraints) {
            [webView mas_makeConstraints:^(MASConstraintMaker *make) {
                constraints(make);
            }];
        } else {
            [webView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(superView);
            }];
        }
    }
    
    return webView;
}
@end
