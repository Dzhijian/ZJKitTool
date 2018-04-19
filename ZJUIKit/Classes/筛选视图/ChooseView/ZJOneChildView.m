//
//  ZJOneChildView.m
//  ZJUIKit
//
//  Created by dzj on 2017/12/7.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//
/**
 *  ZJUIKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJUIKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下。😆
 */

#import "ZJOneChildView.h"
#import "ZJChooseViewOneLeftCell.h"
#import "ZJChooseOneRightCell.h"

@interface ZJOneChildView ()<UITableViewDelegate,UITableViewDataSource>

// 选中的cell
@property(nonatomic ,assign) NSInteger leftSeleIndex;
@property(nonatomic ,assign) NSInteger rightSeleIndex;

@end

@implementation ZJOneChildView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
        // 默认第一个cell
        self.leftSeleIndex  = 0;
        self.rightSeleIndex = 0;
    }
    return self;
}

-(void)setUpAllView{
    [self addSubview:self.leftTable];
    [self addSubview:self.rightTable];
}

// 设置左边的tableview 数据
-(void)setLeftDataArray:(NSArray *)leftDataArray{

    _leftDataArray = leftDataArray;

    [self.leftTable reloadData];
    [self.rightTable reloadData];

}

// 设置右边的tableview 数据
-(void)setRightDataArray:(NSArray *)rightDataArray{

    _rightDataArray = rightDataArray;
    [self.rightTable reloadData];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTable) {
        return  15;
//        return self.leftDataArray.count;
    }else{
        return 10;
//        return self.rightDataArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTable) {
        ZJChooseViewOneLeftCell *cell = [ZJChooseViewOneLeftCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // 标题
        cell.titleLab.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
        
        if (indexPath.row == self.leftSeleIndex) {
            cell.isSelected = YES;
        }else{
            cell.isSelected = NO;
        }
        
        return cell;
    }else{
        
        ZJChooseOneRightCell *cell = [ZJChooseOneRightCell cellWithTableView:tableView];
        cell.titleLab.text = [NSString stringWithFormat:@"第%ld组%ld行",self.leftSeleIndex,indexPath.row];
        if (indexPath.row == self.rightSeleIndex) {
            cell.isSelected = YES;
            
        }else{
            cell.isSelected = NO;
            
        }
        return cell;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
    
    if (tableView == self.leftTable) {
        
        self.leftSeleIndex = indexPath.row;
        [self.leftTable reloadData];
        self.leftSeleIndex = indexPath.row;
        
        self.rightSeleIndex = 0;
        [self.rightTable reloadData];
        
//        if ([self.delegate respondsToSelector:@selector(oneViewLeftTableviewDidSelectedWithIndex:)]) {
//            [self.delegate oneViewLeftTableviewDidSelectedWithIndex:indexPath.row];
//        }
        
    }else{
        
        self.rightSeleIndex = indexPath.row;
        [self.rightTable reloadData];
        [self.rightTable deselectRowAtIndexPath:indexPath animated:YES];
        if ([self.delegate respondsToSelector:@selector(oneViewRightTableviewDidSelectedWithLeftIndex:rightIndex:)]) {
            [self.delegate oneViewRightTableviewDidSelectedWithLeftIndex:self.leftSeleIndex rightIndex:indexPath.row];
        }
        
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


@end
