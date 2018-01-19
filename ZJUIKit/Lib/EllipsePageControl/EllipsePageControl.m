//
//  EllipsePageControl.m
//  EllipsePageControl
//
//  Created by cardlan_yuhuajun on 2017/7/26.
//  Copyright © 2017年 cardlan. All rights reserved.
//

#import "EllipsePageControl.h"


@interface EllipsePageControl ()


@end

@implementation EllipsePageControl


-(instancetype)init{
    if(self=[super init]) {
 
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        [self initialize];

    }
    return self;
}



-(void)layoutSubviews{
    [super layoutSubviews];
    

}

-(void)initialize{
    self.backgroundColor=[UIColor clearColor];
    _numberOfPages=0;
    _currentPage=0;
    _controlSize=6;
    _controlSpacing=8;
    _otherColor=[UIColor grayColor];
    _currentColor=[UIColor orangeColor];
 
}

-(void)setOtherColor:(UIColor *)otherColor{
    
    if(![self isTheSameColor:otherColor anotherColor:_otherColor]){
        
        _otherColor=otherColor;
        [self createPointView];
    }
}

-(void)setCurrentColor:(UIColor *)currentColor{
    if(![self isTheSameColor:currentColor anotherColor:_currentColor]){
         _currentColor=currentColor;
        [self createPointView];
    }
}

-(void)setControlSize:(NSInteger)controlSize{
    if(controlSize!=_controlSize){
        _controlSize=controlSize;
        [self createPointView];

    }
}

-(void)setControlSpacing:(NSInteger)controlSpacing{
    if(_controlSpacing!=controlSpacing){
        
        _controlSpacing=controlSpacing;
        [self createPointView];

    }
}

-(void)setCurrentBkImg:(UIImage *)currentBkImg{
    if(_currentBkImg!=currentBkImg){
        _currentBkImg=currentBkImg;
        [self createPointView];
    }
}


-(void)setNumberOfPages:(NSInteger)page{
    if(_numberOfPages==page)
        return;
    _numberOfPages=page;
    [self createPointView];
}

-(void)setCurrentPage:(NSInteger)currentPage{
    
    
    if([self.delegate respondsToSelector:@selector(ellipsePageControlClick:index:)])
    {
        [self.delegate ellipsePageControlClick:self index:currentPage];
    }

    if(_currentPage==currentPage)
        return;
    
    [self exchangeCurrentView:_currentPage new:currentPage];
    _currentPage=currentPage;
 
    
}

-(void)clearView{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}



-(void)createPointView{
    [self clearView];
    if(_numberOfPages<=0)
        return;
    
    //居中控件
    CGFloat startX=0;
    CGFloat startY=0;
    CGFloat mainWidth=_numberOfPages*(_controlSize+_controlSpacing);
    if(self.frame.size.width<mainWidth){
        startX=0;
    }else{
        startX=(self.frame.size.width-mainWidth)/2;
    }
    if(self.frame.size.height<_controlSize){
        startY=0;
    }else{
        startY=(self.frame.size.height-_controlSize)/2;
    }
     //动态创建点
    for (int page=0; page<_numberOfPages; page++) {
        if(page==_currentPage){
             UIView *currPointView=[[UIView alloc]initWithFrame:CGRectMake(startX, startY, _controlSize*2, _controlSize)];
             currPointView.layer.cornerRadius=_controlSize/2;
             currPointView.tag=page+1000;
             currPointView.backgroundColor=_currentColor;
             currPointView.userInteractionEnabled=YES;
             UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
             [currPointView addGestureRecognizer:tapGesture];
             [self addSubview:currPointView];
             startX=CGRectGetMaxX(currPointView.frame)+_controlSpacing;
 
            if(_currentBkImg){
                currPointView.backgroundColor=[UIColor clearColor];
                UIImageView *currBkImg=[UIImageView new];
                currBkImg.tag=1234;
                currBkImg.frame=CGRectMake(0, 0, currPointView.frame.size.width, currPointView.frame.size.height);
                currBkImg.image=_currentBkImg;
                [currPointView addSubview:currBkImg];
             }
            
        }else{
            UIView *otherPointView=[[UIView alloc]initWithFrame:CGRectMake(startX, startY, _controlSize, _controlSize)];
            otherPointView.backgroundColor=_otherColor;
            otherPointView.tag=page+1000;
            otherPointView.layer.cornerRadius=_controlSize/2;
            otherPointView.userInteractionEnabled=YES;

            UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
            [otherPointView addGestureRecognizer:tapGesture];
            [self addSubview:otherPointView];
             startX=CGRectGetMaxX(otherPointView.frame)+_controlSpacing;
        }
    }
    
}

//切换当前的点
-(void)exchangeCurrentView:(NSInteger)old new:(NSInteger)new
{
    UIView *oldSelect=[self viewWithTag:1000+old];
    CGRect mpSelect=oldSelect.frame;
 
    UIView *newSeltect=[self viewWithTag:1000+new];
    CGRect newTemp=newSeltect.frame;
    
    if(_currentBkImg){
        UIView *imgview=[oldSelect viewWithTag:1234];
        [imgview removeFromSuperview];
        
        newSeltect.backgroundColor=[UIColor clearColor];
        UIImageView *currBkImg=[UIImageView new];
        currBkImg.tag=1234;
        currBkImg.frame=CGRectMake(0, 0, mpSelect.size.width, mpSelect.size.height);
        currBkImg.image=_currentBkImg;
        [newSeltect addSubview:currBkImg];
    }
    oldSelect.backgroundColor=_otherColor;
    newSeltect.backgroundColor=_currentColor;

    [UIView animateWithDuration:0.3 animations:^{
        

        
        CGFloat lx=mpSelect.origin.x;
         if(new<old)
            lx+=_controlSize;
        oldSelect.frame=CGRectMake(lx, mpSelect.origin.y, _controlSize, _controlSize);
 
        CGFloat mx=newTemp.origin.x;
        if(new>old)
            mx-=_controlSize;
        newSeltect.frame=CGRectMake(mx, newTemp.origin.y, _controlSize*2, _controlSize);
 
        // 左边的时候到右边 越过点击
        if(new-old>1)
        {
            for(NSInteger t=old+1;t<new;t++)
            {
              UIView *ms=[self viewWithTag:1000+t];
              ms.frame=CGRectMake(ms.frame.origin.x-_controlSize, ms.frame.origin.y, _controlSize, _controlSize);
            }
        }
        // 右边选中到左边的时候 越过点击
        if(new-old<-1)
        {
            for(NSInteger t=new+1;t<old;t++)
            {
                UIView *ms=[self viewWithTag:1000+t];
                ms.frame=CGRectMake(ms.frame.origin.x+_controlSize, ms.frame.origin.y, _controlSize, _controlSize);
            }
        }
        
        
    }];
    
    
 
}




-(void)clickAction:(UITapGestureRecognizer*)recognizer{
    
    NSInteger index=recognizer.view.tag-1000;
    
    NSLog(@"-----:%ld",index);

    [self setCurrentPage:index];


}


-(BOOL)isTheSameColor:(UIColor*)color1 anotherColor:(UIColor*)color2{
    return  CGColorEqualToColor(color1.CGColor, color2.CGColor);
}

@end
