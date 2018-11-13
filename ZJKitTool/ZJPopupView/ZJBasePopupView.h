//
//  ZJBasePopupView.h
//  ZJKitTool
//
//  Created by James on 2018/11/13.
//  Copyright © 2018 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ShowViewActionBlock)(void);

@interface ZJBasePopupView : UIView

@property (nonatomic, copy) ShowViewActionBlock baseBlock;


@end

NS_ASSUME_NONNULL_END
