//
//  ZJPickBaseView.m
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/6/27.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//
/**
 *  ZJKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下,给个Star。😆
 */

#import "ZJPickBaseView.h"
#import "ZJPickerViewMacro.h"
@interface ZJPickBaseView ()


@end

@implementation ZJPickBaseView


-(void)initWithAllView{
    
    self.frame = [UIScreen mainScreen].bounds;
    
    self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
    [self addSubview:self.backView];
    [self addSubview:self.alertView];
    [self.alertView addSubview:self.topView];
    [self.topView addSubview:self.leftBtn];
    [self.topView addSubview:self.rightBtn];
    [self.topView addSubview:self.titleLab];
    [self.topView addSubview:self.lineView];

}

#pragma mark - 点击背景图
-(void)backViewTapAction:(UITapGestureRecognizer *)gesture{
    
    
}

#pragma mark - 点击左边的按钮
-(void)leftBtnClickAction:(UIButton *)sender{
    
    
}

#pragma mark - 点击右边的按钮
-(void)rightBtnClickAction:(UIButton *)sender{
    
    
}

#pragma mark - 修改按钮文本颜色
-(void)setUpConfirmTitleColor:(UIColor *)confirmColor cancelColor:(UIColor *)cancelColor{
    
    if (confirmColor) {
    
        [self.rightBtn setTitleColor:confirmColor forState:(UIControlStateNormal)];
    }
    
    if (cancelColor) {
        
        [self.leftBtn setTitleColor:cancelColor forState:(UIControlStateNormal)];
    }
}

#pragma mark - Getter && Setter
-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _backView .backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        // 设置子视图的大小随着父视图变化
        _backView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _backView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backViewTapAction:)];
        [_backView addGestureRecognizer:tap];
    }
    return _backView;
}

-(UIView *)alertView{
    if (!_alertView) {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - kZJPickerHeight - kZJTopViewHeight - ZJ_BOTTOM_MARGIN , ScreenWidth, kZJPickerHeight +kZJTopViewHeight + ZJ_BOTTOM_MARGIN)];
        _alertView.backgroundColor = [UIColor whiteColor];
        // 设置子视图的大小随着父视图变化
        _alertView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    }
    return _alertView;
}

-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.alertView.frame.size.width, kZJTopViewHeight + 0.5)];
        _topView.backgroundColor = [UIColor lightTextColor];
        // 设置子视图的大小随着父视图变化
        _topView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    }
    return _topView;
}

-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(6, 8, 60, 28)];
        _leftBtn.backgroundColor = [UIColor lightTextColor];
        _leftBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
        _leftBtn.titleLabel.font = kFontSize(15);
        [_leftBtn setTitleColor:kDefaultThemeColor forState:UIControlStateNormal];
        [_leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

#pragma mark - 右边确定按钮
- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.alertView.frame.size.width - 65, 8, 60, 28)];
        _rightBtn.backgroundColor = kBRToolBarColor;
        _rightBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
        _rightBtn.titleLabel.font = kFontSize(15);
        [_rightBtn setTitleColor:kDefaultThemeColor forState:UIControlStateNormal];
        [_rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}


-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(self.leftBtn.frame.origin.x + self.leftBtn.frame.size.width + 2, 0, self.alertView.frame.size.width - 2 * (self.leftBtn.frame.origin.x + self.leftBtn.frame.size.width + 2), kZJTopViewHeight)];
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
        _titleLab.font = kFontSize(14);
        _titleLab.textColor = [kDefaultThemeColor colorWithAlphaComponent:0.8f];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

#pragma mark - 分割线
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kZJTopViewHeight, self.alertView.frame.size.width, 0.5)];
        _lineView.backgroundColor = k16RGBColor(0xf1f1f1);
        _lineView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        [self.alertView addSubview:_lineView];
    }
    return _lineView;
}

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}
@end
