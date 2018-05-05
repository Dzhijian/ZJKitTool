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

// 头像Frame
@property(nonatomic, assign) CGRect iconFrame;

// 昵称Frame
@property(nonatomic, assign) CGRect nameFrame;

// 评论内容Frame
@property(nonatomic, assign) CGRect contentFrame;

// 喜欢按钮Frame
@property(nonatomic, assign) CGRect likeFrame;

// 不喜欢按钮Frame
@property(nonatomic, assign) CGRect disLikeFrame;

// 时间Frame
@property(nonatomic, assign) CGRect timeFrame;

// 删除按钮Frame
@property(nonatomic ,assign) CGRect deleteFrame;

// 配图Frame
@property(nonatomic, assign) CGRect photosFrame;

// 星级Frame
@property(nonatomic, assign) CGRect starFrame;

// cell的高度
@property(nonatomic, assign) CGFloat cellHeight;


@end
