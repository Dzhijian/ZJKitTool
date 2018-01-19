//
//  ZJChooseShowView.m
//  ZJUIKit
//
//  Created by dzj on 2017/12/8.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import "ZJChooseShowView.h"
#import "ZJOneChildView.h"
#import "ZJTwoChildView.h"
#import "ZJThreeChildView.h"
#import "ZJFourChildView.h"

typedef enum : NSUInteger {
    ChooseViewShowOne,
    ChooseViewShowTwo,
    ChooseViewShowThree,
    ChooseViewShowFour
} ChooseViewShow;

@interface ZJChooseShowView()

@property(nonatomic ,strong) ZJOneChildView         *oneView;
@property(nonatomic ,strong) ZJTwoChildView         *twoView;
@property(nonatomic ,strong) ZJThreeChildView       *threeView;
@property(nonatomic ,strong) ZJFourChildView        *fourView;
@property(nonatomic ,strong) NSArray                *viewArray;
// 记录弹出的是哪一个视图
@property(nonatomic ,assign) ChooseViewShow         chooseView;
@property(nonatomic ,strong) UIButton               *seleBtn;


@end

@implementation ZJChooseShowView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:1/255.0 green:1/255.0 blue:1/255.0 alpha:0.0];
        self.viewArray = @[self.oneView,self.twoView,self.threeView,self.fourView];
        [self addSubview:self.hiddenView];
        UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideAction:)];
        [self.hiddenView addGestureRecognizer:tap];
        
    }
    return self;
}

-(void)hideAction:(UITapGestureRecognizer *)gesture{
    
    // 改变按钮的状态
    self.seleBtn.selected = !self.seleBtn.isSelected;
    // 隐藏视图
    switch (self.chooseView) {
        case 0:
            [self hideOneView];
            break;
        case 1:
            [self hideTwoView];
            break;
        case 2:
            [self hideThreeView];
            break;
        case 3:
            [self hideFourView];
            break;
        default:
            break;
    }
    
}

#pragma mark -  点击筛选按钮
-(void)chooseControlViewBtnArray:(NSArray *)btnArr Action:(UIButton *)sender{
    self.seleBtn = sender;
    for (int i = 0; i<btnArr.count; i++) {
        UIButton *btn = btnArr[i];
        if (btn.tag == sender.tag) {
            
        }else{
            btn.selected = NO;
        }
    }
    self.chooseView = sender.tag;
    switch (sender.tag) {
        case 0:
        {
            if (sender.selected) {
                [self hideOtherChilView:self.oneView];
                [self showOneView];
            }else{
                [self hideOneView];
            }
        }
            break;
        case 1:
            if (sender.selected) {
                [self hideOtherChilView:self.twoView];
                [self showTwoView];
            }else{
                [self hideTwoView];
            }
            break;
        case 2:
            if (sender.selected) {
                [self hideOtherChilView:self.threeView];
                [self showThreeView];
            }else{
                [self hideThreeView];
            }
            break;
        case 3:
            if (sender.selected) {
                [self hideOtherChilView:self.fourView];
                [self showFourView];
            }else{
                [self hideFourView];
            }
            break;
            
        default:
            break;
    }
}

#pragma mark - 隐藏其他视图
-(void)hideOtherChilView:(UIView *)view{
    
    
    for (int i = 0; i<self.viewArray.count; i++) {
        UIView *childView = self.viewArray[i];
        if (view == childView) {
            
        }else{
            childView.hidden = YES;
            childView.frame = CGRectMake(0, 0, ScreenWidth, 0);
            for (UITableView *tabView in childView.subviews) {
                tabView.frame = CGRectMake(0, 0, ScreenWidth, 0);
            }
        }
    }
    
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.oneView.isHidden) {
        CGFloat hiddY = CGRectGetMaxY(self.oneView.frame);
        self.hiddenView.frame = CGRectMake(0, hiddY, ScreenWidth, ScreenHeight - hiddY);
    }else if (self.twoView.isHidden){
        CGFloat hiddY = CGRectGetMaxY(self.twoView.frame);
        self.hiddenView.frame = CGRectMake(0, hiddY, ScreenWidth, ScreenHeight - hiddY);
    }else if (self.threeView.isHidden){
        CGFloat hiddY = CGRectGetMaxY(self.threeView.frame);
        self.hiddenView.frame = CGRectMake(0, hiddY, ScreenWidth, ScreenHeight - hiddY);
    }else if (self.fourView.isHidden){
        CGFloat hiddY = CGRectGetMaxY(self.fourView.frame);
        self.hiddenView.frame = CGRectMake(0, hiddY, ScreenWidth, ScreenHeight - hiddY);
    }
}

