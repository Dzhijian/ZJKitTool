//
//  ZJBasePopupView.m
//  ZJKitTool
//
//  Created by James on 2018/11/13.
//  Copyright © 2018 kapokcloud. All rights reserved.
//

#import "ZJBasePopupView.h"

@implementation ZJBasePopupView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        if (self.baseBlock) {
            self.baseBlock();
        }
        if (self.closeBlock) {
            self.closeBlock();
        }
    }
    return self;
}

@end
