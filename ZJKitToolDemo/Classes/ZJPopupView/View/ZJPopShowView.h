//
//  ZJPopShowView.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/11/29.
//  Copyright © 2018 kapokcloud. All rights reserved.
//

#import "ZJBasePopupView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^OKBtnBlock)(void);

@interface ZJPopShowView : ZJBasePopupView


@property (nonatomic, copy) OKBtnBlock okBlock;

@end

NS_ASSUME_NONNULL_END
