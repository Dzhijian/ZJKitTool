//
//  ZJSphereTagCloudViewController.m
//  ZJUIKit
//
//  Created by dzj on 2018/2/1.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//
/**
 *  ZJUIKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJUIKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下,给个Star。😆
 */
#import "ZJSphereTagCloudViewController.h"

#import "DBSphereView.h"

@interface ZJSphereTagCloudViewController ()

@property(nonatomic ,strong) DBSphereView *sphereView;

@end

@implementation ZJSphereTagCloudViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"球形TagView";
    [self setUpAllView];
    [self loadData];
}


-(void)loadData{
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i = 0; i<50; i++) {
        UIButton *btn = [UIButton zj_buttonWithFrame:CGRectMake(0, 0, 60, 20) title:[NSString stringWithFormat:@"%d",i] titleColor:kBlackColor imageName:nil backColor:nil fontSize:24 cornerRadius:0 traget:self action:@selector(btnAction:)];
        [dataArray addObject:btn];
        [self.sphereView addSubview:btn];
    }
    [self.sphereView setCloudTags:dataArray];
}

-(void)btnAction:(UIButton *)sender{
    [self.sphereView timerStop];
    
    [UIView animateWithDuration:0.3 animations:^{
        sender.transform = CGAffineTransformMakeScale(2., 2.);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            sender.transform = CGAffineTransformMakeScale(1., 1.);
        } completion:^(BOOL finished) {
            [self.sphereView timerStart];
        }];
    }];
}

-(void)setUpAllView{

    [self.view addSubview:self.sphereView];
    [self.sphereView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kScreenWidth);
    }];
    
    
}


-(DBSphereView *)sphereView{
    if (!_sphereView) {
        _sphereView = [[DBSphereView alloc]init];
        _sphereView.backgroundColor = kLightGrayColor;
    }
    return _sphereView;
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
