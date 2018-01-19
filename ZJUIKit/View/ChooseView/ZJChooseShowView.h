//
//  ZJChooseShowView.h
//  ZJUIKit
//
//  Created by dzj on 2017/12/8.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJChooseShowView : UIView
// 按钮数组
@property(nonatomic ,strong) NSArray        *btnArray;
@property(nonatomic ,strong) UIView         *hiddenView;

-(void)chooseControlViewBtnArray:(NSArray *)btnArr Action:(UIButton *)sender;

@end
