
//
//  ZJChooseControlView.m
//  ZJUIKit
//
//  Created by dzj on 2017/12/7.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import "ZJChooseControlView.h"
#import "ZJButton.h"


@interface ZJChooseControlView()

@property(nonatomic ,strong) UIView             *btnBackView;


@end

@implementation ZJChooseControlView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.btnBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        [self addSubview:self.btnBackView];
    }
    return self;
}

-(void)btnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(chooseControlWithBtnArray:button:)]) {
        [self.delegate chooseControlWithBtnArray:self.btnArr button:sender];
    }
}


-(void)setUpAllViewWithTitleArr:(NSArray *)titleArr{
    
    for (int i = 0; i<titleArr.count; i++) {
        ZJButton *btn = [[ZJButton alloc]init];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"downla"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"upla"] forState:UIControlStateSelected];
        btn.imageAlignment = ZJImageAlignmentRight;
        btn.spaceBetweenTitleAndImage = 3;
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        CGFloat btnW = ScreenWidth/4;
        CGFloat btnX = i*btnW;
        btn.frame = CGRectMake(btnX, 0, btnW, 40);
        [self.btnBackView addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.btnArr addObject:btn];
    }
    
}


-(NSMutableArray *)btnArr{
    if (!_btnArr) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}


@end
