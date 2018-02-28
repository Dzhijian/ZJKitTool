//
//  ZJWebViewController.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/31.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//
/**
 *  ZJUIKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJUIKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下,给个Star。😆
 */
#import "ZJWebViewController.h"

@interface ZJWebViewController ()

@property(nonatomic ,strong) UIView *testView;

@end

@implementation ZJWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.configuration.userContentController = [[WKUserContentController alloc] init];
    
    // 获取设备 deviceID 并回显到 H5
//    [self.webView.configuration.userContentController addScriptMessageHandler:self.ocjsHelper name:LMJOCJSHelperScriptMessageHandlerName1_];
    
    [self.webView loadRequest:[NSMutableURLRequest requestWithURL:[[NSBundle mainBundle] URLForResource:NSStringFromClass(self.class) withExtension:@"html"]]];
}


#pragma mark - LMJWebViewControllerDelegate
- (void)webView:(WKWebView *)webView scrollView:(UIScrollView *)scrollView contentSize:(CGSize)contentSize
{
    [super webView:webView scrollView:scrollView contentSize:contentSize];
    
#pragma mark - 添加红色的 View================================================
    // 添加红色的 View
    static CGFloat contentSizeHeight = 0;
    if (contentSizeHeight != contentSize.height) {
        contentSizeHeight = contentSize.height;
        
        self.testView.frame = CGRectMake(0, contentSize.height - self.testView.zj_height, kScreenWidth, self.testView.zj_height);
    }
    //==========================================================================
    
    
}
#pragma mark - webViewDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [super webView:webView didFinishNavigation:navigation];

    // 使用 div
    NSString *js = [NSString stringWithFormat:@"\
                    var appendDiv = document.getElementById(\"AppAppendDIV\");\
                    if (appendDiv) {\
                    appendDiv.style.height = %@+\"px\";\
                    } else {\
                    var appendDiv = document.createElement(\"div\");\
                    appendDiv.setAttribute(\"id\",\"AppAppendDIV\");\
                    appendDiv.style.width=%@+\"px\";\
                    appendDiv.style.height=%@+\"px\";\
                    document.body.appendChild(appendDiv);\
                    }\
                    ", @(self.testView.zj_height), @(kScreenWidth), @(self.testView.zj_height)];
    
    [self.webView evaluateJavaScript:js completionHandler:^(id value, NSError *error) {
        // 执行完上面的那段 JS, webView.scrollView.contentSize.height 的高度已经是加上 div 的高度
        self.testView.frame = CGRectMake(0, self.webView.scrollView.contentSize.height - self.testView.zj_height, kScreenWidth, self.testView.zj_height);
    }];
    
    
}

#pragma mark - UIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    NSLog(@"%@", frame);
    UIAlertController *alert =  [UIAlertController zj_alertControllerWithTitle:@"Alert" message:message optionStyle:OptionStyleStyleOnlyOK OkTitle:@"confirm" cancelTitle:nil okBlock:^{
        completionHandler();
    } cancelBlock:^{
        
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
    NSLog(@"%@", frame);
    
    UIAlertController *alert = [UIAlertController zj_alertControllerWithTitle:@"Alert" message:message optionStyle:OptionStyleStyleOK_Cancel OkTitle:@"confirm" cancelTitle:@"cancel" okBlock:^{
        completionHandler(YES);
    } cancelBlock:^{
        completionHandler(NO);
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入框" message:prompt preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.textColor = [UIColor blackColor];
        textField.placeholder = defaultText;
        
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        completionHandler([[alert.textFields lastObject] text]);
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        completionHandler(nil);
        
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}


-(UIView *)testView{
    if (!_testView) {
        _testView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
        [self.webView.scrollView insertSubview:_testView atIndex:0];
        _testView.backgroundColor = kOrangeColor;
    }
    return _testView;
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
