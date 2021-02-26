
//
//  ZJTimeCountDownViewController.m
//  ZJUIKit
//
//  Created by dzj on 2021/1/25.
//  Copyright © 2021年 kapokcloud. All rights reserved.
//

/**
 *  ZJKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下。😆
 */

#import "ZJTimeCountDownViewController.h"
#import "ZJTimeCountDownCell.h"

@interface ZJTimeCountDownViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong) UITableView *mainTable;

@property(nonatomic ,strong) ZJTimeCountDown *timeDown;

@property(nonatomic ,strong) NSArray *endTimeArray;

@end

@implementation ZJTimeCountDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.endTimeArray = @[@"2025-12-12 19:12:32",@"2024-11-26 05:05:30",@"2023-11-06 08:16:40",@"2022-10-25 18:16:08",@"2022-10-07 18:18:19",@"2022-9-19 05:36:56",@"2022-09-18 19:14:43",@"2021-08-17 14:17:33",@"2021-08-04 14:18:18",@"2021-07-14 20:22:19",@"2021-07-12 14:12:40",@"2021-06-12 12:12:30",@"2021-06-11 16:15:18",@"2021-06-09 08:14:18",@"2021-06-06 17:39:15",@"2021-06-01 16:22:56",@"2021-05-25 14:42:12",@"2021-05-22 11:12:16",@"2021-05-20 10:12:12",@"2021-05-19 12:16:12",@"2021-05-18 20:12:18",@"2021-05-17 16:12:14",@"2021-05-16 19:12:50",@"2021-05-15 13:12:20",@"2021-05-14 12:32:17",@"2021-05-13 13:32:12",@"2021-05-12 17:12:36",@"2021-04-11 15:19:28",@"2021-04-10 23:12:14",@"2024-02-09 12:12:46",@"2021-04-07 12:12:12",@"2021-04-05 12:18:12",@"2021-04-04 12:32:12",@"2021-04-02 19:42:43",@"2021-04-01 06:36:18",@"2021-03-28 18:12:19",@"2021-03-27 15:12:15",@"2021-03-26 21:12:12",@"2021-03-25 04:12:12",@"2021-03-23 12:12:16",@"2021-02-22 12:42:12",@"2021-02-20 23:12:18",@"2021-02-19 16:12:15",@"2021-01-18 17:12:36",@"2021-01-17 18:12:13",@"2021-01-15 20:12:12",@"2021-01-10 14:12:10",@"2021-01-09 02:12:12",@"2020-12-12 11:52:12",@"2020-12-10 18:12:12"];
    [self setUpAllView];
}

-(void)setUpAllView{
    kWeakObject(self);
    [self zj_setNavTitle:@"倒计时 ZJTimeCountDown"];
    [self zj_setNavLeftImage:@"new_goback" block:^(id sender) {
        [weakObject.navigationController popViewControllerAnimated:YES];
    }];
    
    _mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    _mainTable.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.mainTable];
    
    // 初始化倒计时
    self.timeDown = [ZJTimeCountDown ShareManager];
    
    // 倒计时,每秒执行一次
    [_timeDown zj_timeCountDownWithPER_SECBlock:^{
        [weakObject updateTimeInVisibleCells];
    }];
    
}

#pragma mark - 更新当前屏幕显示cell的倒计时
-(void)updateTimeInVisibleCells{
    NSArray  *cells = self.mainTable.visibleCells; //取出屏幕可见ceLl
    for (ZJTimeCountDownCell *cell in cells) {
        cell.detailLab.text =[NSString stringWithFormat:@"还剩%@开始",[_timeDown zj_timeGetNowTimeWithString:self.endTimeArray[cell.tag]]];
        if ([[_timeDown zj_timeGetNowTimeWithString:self.endTimeArray[cell.tag]] isEqualToString:@"倒计时已经结束！"]) {
            cell.detailLab.text = [_timeDown zj_timeGetNowTimeWithString:self.endTimeArray[cell.tag]];
            cell.detailLab.textColor = kPurpleColor;
        }else{
            
            cell.detailLab.textColor = kOrangeColor;
        }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZJTimeCountDownCell *cell = [ZJTimeCountDownCell cellWithTableView:tableView];
    cell.tag = indexPath.row;
    cell.titleLab.text = [NSString stringWithFormat:@"抢购开始时间为:%@",self.endTimeArray[indexPath.row]];
    cell.detailLab.text =[NSString stringWithFormat:@"还剩%@开始",[_timeDown zj_timeGetNowTimeWithString:self.endTimeArray[cell.tag]]];
    
    if ([[_timeDown zj_timeGetNowTimeWithString:self.endTimeArray[cell.tag]] isEqualToString:@"倒计时已经结束！"]) {
        cell.detailLab.text = [_timeDown zj_timeGetNowTimeWithString:self.endTimeArray[indexPath.row]];
        cell.detailLab.textColor = kPurpleColor;
    }else{
        cell.detailLab.textColor = kOrangeColor;
    }

    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(void)dealloc{
   [_timeDown zj_timeDestoryTimer];
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
