//
//  ZJChainViewController.m
//  ZJKitTool
//
//  Created by 邓志坚 on 2020/3/16.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJChainViewController.h"


@interface ZJChainViewController ()

@end

@implementation ZJChainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(80, 100, 100, 80)];
    [self.view addSubview:view];
    view.backgroundColor = kLightGrayColor;
    
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
