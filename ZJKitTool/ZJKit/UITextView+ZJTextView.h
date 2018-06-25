//
//  UITextView+ZJTextView.h
//  ZJUIKit
//
//  Created by dzj on 2017/12/4.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (ZJTextView)

/**   创建UITextView */
+(instancetype)zj_textViewInitWithFrame:(CGRect)frame
                              textColor:(UIColor *)textColor
                               fontSize:(float)fontSize

                                bgColor:(UIColor *)bgColor;

    
@end
