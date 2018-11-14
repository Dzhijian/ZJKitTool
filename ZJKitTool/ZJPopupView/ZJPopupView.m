//
//  ZJPopupView.m
//  ZJKitTool
//
//  Created by James on 2018/11/13.
//  Copyright © 2018 kapokcloud. All rights reserved.
//

#import "ZJPopupView.h"
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
@interface ZJPopupView()
@property (nonatomic, assign) ZJPopupAnimationStyle style;
@property (nonatomic, strong) ZJBasePopupView *showView;
@property (nonatomic, assign) BOOL isBGClickAction;
@property (nonatomic, assign) double durationTime;
@property (nonatomic, assign) CGFloat bgAlpha;
@property (nonatomic, assign) CGSize showViewSize;


@end

@implementation ZJPopupView

-(instancetype)initWithShowView:(ZJBasePopupView *)showView viewSize:(CGSize)size delegate:(id<ZJPopupViewDelegate>)delegate style:(ZJPopupAnimationStyle)style{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.delegate = delegate;
        self.showViewSize = size;
        self.showView = showView;
        self.bgAlpha = 0.5;
        self.durationTime = 0.25;
        self.isBGClickAction = YES;
        self.style = style;
        self.hidden = YES;
        self.backgroundColor = kRGBA(33, 33, 33, self.bgAlpha);
        if (showView != nil) {
            NSAssert([showView isKindOfClass:[ZJBasePopupView class]], @"showView 必须继承 ZJBasePopupView");
            self.showView = showView;
            self.showView.frame = CGRectMake((ScreenW - size.width)/2, (ScreenH - size.width)/2, size.width, size.height);
            [self addSubview:self.showView];
        }
        
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgViewAction:)];
        [self addGestureRecognizer:tap];
        
        UITapGestureRecognizer *showViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showViewAction:)];
        [self.showView addGestureRecognizer:showViewTap];
        
        __weak typeof(self) weakSelf = self;
        self.showView.baseBlock = ^{
            [weakSelf zj_hiddenPopupView];
        };
    }
    return self;
}

-(void)bgViewAction:(UITapGestureRecognizer *)gesture{
    
    if ([self.delegate respondsToSelector:@selector(zj_clickBgViewAction)]) {
        [self.delegate zj_clickBgViewAction];
    }
    if (self.isBGClickAction) {
        [self zj_hiddenPopupView];
    }
}

-(void)showViewAction:(UITapGestureRecognizer *)gesture{
    if ([self.delegate respondsToSelector:@selector(zj_clickShowViewAction)]) {
        [self.delegate zj_clickShowViewAction];
    }
}

-(void)zj_showPopupView{
    self.alpha = 0;
    self.hidden = false;
    if ([self.delegate respondsToSelector:@selector(zj_willShowPopupView)]) {
        [self.delegate zj_willShowPopupView];
    }
    
    switch (self.style) {
        case ZJPopupAnimationTransition:
        {
            self.showView.transform = CGAffineTransformMakeTranslation(0, -(ScreenH -self.showView.height)/2);
            [UIView animateWithDuration:self.durationTime animations:^{
                self.alpha = 1.0;
                self.showView.transform = CGAffineTransformTranslate(self.showView.transform, 0, (ScreenH-self.showView.height)/2+50);

            } completion:^(BOOL finished) {
                [UIView animateWithDuration:self.durationTime/2 animations:^{
                    //self.showView.transform = CGAffineTransformMakeTranslation(0, -50);
                    self.showView.transform = CGAffineTransformTranslate(self.showView.transform, 0, -50);
                }];
            }];
        }
            break;
            
        case ZJPopupAnimationRotation:
        {
            self.alpha = 1.0;
            CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scaleAnimation.fromValue = @0.01f;
            scaleAnimation.toValue = @1.0f;
            
            CABasicAnimation *rotaAnima = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            rotaAnima.toValue = @(M_PI*2);
            
            CAAnimationGroup *group = [CAAnimationGroup animation];
            group.animations = @[scaleAnimation,rotaAnima];
            group.duration = self.durationTime * 2;
            group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            [self.showView.layer addAnimation:group forKey:@"groupAnimation"];
        }   break;
            
        case ZJPopupAnimationSacle:
        {
            self.showView.transform = CGAffineTransformMakeScale(1.3, 1.3);
            [UIView animateWithDuration:self.durationTime animations:^{
                self.alpha = 1.0;
                self.showView.transform =  CGAffineTransformMakeScale(1.0, 1.0);
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
            
        case ZJPopupAnimationAlpha:
        {
            self.showView.alpha = 0.0;
            [UIView animateWithDuration:self.durationTime animations:^{
                self.alpha = 1.0;
                self.showView.alpha = 1.0;
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        default:
            break;
    }
}


-(void)zj_hiddenPopupView{
    switch (self.style) {
        case ZJPopupAnimationTransition:
            {
                [UIView animateWithDuration:self.durationTime animations:^{
                    self.alpha = 0.0;
                    self.showView.transform = CGAffineTransformScale(self.showView.transform, 0.5, 0.5);
                } completion:^(BOOL finished) {
                    self.hidden = YES;
                    [self removeAllSubviews];
                }];
            }
            break;
        case ZJPopupAnimationRotation:
        {
            [UIView animateWithDuration:self.durationTime animations:^{
                self.alpha = 0.0;
                self.showView.transform = CGAffineTransformScale(self.showView.transform, 0.5, 0.5);
            } completion:^(BOOL finished) {
                self.hidden = YES;
                [self removeAllSubviews];
            }];
        }
            break;
        case ZJPopupAnimationSacle:
        {
            [UIView animateWithDuration:self.durationTime animations:^{
                self.alpha = 0.0;
                self.showView.transform =  CGAffineTransformMakeScale(0.5, 0.5);
            } completion:^(BOOL finished) {
                self.hidden = YES;
                [self removeAllSubviews];
            }];
        }
            break;
        case ZJPopupAnimationAlpha:
        {
            [UIView animateWithDuration:self.durationTime animations:^{
                self.alpha = 0.0;
                self.showView.transform = CGAffineTransformScale(self.showView.transform, 0.5, 0.5);
            } completion:^(BOOL finished) {
                self.hidden = YES;
                [self removeAllSubviews];
            }];
        }
            break;
        default:
            break;
    }
    
    if ([self.delegate respondsToSelector:@selector(zj_didHiddenPopupView)]) {
        [self.delegate zj_didHiddenPopupView];
    }
    
}

@end
