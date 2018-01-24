//
//  ZJTwoChildView.m
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

#import "ZJTwoChildView.h"
#import "ZJChooseViewOneLeftCell.h"

@interface ZJTwoChildView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZJTwoChildView



-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
    }
    return self;
}

-(void)setUpAllView{
    [self addSubview:self.leftTable];
    [self addSubview:self.rightTable];
}

-(void)setDataArray:(NSMutableArray *)dataArray{
    
    _dataArray = dataArray;
    
    

    [self.leftTable reloadData];

    
    [self.rightTable reloadData];
    [self.leftTable reloadData];
    if (_leftSeleIndex>5) {
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:_leftSeleIndex-3 inSection:0];
        [self.leftTable scrollToRowAtIndexPath:scrollIndexPath
                              atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }
    if (_rightSeleIndex>5) {
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:_rightSeleIndex-3 inSection:0];
        [self.rightTable scrollToRowAtIndexPath:scrollIndexPath
                              atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }
}




-(UITableView *)leftTable{
    if (!_leftTable) {
        _leftTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/2 - 15, 0) style:UITableViewStylePlain];
        _leftTable.delegate = self;
        _leftTable.dataSource = self;
        _leftTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTable.showsVerticalScrollIndicator = NO;
    }
    return _leftTable;
}
-(UITableView *)rightTable{
    if (!_rightTable) {
        _rightTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/2+15, 0) style:UITableViewStylePlain];
        _rightTable.delegate = self;
        _rightTable.dataSource = self;
        _rightTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rightTable.showsVerticalScrollIndicator = NO;
    }
    return _rightTable;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.leftTable) {
        return 10;
//        return self.dataArray.count;
    }else{
        return 10;
//        return self.rightDataArrray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.leftTable) {
        ZJChooseViewOneLeftCell *cell = [ZJChooseViewOneLeftCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleLab.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
        
        if (indexPath.row == self.leftSeleIndex) {
            cell.threeIsSelected = YES;
        }else{
            cell.threeIsSelected = NO;
        }
        
        cell.titleLab.font = kFontWithSize(14);
        
        return cell;
    }else{
        ZJChooseViewOneLeftCell *cell = [ZJChooseViewOneLeftCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLab.text = [NSString stringWithFormat:@"第%ld组%ld行",self.leftSeleIndex,indexPath.row];
        if (indexPath.row == self.rightSeleIndex) {
            cell.threeIsSelected = YES;
        }else{
            cell.threeIsSelected = NO;
        }
        return cell;
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
    if (tableView == self.leftTable) {
        
        self.leftSeleIndex = indexPath.row;
        [self.leftTable reloadData];
        self.rightSeleIndex = 0;
        
        [self.leftTable reloadData];
        [self.rightTable reloadData];
        
        
    }else{
        self.rightSeleIndex = indexPath.row;
        [self.rightTable reloadData];

        
        if ([self.delegate respondsToSelector:@selector(twoViewRightTableDidSelectedWithLeftIndex:rightIndex:mcid:)]) {
            [self.delegate twoViewRightTableDidSelectedWithLeftIndex:self.leftSeleIndex rightIndex:indexPath.row mcid:@""];
        }
    }
    
}

-(NSMutableArray *)rightDataArrray{
    if (!_rightDataArrray) {
        _rightDataArrray = [NSMutableArray array];
    }
    return _rightDataArrray;
}


@end
