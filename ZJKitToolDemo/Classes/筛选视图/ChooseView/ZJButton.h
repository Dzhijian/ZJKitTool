//
//  ZJButton.h
//  ZJUIKit
//
//  Created by dzj on 2017/12/5.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  按钮中图片的位置
 */
typedef NS_ENUM(NSUInteger, ZJImageAlignment) {
    /**
     *  图片在左，默认
     */
    ZJImageAlignmentLeft = 0,
    /**
     *  图片在上
     */
    ZJImageAlignmentTop,
    /**
     *  图片在下
     */
    ZJImageAlignmentBottom,
    /**
     *  图片在右
     */
    ZJImageAlignmentRight,
};

@interface ZJButton : UIButton
/**
 *  按钮中图片的位置
 */
@property(nonatomic,assign)ZJImageAlignment imageAlignment;
/**
 *  按钮中图片与文字的间距
 */
@property(nonatomic,assign)CGFloat spaceBetweenTitleAndImage;
@end
