//
//  ZJNormalPickerView.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/6/30.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJPickBaseView.h"

@interface ZJNormalPickerView : ZJPickBaseView

typedef void(^ZJNormalResultBlock)(id selectValue , NSInteger index);

typedef void(^ZJNormalCancelBlock)(void);


/// 标题
@property (nonatomic, copy) NSString              *title;
/// 数据源
@property (nonatomic, strong) NSArray               *dataSource;
/// 选中后的回调
@property (nonatomic, copy) ZJNormalResultBlock    resultBlock;
/// 取消选择的回调
@property (nonatomic, copy) ZJNormalCancelBlock    cancelBlock;
/// 是否开启自动选择
@property (nonatomic, assign) BOOL                  isAutoSelect;
/// 选中行文本的颜色
@property (nonatomic, strong) UIColor               *selecteRowTextColor;
/// 选中行背景颜色
@property (nonatomic, strong) UIColor               *selectRowBGColor;
/// 右边按钮颜色
@property (nonatomic, strong) UIColor               *rightBtnTitleColor;
/// 左边按钮颜色
@property (nonatomic, strong) UIColor               *leftBtnTitleColor;
/// 行高
@property (nonatomic, assign) CGFloat               rowHeight;
/// 默认值
@property (nonatomic, copy) id                      defaultValue;
/// 弹穿是否需要动画
@property (nonatomic, assign) bool                  animation;

/// 显示弹窗
-(void)showView;


@end
