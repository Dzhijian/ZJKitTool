//
//  ZJStarsView.m
//  ZJCommitListDemo
//
//  Created by 邓志坚 on 2017/12/10.
//  Copyright © 2017年 邓志坚. All rights reserved.
//

#import "ZJStarsView.h"

@interface ZJStarsView()

@end

@implementation ZJStarsView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
    }
    return self;
}

-(void)setUpAllView{

    for (int i = 0; i< 5; i++) {
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.contentMode = UIViewContentModeCenter;
        [self addSubview:imageV];
    }
}

-(void)setStarCount:(NSString *)starCount{
    
    float star = [starCount floatValue];
    // 取余数
    NSInteger stardec = ((NSInteger)(star * 10)) % 10;
    
    NSInteger allStar = 0;
    
    if (stardec>0 && stardec < 5) {
        allStar = [starCount integerValue] + 1;
    }else if (stardec > 4){
        allStar = [starCount integerValue] + 1;
    }else{
        allStar = [starCount integerValue];
    }
    
//    NSLog(@"余数--->%ld",stardec);
    NSInteger count = self.subviews.count;
    for (int i = 0; i<count; i++) {
        UIImageView *imageV = self.subviews[i];
        if (i<allStar) {
        
            if (i == allStar-1 && stardec < 5 && stardec > 0) {
                imageV.image = kImageName(@"home_half_star");
            }else{
                imageV.image = kImageName(@"home_light_star");
            }
            
        }else{
            imageV.image = kImageName(@"home_gray_star");
        }
    }
}

-(NSString *)calculateByDividing:(NSString *)stringNumer num:(NSString *)num
{
    NSDecimalNumber * num1 = [ NSDecimalNumber  decimalNumberWithString: num ];
    NSDecimalNumber * num2 = [ NSDecimalNumber  decimalNumberWithString: stringNumer];
    NSDecimalNumber * divideNum = [num1 decimalNumberByDividingBy:num2];
    return [ divideNum stringValue ];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat margin = 5;
    CGFloat WH = 14;
    NSInteger count = self.subviews.count;
    for (int i = 0; i<count; i++) {
        UIImageView *imageV = self.subviews[i];
        CGFloat imgVX = x + i * WH + i * margin;
        imageV.frame = CGRectMake(imgVX, y, WH, WH);
    }
}

@end
