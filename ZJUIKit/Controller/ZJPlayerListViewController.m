//
//  ZJPlayerListViewController.m
//  ZJUIKit
//
//  Created by dzj on 2018/2/27.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//
/**
 *  ZJUIKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJUIKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下,给个Star。😆
 */
#import "ZJPlayerListViewController.h"
#import "ZJPlayerListCell.h"
#import "ZJVideoModel.h"
#import "ZJVideoResolution.h"
#import "ZFPlayer.h"
#import <ZFDownload/ZFDownloadManager.h>
@interface ZJPlayerListViewController ()<UITableViewDelegate,UITableViewDataSource,ZFPlayerDelegate>

@property(nonatomic ,strong) UITableView            *mainTable;

@property(nonatomic ,strong) NSMutableArray         *dataArray;

@property(nonatomic ,strong) ZFPlayerView           *playerView;

@property(nonatomic ,strong) ZFPlayerControlView    *controlView;

@end

@implementation ZJPlayerListViewController

// 页面消失时候
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.playerView resetPlayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self zj_setNavTitle:@"视频列表"];
    [self.view addSubview:self.mainTable];
    // 加载数据
    [self loadListData];
}


-(void)loadListData{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"videoData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *videoList =[rootDict objectForKey:@"videoList"];
    for (NSDictionary *dataDic in videoList) {
        ZJVideoModel *model = [[ZJVideoModel alloc]init];
        [model setValuesForKeysWithDictionary:dataDic];
        [self.dataArray addObject:model];
    }
    
    [self.mainTable reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ZJPlayerListCell *cell = [ZJPlayerListCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellStyleDefault;
    ZJVideoModel *model  = self.dataArray[indexPath.row];
    cell.model = model;
    
    __block NSIndexPath *weakIndexPath = indexPath;
    __block ZJPlayerListCell *weakCell     = cell;
    __weak typeof(self)  weakSelf      = self;
    // 点击播放的回调
    cell.playBtnBlock = ^(UIButton *btn){
        
        // 分辨率字典（key:分辨率名称，value：分辨率url)
        NSMutableDictionary *dic = @{}.mutableCopy;
        for (ZJVideoResolution * resolution in model.playInfo) {
            [dic setValue:resolution.url forKey:resolution.name];
        }
        // 取出字典中的第一视频URL
        NSURL *videoURL = [NSURL URLWithString:dic.allValues.firstObject];
        
        ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
        playerModel.title            = model.title;
        playerModel.videoURL         = videoURL;
        playerModel.placeholderImageURLString = model.coverForFeed;
        playerModel.scrollView       = weakSelf.mainTable;
        playerModel.indexPath        = weakIndexPath;
        // 赋值分辨率字典
        playerModel.resolutionDic    = dic;
        // player的父视图tag
        playerModel.fatherViewTag    = weakCell.picImageV.tag;
        
        // 设置播放控制层和model
        [weakSelf.playerView playerControlView:nil playerModel:playerModel];
        // 下载功能
        weakSelf.playerView.hasDownload = YES;
        // 自动播放
        [weakSelf.playerView autoPlayTheVideo];
    };
    
    return cell;
}



-(UIStatusBarStyle)preferredStatusBarStyle{
    // 这里设置横竖屏不同颜色的statusbar
    if (ZFPlayerShared.isLandscape) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return ZFPlayerShared.isStatusBarHidden;
}

-(ZFPlayerView *)playerView{
    if (!_playerView) {
        _playerView = [ZFPlayerView sharedPlayerView];
        _playerView.delegate = self;
        // 当cell 播放视频由全屏变为小屏的时候，不回到中间的位置
        _playerView.cellPlayerOnCenter = NO;
        _playerView.forcePortrait = NO;
        ZFPlayerShared.isLockScreen = YES;
        ZFPlayerShared.isStatusBarHidden = NO;
        
    }
    return _playerView;
}

-(ZFPlayerControlView *)controlView{
    if (!_controlView) {
        _controlView = [[ZFPlayerControlView alloc]init];
    }
    return _controlView;
}


- (void)zf_playerDownload:(NSString *)url {
    // 此处是截取的下载地址，可以自己根据服务器的视频名称来赋值
    NSString *name = [url lastPathComponent];
    [[ZFDownloadManager sharedDownloadManager] downFileUrl:url filename:name fileimage:nil];
    // 设置最多同时下载个数（默认是3）
    [ZFDownloadManager sharedDownloadManager].maxCount = 4;
}


-(UITableView *)mainTable{
    if (!_mainTable) {
        _mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _mainTable.delegate = self;
        _mainTable.dataSource = self;
        _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTable.tableFooterView = [[UIView alloc]init];
        _mainTable.rowHeight = kScreenWidth*9/16 + 98;
    }
    return _mainTable;
}

-(NSMutableArray *)dataArray{
    if(!_dataArray){
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
