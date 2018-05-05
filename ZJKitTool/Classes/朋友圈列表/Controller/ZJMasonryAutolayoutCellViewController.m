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

/**
 *  ZJUIKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJUIKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下。😆
 *
 *  这个案例是利用 Masonry + UITableView+FDTemplateLayoutCell 写的类似朋友圈的自适应布局，功能有待完善与添加，希望能帮助到你
 *  核心部分是 UITableView+FDTemplateLayoutCell
 */
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
    cell.weakSelf = self;
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    // 计算缓存cell的高度
    return [self.mainTable fd_heightForCellWithIdentifier:kMasonryCell cacheByIndexPath:indexPath configuration:^(ZJMasonryAutolayoutCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
    
    
}

#pragma mark - 给cell赋值
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
