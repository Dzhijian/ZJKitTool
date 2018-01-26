//
//  ZJMasonryAutolayoutCellViewController.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/26.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJMasonryAutolayoutCellViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "ZJMasonryAutolayoutCell.h"
#import "ZJCommit.h"

#define kMasonryCell @"kMasonryCell"
@interface ZJMasonryAutolayoutCellViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong) UITableView *mainTable;

@property(nonatomic ,strong) NSMutableArray *dataArray;

@end

@implementation ZJMasonryAutolayoutCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpAllView];
    [self getCommitsData];
}

#pragma mark - 获取数据
- (void)getCommitsData {
    
    // 从CommitsData 文件加载数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MasonryCellData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSArray *commitsList = [rootDict objectForKey:@"comments_list"];
    NSMutableArray *arrM = [NSMutableArray array];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (NSDictionary *dictDict in commitsList) {
            ZJCommit *commit = [ZJCommit commitWithDict:dictDict];
            [arrM addObject:commit];
        }
        self.dataArray = arrM;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.mainTable reloadData];
        });
    });
    
}

-(void)setUpAllView{
    [self zj_setNavTitle:@"Masonry朋友圈"];
    [self zj_setNavLeftImage:@"new_goback" block:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    self.mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTable.tableFooterView = [[UIView alloc]init];
    _mainTable.estimatedRowHeight = 100;
    // 必须先注册cell，否则会报错
    [_mainTable registerClass:[ZJMasonryAutolayoutCell class] forCellReuseIdentifier:kMasonryCell];
    [self.view addSubview:self.mainTable];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZJMasonryAutolayoutCell *cell = [tableView dequeueReusableCellWithIdentifier:kMasonryCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    return [self.mainTable fd_heightForCellWithIdentifier:kMasonryCell cacheByIndexPath:indexPath configuration:^(id cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
    
    
}

#pragma mark - 给cell
- (void)configureCell:(ZJMasonryAutolayoutCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    // 采用计算frame模式还是自动布局模式，默认为NO，自动布局模式
    //    cell.fd_enforceFrameLayout = NO;
    cell.model = self.dataArray[indexPath.row];
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
