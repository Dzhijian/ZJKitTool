//
//  ZJTwoChildView.m
//  ZJUIKit
//
//  Created by dzj on 2017/12/8.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import "ZJTwoChildView.h"

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



-(UITableView *)leftTable{
    if (!_leftTable) {
        _leftTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/2, 0) style:UITableViewStylePlain];
        _leftTable.delegate = self;
        _leftTable.dataSource = self;
        _leftTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTable.showsVerticalScrollIndicator = NO;
    }
    return _leftTable;
}
-(UITableView *)rightTable{
    if (!_rightTable) {
        _rightTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/2, 0) style:UITableViewStylePlain];
        _rightTable.delegate = self;
        _rightTable.dataSource = self;
        _rightTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rightTable.showsVerticalScrollIndicator = NO;
    }
    return _rightTable;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"childCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"twoView第%ld行",indexPath.row];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
}


@end
