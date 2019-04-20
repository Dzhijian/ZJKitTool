//
//  ZJMainViewController.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/24.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//
/**
 *  ZJKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下。😆
 */


#import "ZJMainViewController.h"

#import "ZJChooseViewController.h"
#import "ZJUIMasonsyKit.h"
#import "ZJKitNaigationController.h"
#import "ZJCommitViewController.h"
#import "ZJCommitFrame.h"
#import "ZJCommit.h"
#import "ZJBaseTableViewCell.h"
#import "ZJKitAndMasonryViewController.h"
#import "ZJTimeCountDownViewController.h"
#import "ZJMasonryAutolayoutCellViewController.h"
#import "ZJCollectionViewController.h"
#import "ZJWebViewController.h"
#import "ZJNavBarShadeViewController.h"
#import "ZJSphereTagCloudViewController.h"
#import "ZJPlayerListViewController.h"
#import "ZJPickerViewController.h"
#import "ZJNetworkViewController.h"
#import "ZJImageCompressViewController.h"
#import "ZJPopupViewController.h"

@interface ZJMainViewController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic ,strong) UITableView    *mainTable;
@property(nonatomic ,strong) NSArray        *titleArray;

@end

@implementation ZJMainViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ZJKitTool";
    self.titleArray = @[@{@"title":@"快速创建控件+Masonry布局",@"className":@"ZJKitAndMasonryViewController"},
                        @{@"title":@"评论列表(MVVM)",@"className":@"ZJCommitViewController"},
                        @{@"title":@"筛选视图",@"className":@"ZJChooseViewController"},
                        @{@"title":@"倒计时 Cell",@"className":@"ZJTimeCountDownViewController"},
                        @{@"title":@"MasonryCell(类似朋友圈)",@"className":@"ZJMasonryAutolayoutCellViewController"},
                        @{@"title":@"CollectionView (瀑布流)",@"className":@"ZJCollectionViewController"},
                        @{@"title":@"WKWebView的使用",@"className":@"ZJWebViewController"},
                        @{@"title":@"导航栏渐变",@"className":@"ZJNavBarShadeViewController"},
                        @{@"title":@"球形TagView",@"className":@"ZJSphereTagCloudViewController"},
                        @{@"title":@"视频列表",@"className":@"ZJPlayerListViewController"},
                        @{@"title":@"ZJPickerView",@"className":@"ZJPickerViewController"},
                        @{@"title":@"ZJNetworking",@"className":@"ZJNetworkViewController"},
                        @{@"title":@"图片压缩",@"className":@"ZJImageCompressViewController"},
                        @{@"title":@"ZJPopupView",@"className":@"ZJPopupViewController"}];
    [self setUpAllView];

}


-(void)setUpAllView{
    _mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    _mainTable.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.mainTable];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZJBaseTableViewCell *cell = [ZJBaseTableViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.titleArray[indexPath.row][@"title"];
    cell.textLabel.backgroundColor = kWhiteColor;
    cell.textLabel.layer.masksToBounds = YES;
    cell.backgroundColor = kWhiteColor;
    cell.layer.masksToBounds = YES;
    cell.contentView.backgroundColor = kWhiteColor;
    cell.contentView.layer.masksToBounds = YES;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.titleArray[indexPath.row];
    UIViewController *vc = NSClassFromString(dict[@"className"]).new;
    [self.navigationController pushViewController:vc animated:YES];

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
