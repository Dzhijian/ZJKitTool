//
//  ZJCommitFrame.h
//  ZJCommitListDemo
//
//  Created by 邓志坚 on 2017/12/10.
//  Copyright © 2017年 邓志坚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ZJCommit;
@interface ZJCommitFrame : NSObject

// commit 模型
@property(nonatomic, strong) ZJCommit *commit;

// 头像
@property(nonatomic, assign) CGRect iconFrame;

// 昵称
@property(nonatomic, assign) CGRect nameFrame;

// 评论内容
@property(nonatomic, assign) CGRect contentFrame;

// 喜欢
@property(nonatomic, assign) CGRect likeFrame;

// 不喜欢
@property(nonatomic, assign) CGRect disLikeFrame;

// 时间
@property(nonatomic, assign) CGRect timeFrame;

// 删除
@property(nonatomic ,assign) CGRect deleteFrame;

// 配图
@property(nonatomic, assign) CGRect photosFrame;

// 星级
@property(nonatomic, assign) CGRect starFrame;

@property(nonatomic, assign) CGFloat cellHeight;


@end
