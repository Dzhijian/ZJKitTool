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
    self.titleArray = @[@"快速创建控件+Masonry布局",@"评论列表(MVVM)",@"筛选视图",@"倒计时 Cell",
                        @"MasonryCell(类似朋友圈)",@"CollectionView (瀑布流)",@"WKWebView的使用",
                        @"导航栏渐变",@"球形TagView",@"视频列表",@"ZJPickerView",@"ZJNetworking"];
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
    cell.textLabel.text = self.titleArray[indexPath.row];
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
    switch (indexPath.row) {
        case 0:
        {
            ZJKitAndMasonryViewController *kit = [[ZJKitAndMasonryViewController alloc]init];
            [self.navigationController pushViewController:kit animated:YES];
            break;
        }
        case 1:
        {
            ZJCommitViewController *commit = [[ZJCommitViewController alloc]init];
            [self.navigationController pushViewController:commit animated:YES];
            break;
        }case 2:
        {
            ZJChooseViewController *choose = [[ZJChooseViewController alloc]init];
            [self.navigationController pushViewController:choose animated:YES];
            break;
        }case 3:
        {
            ZJTimeCountDownViewController *timedown = [[ZJTimeCountDownViewController alloc]init];
            [self.navigationController pushViewController:timedown animated:YES];
            break;
        }case 4:
        {
            ZJMasonryAutolayoutCellViewController *masonryCell = [[ZJMasonryAutolayoutCellViewController alloc]init];
            [self.navigationController pushViewController:masonryCell animated:YES];
            break;
        }case 5:
        {
            ZJCollectionViewController *collectionView = [[ZJCollectionViewController alloc]init];
            [self.navigationController pushViewController:collectionView animated:YES];
            break;
        }case 6:
        {
            ZJWebViewController *webView = [[ZJWebViewController alloc]init];
            [self.navigationController pushViewController:webView animated:YES];
            break;
        }case 7:
        {
            ZJNavBarShadeViewController *navBar = [[ZJNavBarShadeViewController alloc]init];
            [self.navigationController pushViewController:navBar animated:YES];
            break;
        }
        case 8:
        {
            ZJSphereTagCloudViewController *sphere = [[ZJSphereTagCloudViewController alloc]init];
            [self.navigationController pushViewController:sphere animated:YES];
            break;
        }
        case 9:
        {
            ZJPlayerListViewController *player = [[ZJPlayerListViewController alloc]init];
            [self.navigationController pushViewController:player animated:YES];
            break;
        }case 10:
        {
            ZJPickerViewController *pickerView = [[ZJPickerViewController alloc]init];
            [self.navigationController pushViewController:pickerView animated:YES];
            break;
        }
        case 11:
        {
            ZJNetworkViewController *net = [[ZJNetworkViewController alloc]init];
            [self.navigationController pushViewController:net animated:YES];
            break;
        }
        default:
            break;
    }
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
