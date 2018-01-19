//
//  HomeHeadView.m
//  ZJUIKit
//
//  Created by dzj on 2017/12/5.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import "HomeHeadView.h"
#import "BHInfiniteScrollView.h"


@interface HomeHeadView()<BHInfiniteScrollViewDelegate>

@property(nonatomic ,strong) BHInfiniteScrollView *infinitePageView;

@end

@implementation HomeHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
        self.infinitePageView.imagesArray = @[@"001",@"002",@"003"];
    }
    return self;
}




-(void)setUpAllView{
    [self addSubview:self.infinitePageView];
    
    
}

-(BHInfiniteScrollView *)infinitePageView{
    if (!_infinitePageView) {
        _infinitePageView = [BHInfiniteScrollView
                             infiniteScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 200) Delegate:self ImagesArray:nil];
        _infinitePageView.dotSize = 10;
        _infinitePageView.pageControlAlignmentOffset = CGSizeMake(0,10);
        _infinitePageView.scrollTimeInterval = 3;
        _infinitePageView.autoScrollToNextPage = YES;
        _infinitePageView.dotSize= 7;
        _infinitePageView.selectedDotColor = [UIColor orangeColor];
        _infinitePageView.pageControlHidden = NO;
        _infinitePageView.pageControlAlignmentH = BHInfiniteScrollViewPageControlAlignHorizontalCenter;
    }
    return _infinitePageView;
}


@end
