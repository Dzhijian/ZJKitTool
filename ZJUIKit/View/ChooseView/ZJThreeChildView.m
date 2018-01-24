//
//  ZJThreeChildView.m
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

#import "ZJThreeChildView.h"
#import "ZJChooseViewOneLeftCell.h"
@interface ZJThreeChildView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,assign) NSInteger seleIndex;

@end

@implementation ZJThreeChildView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.seleIndex = 0;
        [self setUpAllView];
    }
    return self;
}

-(void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    [self.mainTable reloadData];
}

-(void)setUpAllView{
    
    self.mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0) style:UITableViewStylePlain];
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTable.rowHeight = 45;
    [self addSubview:self.mainTable];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZJChooseViewOneLeftCell *cell = [ZJChooseViewOneLeftCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLab.text = self.titleArray[indexPath.row];
    if (indexPath.row == self.seleIndex) {
        cell.threeIsSelected = YES;
    }else{
        cell.threeIsSelected = NO;
        cell.arrowImgV.hidden = YES;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.seleIndex = indexPath.row;
    [self.mainTable reloadData];
    if ([self.delegate respondsToSelector:@selector(threeViewTableviewDidSelectedWithIndex:)]) {
        [self.delegate threeViewTableviewDidSelectedWithIndex:indexPath.row];
    }
}

@end
