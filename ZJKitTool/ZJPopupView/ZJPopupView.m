//
//  ZJPopupView.m
//  ZJKitTool
//
//  Created by James on 2018/11/13.
//  Copyright © 2018 kapokcloud. All rights reserved.
//

#import "ZJPopupView.h"

#define ZJ_STATUSBAR_HEIGHT ([UIApplication sharedApplication].statusBarFrame.size.height)
#define KIS_iPhoneX ((ZJ_STATUSBAR_HEIGHT == 44) ? YES : NO)
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface ZJPopupView()
@property (nonatomic, assign) ZJPopupAnimationStyle style;
@property (nonatomic, strong) ZJBasePopupView *showView;
@property (nonatomic, assign) BOOL isBGClickAction;
//@property (nonatomic, assign) double durationTime;
@property (nonatomic, assign) CGFloat bgAlpha;
@property (nonatomic, assign) CGSize showViewSize;
//@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, assign) BOOL isShowComplete;
@end

@implementation ZJPopupView



#pragma mark - 初始化视图
+(instancetype)zj_showPopView:(ZJBasePopupView *)showView
                     viewSize:(CGSize)size
                     delegate:(id<ZJPopupViewDelegate>)delegate
                 durationTime:(double)durationTime
                      bgAlpha:(CGFloat)bgAlpha
              isBGClickAction:(BOOL)isBGClickAction
                   animaStyle:(ZJPopupAnimationStyle)animaStyle {
    
    return [self zj_showPopView:showView
                      superView:nil
                       viewSize:size
                       delegate:delegate
                   durationTime:durationTime
                        bgAlpha:bgAlpha
                isBGClickAction:isBGClickAction
                   isBlurEffect:NO
                     animaStyle:animaStyle
                       closeBtn:nil];
}

+(instancetype)zj_showPopView:(ZJBasePopupView *)showView
                    superView:(UIView *)superView
                     viewSize:(CGSize)size
                     delegate:(id<ZJPopupViewDelegate>)delegate
                 durationTime:(double)durationTime
                      bgAlpha:(CGFloat)bgAlpha
              isBGClickAction:(BOOL)isBGClickAction
                 isBlurEffect:(BOOL)isBlurEffect
                   animaStyle:(ZJPopupAnimationStyle)animaStyle
                     closeBtn:( UIButton * _Nullable )closeBtn{
    
    ZJPopupView *popViw =  [[self alloc]initWithShowView:showView
                                               superView:superView
                                                viewSize:size
                                                delegate:delegate
                                            durationTime:durationTime
                                                 bgAlpha:bgAlpha
                                         isBGClickAction:isBGClickAction
                                            isBlurEffect:isBlurEffect
                                              animaStyle:animaStyle
                                                closeBtn:closeBtn];
    [popViw zj_showPopupView];
    
    return popViw;
}



-(instancetype)initWithShowView:(ZJBasePopupView *)showView
                      superView:(UIView *)superView
                       viewSize:(CGSize)size
                       delegate:(id<ZJPopupViewDelegate>)delegate
                   durationTime:(double)durationTime
                        bgAlpha:(CGFloat)bgAlpha
                isBGClickAction:(BOOL)isBGClickAction
                   isBlurEffect:(BOOL)isBlurEffect
                     animaStyle:(ZJPopupAnimationStyle)animaStyle
                       closeBtn:(UIButton * __nullable)closeBtn; {
    
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.delegate = delegate;
        self.showViewSize = size;
        if (superView != nil) {
            self.frame = superView.bounds;
            [superView addSubview:self];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgViewAction:)];
            [self addGestureRecognizer:tap];
        }else{
            self.frame = [[UIScreen mainScreen] bounds];
            [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgViewAction:)];
            [self addGestureRecognizer:tap];
        }
        if (isBlurEffect) {
            // 毛片玻璃效果
            UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            UIVisualEffectView *effectView =[[UIVisualEffectView alloc]initWithEffect:blurEffect];
            effectView.frame = self.bounds;
            [self addSubview:effectView];
        }
        
        self.showView = showView;
        self.bgAlpha = bgAlpha > 0.0 ? bgAlpha : 0.5;
        self.durationTime = durationTime > 0.0 ? durationTime : 0.25;
        self.isBGClickAction = isBGClickAction;
        self.style = animaStyle;
        self.hidden = YES;
        self.backgroundColor = [UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:self.bgAlpha];
        if (showView != nil) {
            NSAssert([showView isKindOfClass:[ZJBasePopupView class]], @"showView 必须继承 ZJBasePopupView");
            self.showView = showView;
            self.showView.frame = CGRectMake((self.frame.size.width - size.width)/2, (self.frame.size.height - size.height)/2, size.width, size.height);
            [self addSubview:self.showView];
        }
        
        if (closeBtn != nil) {
            self.closeBtn = closeBtn;
            [self addSubview:self.closeBtn];
        }
        [self setUpAllView];
        
    }
    return self;
}

