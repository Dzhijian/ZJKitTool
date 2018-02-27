//
//  ZJPlayerListCell.h
//  ZJUIKit
//
//  Created by dzj on 2018/2/27.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJVideoModel.h"

typedef void(^PlayBtnAction)(UIButton *);

@interface ZJPlayerListCell : UITableViewCell

@property(nonatomic ,strong) UIImageView        *picImageV;

@property(nonatomic ,strong) ZJVideoModel       *model;

/*播放按钮block*/
@property(nonatomic ,copy) PlayBtnAction        playBtnBlock;

+(instancetype)cellWithTableView:(UITableView *)tableView;



@end
