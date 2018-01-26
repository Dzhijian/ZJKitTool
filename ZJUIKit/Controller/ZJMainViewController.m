//
//  ZJMainViewController.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/24.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//
/**
 *  ZJUIKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJUIKitTool
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
@interface ZJMainViewController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic ,strong) UITableView    *mainTable;
@property(nonatomic ,strong) NSArray        *titleArray;

@end

@implementation ZJMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ZJUIKitTool";
    self.titleArray = @[@"快速创建控件+Masonry布局",@"评论列表",@"筛选视图",@"倒计时 Cell",@"MasonryCell(类似朋友圈)"];
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
