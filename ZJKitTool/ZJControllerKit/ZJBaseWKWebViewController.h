//
//  ZJBaseWKWebViewController.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/31.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJKitBaseController.h"
#import <WebKit/WebKit.h>

@class ZJBaseWKWebViewController;
@protocol ZJWebViewControllerDelegate <NSObject>

@optional
// 左上边的返回按钮点击
- (void)backBtnClick:(UIButton *)backBtn webView:(WKWebView *)webView ;

//左上边的关闭按钮的点击
- (void)closeBtnClick:(UIButton *)closeBtn webView:(WKWebView *)webView;

// 监听 self.webView.scrollView 的 contentSize 属性改变，从而对底部添加的自定义 View 进行位置调整
- (void)webView:(WKWebView *)webView scrollView:(UIScrollView *)scrollView contentSize:(CGSize)contentSize;

@end


@protocol ZJWebViewControllerDataSource <NSObject>

@optional
// 默认需要, 是否需要进度条
- (BOOL)webViewController:(ZJBaseWKWebViewController *)webViewController webViewIsNeedProgressIndicator:(WKWebView *)webView;

// 默认需要自动改变标题
- (BOOL)webViewController:(ZJBaseWKWebViewController *)webViewController webViewIsNeedAutoTitle:(WKWebView *)webView;

@end

@interface ZJBaseWKWebViewController : ZJKitBaseController<WKNavigationDelegate, WKUIDelegate, ZJWebViewControllerDelegate, ZJWebViewControllerDataSource>

@property(nonatomic ,strong) WKWebView  *webView;

@property(nonatomic ,copy) NSString     *URL;

// 页面加载完调用, 必须调用super
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation NS_REQUIRES_SUPER;


// 页面加载失败时调用, 必须调用super
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error NS_REQUIRES_SUPER;

@end
