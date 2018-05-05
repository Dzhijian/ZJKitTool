//
//  ZJThreeChildView.h
//  ZJUIKit
//
//  Created by dzj on 2017/12/8.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//
/**
 *  ZJUIKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJUIKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下。😆
 */

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
