//
//  ZJBaseWKWebViewController.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/31.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJBaseWKWebViewController.h"
#import "NSObject+YYAddForKVO.h"
#import "UIView+ZJFrame.h"
#import "ZJGeneraMacros.h"
/**
 *  属性转字符串
 */
#define ZJKeyPath(obj, key) @(((void)obj.key, #key))


@interface ZJBaseWKWebViewController ()

@property(nonatomic ,strong) UIProgressView *progressView;
@property(nonatomic ,strong) UIButton       *backBtn;
@property(nonatomic ,strong) UIButton       *colseBtn;
@end

@implementation ZJBaseWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    kWeakObject(self);
    [self.webView addObserverBlockForKeyPath:ZJKeyPath(weakObject.webView, estimatedProgress) block:^(id  _Nonnull obj, id  _Nullable oldVal, id  _Nullable newVal) {
        
        
        weakObject.progressView.progress = weakObject.webView.estimatedProgress;
        // 加载完成
        if (weakObject.webView.estimatedProgress  >= 1.0f ) {
            
            [UIView animateWithDuration:0.25f animations:^{
                weakObject.progressView.alpha = 0.0f;
                weakObject.progressView.progress = 0.0f;
            }];
            
        }else{
            weakObject.progressView.alpha = 1.0f;
        }
        
    }];
    
    
    
    if ([self webViewController:self webViewIsNeedAutoTitle:self.webView]) {
        
        [self.webView addObserverBlockForKeyPath:ZJKeyPath(self.webView, title) block:^(id  _Nonnull obj, id  _Nullable oldVal, id  _Nullable newVal) {
            
            if ([newVal isKindOfClass:[NSString class]]) {
                
                weakObject.title = newVal;
                
            }
            
        }];
    }
    
    
    [self.webView.scrollView addObserverBlockForKeyPath:ZJKeyPath(self.webView.scrollView, contentSize) block:^(id  _Nonnull obj, id  _Nullable oldVal, id  _Nullable newVal) {
        
        [weakObject webView:weakObject.webView scrollView:weakObject.webView.scrollView contentSize:weakObject.webView.scrollView.contentSize];
        
    }];
    
    
    
    if (self.URL.length > 0) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.URL]]];
    }
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.view bringSubviewToFront:self.progressView];
    
}

#pragma mark - LMJWebViewControllerDataSource
// 默认需要, 是否需要进度条
- (BOOL)webViewController:(ZJBaseWKWebViewController *)webViewController webViewIsNeedProgressIndicator:(WKWebView *)webView
{
    return YES;
}

// 默认需要自动改变标题
- (BOOL)webViewController:(ZJBaseWKWebViewController *)webViewController webViewIsNeedAutoTitle:(WKWebView *)webView
{
    return YES;
}

// 监听 self.webView.scrollView 的 contentSize 属性改变，从而对底部添加的自定义 View 进行位置调整
- (void)webView:(WKWebView *)webView scrollView:(UIScrollView *)scrollView contentSize:(CGSize)contentSize
{
    NSLog(@"%@\n%@\n%@", webView, scrollView, NSStringFromCGSize(contentSize));
}

#pragma mark - webDelegate

// 1, 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSLog(@"decidePolicyForNavigationAction   ====    %@", navigationAction);
    decisionHandler(WKNavigationActionPolicyAllow);
    
}

// 2开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
    NSLog(@"didStartProvisionalNavigation   ====    %@", navigation);
    
}


// 4, 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    NSLog(@"decidePolicyForNavigationResponse   ====    %@", navigationResponse);
    decisionHandler(WKNavigationResponsePolicyAllow);
    
}

// 5,内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    
    NSLog(@"didCommitNavigation   ====    %@", navigation);
}

// 6, 加载 HTTPS 的链接，需要权限认证时调用  \  如果 HTTPS 是用的证书在信任列表中这不要此代理方法
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler {
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([challenge previousFailureCount] == 0) {
            
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        } else {
            
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
    } else {
        
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    }
}
// 7,页面加载完调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    
    NSLog(@"didFinishNavigation   ====    %@", navigation);
    
}

// 8,页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
    NSLog(@"didFailProvisionalNavigation   ====    %@\nerror   ====   %@", navigation, error);
    
//    [MBProgressHUD showError:@"网页加载失败" ToView:self.view];
}

- (void)dealloc
{
    NSLog(@"ZJBaseWKWebViewController -- dealloc");
    
    [_webView.scrollView removeObserverBlocks];
    [_webView removeObserverBlocks];
    
    _webView.UIDelegate = nil;
    _webView.navigationDelegate = nil;
    _webView.scrollView.delegate = nil;
}


-(WKWebView *)webView{
    if (!_webView) {
        //初始化一个WKWebViewConfiguration对象
        WKWebViewConfiguration *config = [WKWebViewConfiguration new];
        //初始化偏好设置属性：preferences
        config.preferences = [WKPreferences new];
        //The minimum font size in points default is 0;
        config.preferences.minimumFontSize = 0;
        //是否支持JavaScript
        config.preferences.javaScriptEnabled = YES;
        //不通过用户交互，是否可以打开窗口
        config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
        // 检测各种特殊的字符串：比如电话、网站
        //                config.dataDetectorTypes = UIDataDetectorTypeAll;
        // 播放视频
        config.allowsInlineMediaPlayback = YES;
        
        _webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:config];
        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        //        webView.scrollView.delegate = self;
        
        _webView.opaque = NO;
        _webView.backgroundColor = [UIColor clearColor];
        
        //滑动返回看这里
        _webView.allowsBackForwardNavigationGestures = YES;
        
        [self.view addSubview:self.webView];
        
        if (@available(iOS 11.0, *)){
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _webView.scrollView.scrollIndicatorInsets = _webView.scrollView.contentInset;
    }
    return _webView;
}

- (UIProgressView *)progressView
{
    if(_progressView == nil && [self.parentViewController isKindOfClass:[UINavigationController class]])
    {
        _progressView = [[UIProgressView alloc] init];
        
        _progressView.zj_height = 1;
        
        _progressView.zj_width = kScreenWidth;
        
        _progressView.zj_originY = 0;
        _progressView.tintColor = [UIColor greenColor];
        [self.view addSubview:_progressView];
        
        if ([self respondsToSelector:@selector(webViewController:webViewIsNeedProgressIndicator:)]) {
            
            if (![self webViewController:self webViewIsNeedProgressIndicator:self.webView]) {
                _progressView.hidden = YES;
            }
            
        }
        
    }
    return _progressView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
