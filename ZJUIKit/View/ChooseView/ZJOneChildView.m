//
//  ZJOneChildView.m
//  ZJUIKit
//
//  Created by dzj on 2017/12/7.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import "ZJOneChildView.h"
#import "ZJChooseViewOneLeftCell.h"
#import "ZJChooseOneRightCell.h"


@interface ZJOneChildView ()<UITableViewDelegate,UITableViewDataSource>

// 选中的cell
@property(nonatomic ,assign) NSInteger leftSeleIndex;

@end

@implementation ZJOneChildView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
        // 默认第一个cell
        self.leftSeleIndex  = 0;
    }
    return self;
}

-(void)setUpAllView{
    [self addSubview:self.leftTable];
    [self addSubview:self.rightTable];
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTable) {
        ZJChooseViewOneLeftCell *cell = [ZJChooseViewOneLeftCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLab.text = [NSString stringWithFormat:@"leftView第%ld行",indexPath.row];
        if (indexPath.row == self.leftSeleIndex) {
            cell.isSelected = YES;
            
        }else{
            cell.isSelected = NO;
            
        }
        return cell;
    }else{
        ZJChooseOneRightCell *cell = [ZJChooseOneRightCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLab.text = [NSString stringWithFormat:@"rightView"];
        cell.detailLab.text = [NSString stringWithFormat:@"(%ld)",indexPath.row];

        return cell;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
    
    if (tableView == self.leftTable) {
        [self.leftTable deselectRowAtIndexPath:indexPath animated:YES];
        self.leftSeleIndex = indexPath.row;
        [self.leftTable reloadData];
    }else{
        
        
    }
    
    
    
}


-(UITableView *)leftTable{
    if (!_leftTable) {
        _leftTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/2 - 15, 0) style:UITableViewStylePlain];
        _leftTable.delegate = self;
        _leftTable.dataSource = self;
        _leftTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTable.showsVerticalScrollIndicator = NO;
    }
    return _leftTable;
}
-(UITableView *)rightTable{
    if (!_rightTable) {
        _rightTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/2+15, 0) style:UITableViewStylePlain];
        _rightTable.delegate = self;
        _rightTable.dataSource = self;
        _rightTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rightTable.showsVerticalScrollIndicator = NO;
    }
    return _rightTable;
}


@end
