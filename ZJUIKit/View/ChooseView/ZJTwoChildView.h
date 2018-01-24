//
//  ZJTwoChildView.h
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

@protocol ZJTwoChildViewDelegate <NSObject>

@optional

/**
 * 选中左边tableview cell 的回调

 @param index 索引
 */
-(void)twoViewLeftTableDidSelectedWithIndex:(NSInteger)index;


/**
 * 选中右边tableview cell 的回调

 @param LeftIndex 左边的索引
 @param rightIndex 右边的索引
 @param mc_id id
 */
-(void)twoViewRightTableDidSelectedWithLeftIndex:(NSInteger)LeftIndex rightIndex:(NSInteger)rightIndex mcid:(NSString *)mc_id;

@end

@interface ZJTwoChildView : UIView

@property(nonatomic ,strong) NSMutableArray     *dataArray;
@property(nonatomic ,strong) NSMutableArray     *rightDataArrray;
@property(nonatomic ,strong) UITableView        *leftTable;
@property(nonatomic ,strong) UITableView        *rightTable;

// 选中的索引
@property(nonatomic ,assign) NSInteger          leftSeleIndex;
@property(nonatomic ,assign) NSInteger          rightSeleIndex;

@property(nonatomic ,weak) id<ZJTwoChildViewDelegate> delegate;

@end
