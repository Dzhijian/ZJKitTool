//
//  ZJCommitCell.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/23.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJCommitFrame,ZJImgLeftBtn;

@protocol ZJCommitCellDelegate <NSObject>

/**
 * 点赞代理方法回调

 @param sender 按钮
 */
- (void)likeBtnClickAction:(ZJImgLeftBtn *)sender;

/**
 * 差评代理方法回调
 
 @param sender 按钮
 */
- (void)disLikeBtnClickAction:(ZJImgLeftBtn *)sender;

/**
 * 删除评论代理方法回调
 
 @param sender 按钮
 */
-(void)deleteBtnClickAction:(UIButton *)sender;

@end

@interface ZJCommitCell : UITableViewCell

// 点赞按钮
@property(nonatomic, weak) ZJImgLeftBtn             *likeBtn;
// 差评
@property(nonatomic, weak) ZJImgLeftBtn             *disLikeBtn;
// 是否有数据
@property(nonatomic ,assign) BOOL isHaveData;

//模型
@property(nonatomic, strong) ZJCommitFrame *commitFrame;

@property(nonatomic ,weak) id<ZJCommitCellDelegate> delegate;

@property(nonatomic ,weak) UIViewController *selfVc;

+(instancetype)cellWithTableView:(UITableView *)tableView;

// 设置索引
-(void)setChildBtnTag:(NSInteger)tag;

@end
