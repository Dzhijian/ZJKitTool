//
//  ZJElementsFlowLayout.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/29.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJElementsFlowLayout.h"
#define ZJXX(x) floorf(x)
#define ZJXS(s) ceilf(s)

static const CGFloat ZJ_XMargin = 10;
static const CGFloat ZJ_YMargin = 10;
static const UIEdgeInsets ZJ_edgeInsets = {10,10,10,10};

/**
 *  ZJKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下,给个Star。😆
 */

@interface ZJElementsFlowLayout()

/**
 * 所有cell的attrbts
 */
@property(nonatomic ,strong) NSMutableArray<UICollectionViewLayoutAttributes *> *zj_AtrbsArray;

/**
 * 每一列的最后的高度
 */
@property(nonatomic ,assign) CGRect zj_LastAtrbsFrame;

- (CGFloat)xMarginAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)yMarginAtIndexPath:(NSIndexPath *)indexPath;

- (UIEdgeInsets)edgeInsets;

- (CGRect)maxHeightFrame;

@end

@implementation ZJElementsFlowLayout

/**
 *  刷新布局的时候回重新调用
 */
-(void)prepareLayout{
    [super prepareLayout];
    
    // 如果重新刷新就需要移除之前储存的高度
    // 赋值以顶部的高度，并且根据列数
    self.zj_LastAtrbsFrame = CGRectMake(0, 0, self.collectionView.frame.size.width, 0);
    
    // 移除之前计算的cells的atrbs
    [self.zj_AtrbsArray removeAllObjects];
    // 并且重新计算，每个cell对应的atrbs，保存到数组
    for (NSInteger i = 0; i<[self.collectionView numberOfItemsInSection:0]; i++) {
        [self.zj_AtrbsArray addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }
}

/**
 *在这里边所处每个cell对应的位置和大小
 */
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *atrbs =[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // 原来的
    CGSize itemSize = [self.delegate zj_waterflowLayout:self collectionView:self.collectionView sizeForItemAtIndexPath:indexPath];
    CGFloat w = ZJXX(itemSize.width);
    w = MIN(w, self.collectionView.frame.size.width);
    
    // 高度由外界决定，外界必须实现这个方法
    CGFloat h = itemSize.height;
    
    // 拿到最后的高度最小的那一列，假设第0列最小
    CGFloat rightLeftWidth = self.collectionView.frame.size.width - CGRectGetMaxX(self.zj_LastAtrbsFrame)- [self xMarginAtIndexPath:indexPath]- self.edgeInsets.right;
    
    CGFloat x = self.edgeInsets.left;
    CGFloat y = self.edgeInsets.top;
    
    if (rightLeftWidth >= w) {
        
        x = CGRectGetMaxX(self.zj_LastAtrbsFrame )+[self xMarginAtIndexPath:indexPath];
        y = self.zj_LastAtrbsFrame.origin.y;
    }else{
        
        x = self.edgeInsets.left;
        y = CGRectGetMaxY(self.maxHeightFrame) + [self yMarginAtIndexPath:indexPath];
    }
    
    
    if (w > self.collectionView.frame.size.width - self.edgeInsets.left - self.edgeInsets.right) {
        
        x = (self.collectionView.frame.size.width - w) * 0.5;
        
    }
    
    
    if (y <= [self yMarginAtIndexPath:indexPath]) {
        y = self.edgeInsets.top;
    }
    
    // 赋值frame
    atrbs.frame = CGRectMake(x, y, w, h);
    
    // 覆盖添加完后那一列;的最新高度
    self.zj_LastAtrbsFrame = atrbs.frame;
    return atrbs;
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.zj_AtrbsArray;
}


-(CGRect)maxHeightFrame{

    __block CGRect maxHeightFrame = self.zj_LastAtrbsFrame;

    [self.zj_AtrbsArray enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (CGRectGetMaxY(obj.frame) > CGRectGetMaxY(maxHeightFrame)) {
            
            maxHeightFrame = obj.frame;
            
        }
        
    }];
    
    return maxHeightFrame;
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.frame.size.width, CGRectGetMaxY(self.maxHeightFrame) + self.edgeInsets.bottom);
}

- (CGFloat)xMarginAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(zj_waterflowLayout:collectionView:columnsMarginForItemAtIndexPath:)])
    {
        return [self.delegate zj_waterflowLayout:self collectionView:self.collectionView columnsMarginForItemAtIndexPath:indexPath];
    }
    else
    {
        return ZJ_XMargin;
    }
}

- (CGFloat)yMarginAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(zj_waterflowLayout:collectionView:linesMarginForItemAtIndexPath:)])
    {
        return [self.delegate zj_waterflowLayout:self collectionView:self.collectionView linesMarginForItemAtIndexPath:indexPath];
    }else
    {
        return ZJ_YMargin;
    }
}

- (UIEdgeInsets)edgeInsets
{
    if([self.delegate respondsToSelector:@selector(zj_waterflowLayout:edgeInsetsInCollectionView:)])
    {
        return [self.delegate zj_waterflowLayout:self edgeInsetsInCollectionView:self.collectionView];
    }
    else
    {
        return ZJ_edgeInsets;
    }
}

-(id<ZJElementsFlowLayoutDelegate>)delegate{
    
    return (id<ZJElementsFlowLayoutDelegate>)self.collectionView.dataSource;
}

-(instancetype)initWithDelegate:(id<ZJElementsFlowLayoutDelegate>)delegate{
    if (self = [super init]) {
        
    }
    return self;
}

+(instancetype)flowLayoutWithDelegate:(id<ZJElementsFlowLayoutDelegate>)deleagte{
    return [[self alloc]initWithDelegate:deleagte];
}


-(NSMutableArray *)zj_AtrbsArray{
    if (!_zj_AtrbsArray) {
        _zj_AtrbsArray = [NSMutableArray array];
    }
    return _zj_AtrbsArray;
}

@end
