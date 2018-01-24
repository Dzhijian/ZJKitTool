
//
//  ZJChooseViewController.m
//  ZJUIKit
//
//  Created by dzj on 2017/12/8.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

/**
 *  ZJUIKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJUIKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下。😆
 */


#import "ZJChooseViewController.h"
#import "ZJChooseControlView.h"
#import "ZJChooseShowView.h"
@interface ZJChooseViewController ()<UITableViewDelegate,UITableViewDataSource,ZJChooseControlDelegate>
@property(nonatomic ,strong) UITableView *mainTable;
@property(nonatomic ,weak) ZJChooseControlView *chooseControlView;
@property(nonatomic ,strong) ZJChooseShowView *showView;
@end

@implementation ZJChooseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    // 设置返回按钮
    kWeakObject(self);
    [self zj_setNavLeftImage:kImageName(@"new_goback") block:^(id sender) {
        [weakObject.navigationController popViewControllerAnimated:YES];
    }];
    self.title = @"ChooseView";
    [self setUpAllView];
}




-(void)setUpAllView{
    NSArray *array = @[@"全部商区",@"外语培训",@"智能排序",@"筛选"];
    ZJChooseControlView *chooseView = [[ZJChooseControlView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    chooseView.delegate = self;
    chooseView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    chooseView.layer.borderWidth = 0.5;
    [chooseView setUpAllViewWithTitleArr:array];
    _chooseControlView = chooseView;
    [self.view addSubview:chooseView];
    [self.view addSubview:self.mainTable];
}

-(ZJChooseShowView *)showView{
    if (!_showView) {
        _showView = [[ZJChooseShowView alloc]initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeight - 104)];
        _showView.hidden = YES;
    }
    return _showView;
}

#pragma mark - 选中的按钮事件
-(void)chooseControlWithBtnArray:(NSArray *)array button:(UIButton *)sender{
    
    [self.view addSubview:self.showView];
    self.showView.hidden = NO;
    [self.showView chooseControlViewBtnArray:array Action:sender];
    
}

-(UITableView *)mainTable{
    if (!_mainTable) {
        _mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeight-104) style:UITableViewStylePlain];
        _mainTable.delegate = self;
        _mainTable.dataSource = self;
        _mainTable.rowHeight = 50;
    }
    return _mainTable;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"testCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"测试数据:---->%ld",(long)indexPath.row];
    return cell;
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
