//
//  UILabel+ZJLabel.h
//  ZJUIKit
//
//  Created by dzj on 2017/12/1.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ZJLabel)
/** 创建Label */
+(instancetype)zj_labelWithFrame:(CGRect)frame
                             text:(NSString *)text
                        fontSize:(int)fontSize
                          isBold:(BOOL)isBold
                       textColor:(UIColor *)color
                    textAligment:(NSTextAlignment)textAligment
                        numLines:(int)numLines;

/**
*  设置字间距
*/
- (void)setColumnSpace:(CGFloat)columnSpace;

/**
 *  设置行距
 */
- (void)setRowSpace:(CGFloat)rowSpace;

@end
