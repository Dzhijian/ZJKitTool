//
//  ZJThreeChildView.h
//  ZJUIKit
//
//  Created by dzj on 2017/12/8.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZJThreeChildViewDelegate <NSObject>


/**
 * 选中的cell 回调

 @param index 索引
 */
-(void)threeViewTableviewDidSelectedWithIndex:(NSInteger)index;

@end


@interface ZJThreeChildView : UIView

@property(nonatomic ,strong) UITableView *mainTable;

@property(nonatomic ,strong) NSArray *titleArray;

@property(nonatomic ,weak) id<ZJThreeChildViewDelegate> delegate;



@end