-(instancetype)init{
    if (self = [super init]) {
    }
    return self;
}

+(instancetype)zj_showWithPopupView:(ZJBasePopupView *)popupView{
    
   
    ZJPopupView *popView = [[ZJPopupView alloc]init];
    
    return popView;
}

#pragma SetUpView
-(void)setUpAllView {
    
    UITapGestureRecognizer *showViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showViewAction:)];
    [self.showView addGestureRecognizer:showViewTap];
    __weak typeof(self) weakSelf = self;
    self.showView.baseBlock = ^{
        [weakSelf zj_hiddenPopupView];
    };
    
    [self addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(KIS_iPhoneX ? 60 : 30);
        make.width.height.mas_equalTo(30);
    }];
}

#pragma mark - Setter
-(void)setPopupView:(ZJBasePopupView *)popupView{
    _popupView = popupView;
}

- (void)setBackgroundAlpha:(double)backgroundAlpha{
    _backgroundAlpha = backgroundAlpha;
}

-(void)setBackgroundIsClick:(BOOL)backgroundIsClick{
    _backgroundIsClick = backgroundIsClick;
}

-(void)setAnimationStyle:(ZJPopupAnimationStyle)animationStyle{
    _animationStyle = animationStyle;
}

- (void)setIsBlurEffect:(BOOL)isBlurEffect{
    _isBlurEffect = isBlurEffect;
}

-(void)setDurationTime:(double)durationTime{
    _durationTime = durationTime;
}

- (void)setPopupViewFrame:(CGSize)popupViewFrame{
    _popupViewFrame = popupViewFrame;
}


#pragma mark - Actions
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

-(void)closeBtnAction:(UIButton *)sender{
    [self zj_hiddenPopupView];
}

#pragma mark - 显示视图
-(void)zj_showPopupView{
    self.alpha = 0;
    self.hidden = false;
    self.isShowComplete = false;
    if ([self.delegate respondsToSelector:@selector(zj_willShowPopupView)]) {
        [self.delegate zj_willShowPopupView];
    }
    
    switch (self.style) {
        case ZJPopupAnimationTransition:
        {
            self.showView.transform = CGAffineTransformMakeTranslation(0, -(ScreenH -self.showView.frame.size.height)/2);
            [UIView animateWithDuration:self.durationTime animations:^{
                self.alpha = 1.0;
                self.showView.transform = CGAffineTransformTranslate(self.showView.transform, 0, (ScreenH-self.showView.frame.size.height)/2+50);
                
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:self.durationTime/2 animations:^{
                    self.showView.transform = CGAffineTransformTranslate(self.showView.transform, 0, -50);
                    self.isShowComplete = true;
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
            self.isShowComplete = true;
        }   break;
            
        case ZJPopupAnimationSacle:
        {
            self.showView.transform = CGAffineTransformMakeScale(1.3, 1.3);
            [UIView animateWithDuration:self.durationTime animations:^{
                self.alpha = 1.0;
                self.showView.transform =  CGAffineTransformMakeScale(1.0, 1.0);
            } completion:^(BOOL finished) {
                self.isShowComplete = true;
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
                self.isShowComplete = true;
            }];
        }
            break;
        default:
            break;
    }
}



#pragma mark - 隐藏视图
-(void)zj_hiddenPopupView{

    // 如果未显示完毕 则不能隐藏
    if (!self.isShowComplete) {
        return;
    }
    switch (self.style) {
        case ZJPopupAnimationTransition:
            {
                [UIView animateWithDuration:self.durationTime animations:^{
                    self.alpha = 0.0;
                    self.showView.transform = CGAffineTransformScale(self.showView.transform, 0.5, 0.5);
                } completion:^(BOOL finished) {
                    self.hidden = YES;
                    [self removePopAllSubviews];
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
                [self removePopAllSubviews];
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
                [self removePopAllSubviews];
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
                [self removePopAllSubviews];
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

- (void)removePopAllSubviews {
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

#pragma mark - Getter && Setter
-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc]init];
        [_closeBtn addTarget:self action:@selector(closeBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _closeBtn;
}
@end
