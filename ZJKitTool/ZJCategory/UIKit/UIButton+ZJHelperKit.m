//
//  UIButton+ZJHelperKit.m
//  ZJKitTool
//
//  Created by dzj on 2021/2/26.
//  Copyright © 2021 kapokcloud. All rights reserved.
//

#import "UIButton+ZJHelperKit.h"
#import <objc/runtime.h>

static NSString *const IndicatorViewKey = @"indicatorView";
static NSString *const ButtonTextObjectKey = @"buttonTextObject";

@implementation UIButton (ZJHelperKit)

#pragma mark - 设置背景颜色
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    
    [self setBackgroundImage:[self zj_imageWithColor:backgroundColor] forState:state];
}

#pragma mark - 设置图片位置
- (CGSize)zj_setButtonImagePosition:(ZJButtonImagePosition)position spacing:(CGFloat)spacing
{
   // 1. 得到imageView和titleLabel的宽、高
       CGFloat imageWith = self.imageView.frame.size.width;
       CGFloat imageHeight = self.imageView.frame.size.height;
    
       CGFloat labelWidth = 0.0;
       CGFloat labelHeight = 0.0;
       if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
           // 由于iOS8中titleLabel的size为0，用下面的这种设置
           labelWidth = self.titleLabel.intrinsicContentSize.width;
           labelHeight = self.titleLabel.intrinsicContentSize.height;
       } else {
           labelWidth = self.titleLabel.frame.size.width;
           labelHeight = self.titleLabel.frame.size.height;
       }
    
       // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
       UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
       UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    

    CGSize buttonSize = CGSizeZero;
    
    
   // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (position) {
        case ZJButtonImagePositionTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-spacing/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-spacing/2.0, 0);
        }
            break;
        case ZJButtonImagePositionLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2.0, 0, spacing/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, spacing/2.0, 0, -spacing/2.0);
        }
            break;
        case ZJButtonImagePositionBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-spacing/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-spacing/2.0, -imageWith, 0, 0);
        }
            break;
        case ZJButtonImagePositionRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+spacing/2.0, 0, -labelWidth-spacing/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-spacing/2.0, 0, imageWith+spacing/2.0);
        }
            break;
        default:
            break;
    }
    // 4. 赋
    
    self.titleEdgeInsets = labelEdgeInsets;
    
    self.imageEdgeInsets = imageEdgeInsets;
    
    return buttonSize;
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
#pragma mark - 隐藏菊花
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

- (UIImage *)zj_imageWithColor:(UIColor *)color{
    if (!color) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