#pragma mark - OneView
-(void)showOneView{
    

    [self addSubview:self.oneView];
    _oneView.hidden = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.oneView.frame = CGRectMake(0, 0, ScreenWidth, 400);
        self.oneView.leftTable.frame = CGRectMake(0, 0, ScreenWidth/2, 400);
        self.oneView.rightTable.frame = CGRectMake(ScreenWidth/2, 0, ScreenWidth/2, 400);
        self.backgroundColor = [UIColor colorWithRed:1/255.0 green:1/255.0 blue:1/255.0 alpha:0.3];
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hideOneView{
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.25 animations:^{
        self.oneView.frame = CGRectMake(0, 0, ScreenWidth, 0);
        self.oneView.leftTable.frame = CGRectMake(0, 0, ScreenWidth/2, 0);
        self.oneView.rightTable.frame = CGRectMake(ScreenWidth/2, 0, ScreenWidth/2, 0);
    } completion:^(BOOL finished) {
        self.oneView.hidden = YES;
        self.hidden = YES;
    }];
}

#pragma mark - twoView
-(void)showTwoView{
    
    [self addSubview:self.twoView];
    _twoView.hidden = NO;
    [UIView animateWithDuration:0.25 animations:^{
        _twoView.frame = CGRectMake(0, 0, ScreenWidth, 500);
        _twoView.leftTable.frame = CGRectMake(0, 0, ScreenWidth/2, 500);
        _twoView.rightTable.frame = CGRectMake(ScreenWidth/2, 0, ScreenWidth/2, 500);
        self.backgroundColor = [UIColor colorWithRed:1/255.0 green:1/255.0 blue:1/255.0 alpha:0.3];
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hideTwoView{
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.25 animations:^{
        _twoView.frame = CGRectMake(0, 0, ScreenWidth, 0);
        _twoView.leftTable.frame = CGRectMake(0, 0, ScreenWidth/2, 0);
        _twoView.rightTable.frame = CGRectMake(ScreenWidth/2, 0, ScreenWidth/2, 0);
    } completion:^(BOOL finished) {
        _twoView.hidden = YES;
        self.hidden = YES;
    }];
}


#pragma mark - ThreeView
-(void)showThreeView{
    
    [self addSubview:self.threeView];
    _threeView.hidden = NO;
    [UIView animateWithDuration:0.25 animations:^{
        _threeView.frame = CGRectMake(0, 0, ScreenWidth, 300);
       
        self.backgroundColor = [UIColor colorWithRed:1/255.0 green:1/255.0 blue:1/255.0 alpha:0.3];
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hideThreeView{
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.25 animations:^{
        _threeView.frame = CGRectMake(0, 0, ScreenWidth, 0);
       
    } completion:^(BOOL finished) {
        _threeView.hidden = YES;
        self.hidden = YES;
    }];
}


#pragma mark - FourView
-(void)showFourView{
    
    [self addSubview:self.fourView];
    _fourView.hidden = NO;
    [UIView animateWithDuration:0.25 animations:^{
        _fourView.frame = CGRectMake(0, 0, ScreenWidth, 450);
        
        self.backgroundColor = [UIColor colorWithRed:1/255.0 green:1/255.0 blue:1/255.0 alpha:0.3];
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hideFourView{
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.25 animations:^{
        _fourView.frame = CGRectMake(0, 0, ScreenWidth, 0);
        
    } completion:^(BOOL finished) {
        _fourView.hidden = YES;
        self.hidden = YES;
    }];
}


-(ZJOneChildView *)oneView{
    if (!_oneView) {
        _oneView = [[ZJOneChildView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
        _oneView.hidden = YES;
        _oneView.backgroundColor = [UIColor orangeColor];
    }
    return _oneView;
}

-(ZJTwoChildView *)twoView{
    if (!_twoView) {
        _twoView = [[ZJTwoChildView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
        _twoView.hidden = YES;
        _twoView.backgroundColor = [UIColor redColor];
    }
    return _twoView;
}

-(ZJThreeChildView *)threeView{
    if (!_threeView) {
        _threeView = [[ZJThreeChildView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
        _threeView.hidden = YES;
        _threeView.backgroundColor = [UIColor greenColor];
    }
    return _threeView;
}

-(ZJFourChildView *)fourView{
    if (!_fourView) {
        _fourView = [[ZJFourChildView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
        _fourView.hidden = YES;
        _fourView.backgroundColor = [UIColor blueColor];
    }
    return _fourView;
}
-(UIView *)hiddenView{
    if (!_hiddenView) {
        _hiddenView = [[UIView alloc]init];
    }
    return _hiddenView;
}

@end
