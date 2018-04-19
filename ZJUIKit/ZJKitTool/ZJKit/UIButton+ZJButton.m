//
//  UIButton+ZJButton.m
//  ZJUIKit
//
//  Created by dzj on 2017/12/1.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import "UIButton+ZJButton.h"
#import <objc/runtime.h>

static NSString *const IndicatorViewKey = @"indicatorView";
static NSString *const ButtonTextObjectKey = @"buttonTextObject";

@implementation UIButton (ZJButton)

+(instancetype)zj_buttonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor imageName:(NSString *)imageName backColor:(UIColor *)backColor fontSize:(int)fontSize cornerRadius:(CGFloat)radius traget:(id)traget action:(SEL)action{
    
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundColor:backColor];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    button.frame = frame;
    button.layer.cornerRadius = radius;
    button.clipsToBounds = YES;
    [button addTarget:traget action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark - 点击事件
-(void)zj_addBtnActionHandler:(ButtonTouchUpInsideBlock)touchHandler{
    objc_setAssociatedObject(self, @selector(zj_addBtnActionHandler:), touchHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(blockActionTouchUp:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)blockActionTouchUp:(UIButton *)sender{
    ButtonTouchUpInsideBlock block = objc_getAssociatedObject(self, @selector(zj_addBtnActionHandler:));
    if (block) {
        block();
    }
}

#pragma mark - 显示菊花
-(void)zj_showIndicator{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    indicator.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
    [indicator startAnimating];
    
    NSString *currentButtonText = self.titleLabel.text;
    
    objc_setAssociatedObject(self, &ButtonTextObjectKey, currentButtonText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &IndicatorViewKey, indicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.enabled = NO;
    [self setTitle:@"" forState:UIControlStateNormal];
    [self addSubview:indicator];
}

-(void)zj_hideIndicator{
    NSString *currentBtnText = (NSString *)objc_getAssociatedObject(self, &ButtonTextObjectKey);
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)objc_getAssociatedObject(self, &IndicatorViewKey);
    self.enabled = YES;
    [indicator removeFromSuperview];
    [self setTitle:currentBtnText forState:UIControlStateNormal];
}

#pragma mark - 倒计时
- (void)zj_startTime:(NSInteger)timeout waitBlock:(void(^)(NSInteger remainTime))waitBlock finishBlock:(void(^)(void))finishBlock;
{
    __block NSInteger timeOut = timeout;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeOut <= 0)
        {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (finishBlock)
                {
                    finishBlock();
                }
                self.userInteractionEnabled = YES;
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (waitBlock)
                {
                    waitBlock(timeOut);
                }
                self.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}



@end
