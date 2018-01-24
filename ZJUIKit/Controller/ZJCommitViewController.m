//
//  ZJCommitViewController.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/23.
//  Copyright © 2018年 kapokcloud. All rights reserved.

/**
 *  ZJUIKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJUIKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下。😆
 */
#import "ZJCommitViewController.h"
#import "ZJCommitFrame.h"
#import "ZJCommitCell.h"
#import "ZJCommit.h"
#import "MJRefresh.h"
#import "ZJImgLeftBtn.h"
@interface ZJCommitViewController ()<UITableViewDelegate,UITableViewDataSource,ZJCommitCellDelegate>

@property(nonatomic ,strong) UITableView        *mainTable;
// 数据源
@property(nonatomic ,strong) NSMutableArray     *dataArray;
// 索引
@property(nonatomic ,assign) NSInteger          pageNum;

@end

@implementation ZJCommitViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    self.title = @"评论列表";
    self.pageNum = 1;
    [self setUpAllView];
    [self getCommitsData];
    
}

-(void)setUpAllView{

    // 返回按钮
    [self zj_setNavLeftImage:kImageName(@"new_goback") block:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];


    _mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    _mainTable.backgroundColor = kWhiteColor;
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTable];
    
//    kWeakObject(self);
//    self.mainTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        weakObject.pageNum = 1;
//        [weakObject getCommitsData];
//    }];
//
//    self.mainTable.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
//        weakObject.pageNum += 1;
//        [weakObject getCommitsData];
//    }];
}

#pragma mark - 获取数据
- (void)getCommitsData {
    [self.mainTable.mj_header endRefreshing];
    [self.mainTable.mj_footer endRefreshing];
    
    // 从CommitsData 文件加载数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CommitsData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSArray *commitsList = [rootDict objectForKey:@"comments_list"];
    NSMutableArray *arrM = [NSMutableArray array];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (NSDictionary *dictDict in commitsList) {
            ZJCommitFrame *cFrame = [[ZJCommitFrame alloc]init];
            cFrame.commit = [ZJCommit commitWithDict:dictDict];
            [arrM addObject:cFrame];
        }
        self.dataArray = arrM;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mainTable reloadData];
        });
    });
    
}




#pragma mark - ZJCommitCellDelegate
// 点赞
- (void)likeBtnClickAction:(ZJImgLeftBtn *)sender{
    sender.selected = !sender.isSelected;
    if (sender.isSelected) {
        [sender setImage:kImageName(@"new_organize_like") forState:UIControlStateNormal];
    }else{
        [sender setImage:kImageName(@"new_organize_dislike") forState:UIControlStateNormal];
    }
}
// 差评
- (void)disLikeBtnClickAction:(ZJImgLeftBtn *)sender{
    sender.selected = !sender.isSelected;
    if (sender.isSelected) {
        [sender setImage:kImageName(@"new_unlike_sele") forState:UIControlStateNormal];
    }else{
        [sender setImage:kImageName(@"new_unlike_unsele") forState:UIControlStateNormal];
    }
}
// 删除评论
-(void)deleteBtnClickAction:(UIButton *)sender{
    NSLog(@"删除");
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZJCommitCell *cell = [ZJCommitCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selfVc = self;
    ZJCommitFrame *cFrame = self.dataArray[indexPath.row];
    cell.commitFrame = cFrame;
    [cell setChildBtnTag:indexPath.row];
    cell.delegate = self;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZJCommitFrame *cFrame = self.dataArray[indexPath.row];
    return cFrame.cellHeight;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
