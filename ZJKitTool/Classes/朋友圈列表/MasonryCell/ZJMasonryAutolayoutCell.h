//
//  ZJMasonryAutolayoutCell.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/26.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJCommit;

@interface ZJMasonryAutolayoutCell : UITableViewCell

@property(nonatomic ,strong) ZJCommit           *model;



@property(nonatomic ,weak) UIViewController      *weakSelf;

@end
