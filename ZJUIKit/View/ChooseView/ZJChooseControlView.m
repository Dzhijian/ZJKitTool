
//
//  ZJChooseControlView.m
//  ZJUIKit
//
//  Created by dzj on 2017/12/7.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import "ZJChooseControlView.h"
#import "ZJChooseModel.h"
#import "ZJButton.h"
#import "ZJChooseModel.h"

@interface ZJChooseControlView()

@property(nonatomic ,strong) UIView             *btnBackView;


@end

@implementation ZJChooseControlView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.btnBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
        [self addSubview:self.btnBackView];
        UIView *line = [UIView zj_viewWithBackColor:kLightGrayColor supView:self.btnBackView constraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        [self.btnBackView addSubview:line];
                
        
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
        [btn setTitleColor:kLightGrayColor forState:UIControlStateNormal];
        [btn setTitleColor:k16RGBColor(0xFF960C) forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:@"downla"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"upla"] forState:UIControlStateSelected];
        btn.imageAlignment = ZJImageAlignmentRight;
        btn.spaceBetweenTitleAndImage = 3;
        btn.tag = i;
        btn.titleLabel.font = kFontWithSize(13);
        CGFloat btnW = kScreenWidth/4;
        CGFloat btnX = i*btnW;
        btn.frame = CGRectMake(btnX, 0, btnW, 45);
        [self.btnBackView addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.btnArr addObject:btn];
    }
    
    CGFloat margin = kScreenWidth/4;
    for (int i = 0; i<3; i++) {
        UIView *line = [[UIView alloc]init];
        
        line.backgroundColor = k16RGBColor(0xDDDDDD);
        
        CGFloat w = 0.5;
        CGFloat h = 23;
        CGFloat x = (margin + w) * (i+1);
        CGFloat y = 8;
        line.frame = CGRectMake(x, y, w, h);
        [self.btnBackView addSubview:line];
    }
    
}


-(NSMutableArray *)btnArr{
    if (!_btnArr) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}


@end
