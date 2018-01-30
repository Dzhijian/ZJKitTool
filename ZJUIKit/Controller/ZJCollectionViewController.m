//
//  ZJCollectionViewController.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/30.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJCollectionViewController.h"
#import "ZJBaseTableViewCell.h"
#import "ZJElementsCollectionViewController.h"
#import "ZJVerticalWaterFallViewController.h"
#import "ZJHorizontalWaterFallViewController.h"
/**
 *  ZJUIKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJUIKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下,给个Star。😆
 */
@interface ZJCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong) UITableView *mainTable;
@property(nonatomic ,strong) NSArray *dataArray;
@end

@implementation ZJCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CollectionView";
    [self.view addSubview:self.mainTable];
    
    self.dataArray = @[@"普通布局",@"垂直瀑布流",@"横向瀑布流"];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZJBaseTableViewCell *cell = [ZJBaseTableViewCell cellWithTableView:tableView];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            ZJElementsCollectionViewController *element = [[ZJElementsCollectionViewController alloc]init];
            [self.navigationController pushViewController:element animated:YES];
        }
            break;
        case 1:
        {
            ZJVerticalWaterFallViewController *vertical = [[ZJVerticalWaterFallViewController alloc]init];
            [self.navigationController pushViewController:vertical animated:YES];
        }
            break;
        case 2:
        {
            ZJHorizontalWaterFallViewController *horizontal = [[ZJHorizontalWaterFallViewController alloc]init];
            [self.navigationController pushViewController:horizontal animated:YES];
        }
            break;
            
        default:
            break;
    }
}

-(UITableView *)mainTable{
    if (!_mainTable) {
        _mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _mainTable.delegate = self;
        _mainTable.rowHeight = 50;
        _mainTable.dataSource = self;
        _mainTable.tableFooterView = [[UIView alloc]init];
    }
    return _mainTable;
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
