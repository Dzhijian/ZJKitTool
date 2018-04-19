
//
//  ZJTimeCountDownViewController.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/25.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

/**
 *  ZJUIKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJUIKitTool
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
    self.endTimeArray = @[@"2018-04-01 19:12:32",@"2018-03-29 05:05:30",@"2018-03-27 08:16:40",@"2018-03-26 18:16:08",@"2018-03-24 18:18:19",@"2018-03-19 05:36:56",@"2018-03-18 19:14:43",@"2018-03-17 14:17:33",@"2018-03-15 14:18:18",@"2018-03-14 20:22:19",@"2018-03-12 14:12:40",@"2018-03-12 12:12:30",@"2018-03-11 16:15:18",@"2018-03-09 08:14:18",@"2018-03-06 17:39:15",@"2018-03-01 16:22:56",@"2018-02-25 14:42:12",@"2018-02-22 11:12:16",@"2018-02-20 10:12:12",@"2018-02-19 12:16:12",@"2018-02-18 20:12:18",@"2018-02-17 16:12:14",@"2018-02-16 19:12:50",@"2018-02-15 13:12:20",@"2018-02-14 12:32:17",@"2018-02-13 13:32:12",@"2018-02-12 17:12:36",@"2018-02-11 15:19:28",@"2018-02-10 23:12:14",@"2018-02-09 12:12:46",@"2018-02-07 12:12:12",@"2018-02-05 12:18:12",@"2018-02-04 12:32:12",@"2018-02-02 19:42:43",@"2018-02-01 06:36:18",@"2018-01-28 18:12:19",@"2018-01-27 15:12:15",@"2018-01-26 21:12:12",@"2018-01-25 04:12:12",@"2018-01-23 12:12:16",@"2018-01-22 12:42:12",@"2018-01-20 23:12:18",@"2018-01-19 16:12:15",@"2018-01-18 17:12:36",@"2018-01-17 18:12:13",@"2018-01-15 20:12:12",@"2018-01-10 14:12:10",@"2018-01-09 02:12:12",@"2017-12-12 11:52:12",@"2017-12-10 18:12:12"];
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
