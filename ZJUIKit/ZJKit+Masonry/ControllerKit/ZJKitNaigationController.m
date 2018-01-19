//
//  ZJKitNaigationController.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJKitNaigationController.h"

@interface ZJKitNaigationController ()

@end

@implementation ZJKitNaigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UINavigationBar appearance] setTranslucent:NO];
}


+(void)initialize{
    // 获取当前类下面的 UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    // 设置导航条按钮的文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        /* 自动显示和隐藏 tabbar*/
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationController.navigationBar.hidden = NO;
    }
    [super pushViewController:viewController animated:animated];
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
