//
//  ZJChooseControlView.h
//  ZJUIKit
//
//  Created by dzj on 2017/12/7.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ZJChooseControlDelegate <NSObject>

// 点击按钮
-(void)chooseControlWithBtnArray:(NSArray *)array button:(UIButton *)sender;

@end

@interface ZJChooseControlView : UIView

@property(nonatomic ,strong) NSArray *titleArr;

@property(nonatomic ,weak) id<ZJChooseControlDelegate> delegate;
// 按钮数组
@property(nonatomic ,strong) NSMutableArray *btnArr;

-(void)setUpAllViewWithTitleArr:(NSArray *)titleArr;

@end
