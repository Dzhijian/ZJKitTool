//
//  ZJHorizontalFlowLayout.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/30.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJHorizontalFlowLayout.h"

#define ZJXX(x) floorf(x)
#define ZJXS(s) ceilf(s)

static const NSInteger      ZJ_Lines = 3;
static const CGFloat        ZJ_XMargin = 10;
static const CGFloat        ZJ_YMargin = 10;
static const UIEdgeInsets   ZJ_EdgeInsets = {10, 10, 10, 10};

/**
 *  ZJKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下,给个Star。😆
 */

@interface ZJHorizontalFlowLayout()
/** 所有的cell的attrbts */
@property (nonatomic, strong) NSMutableArray *zj_AtrbsArray;

/** 每一列的最后的高度 */
@property (nonatomic, strong) NSMutableArray *zj_LinesWidthArray;

- (NSInteger)lines;

- (CGFloat)xMarginAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)yMargin;

- (UIEdgeInsets)edgeInsets;
@end

@implementation ZJHorizontalFlowLayout

/**
 *  刷新布局的时候回重新调用
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    //如果重新刷新就需要移除之前存储的高度
    [self.zj_LinesWidthArray removeAllObjects];
    
    //复赋值以顶部的高度, 并且根据列数
    for (NSInteger i = 0; i < self.lines; i++) {
        
        [self.zj_LinesWidthArray addObject:@(self.edgeInsets.left)];
    }
    
    // 移除以前计算的cells的attrbs
    [self.zj_AtrbsArray removeAllObjects];
    
    // 并且重新计算, 每个cell对应的atrbs, 保存到数组
    for (NSInteger i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++)
    {
        [self.zj_AtrbsArray addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }
}


/**
 *在这里边所处每个cell对应的位置和大小
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *atrbs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat h = 1.0 * (self.collectionView.frame.size.height - self.edgeInsets.top - self.edgeInsets.bottom - self.yMargin * (self.lines - 1)) / self.lines;
    
    h = ZJXX(h);
    
    // 宽度由外界决定, 外界必须实现这个方法
    CGFloat w = [self.delegate zj_waterflowLayout:self collectionView:self.collectionView widthForItemAtIndexPath:indexPath itemHeight:h];
    
    // 拿到最后的高度最小的那一列, 假设第0列最小
    NSInteger indexLine = 0;
    CGFloat minLineW = [self.zj_LinesWidthArray[indexLine] doubleValue];
    
    for (NSInteger i = 1; i < self.zj_LinesWidthArray.count; i++)
    {
        CGFloat lineW = [self.zj_LinesWidthArray[i] doubleValue];
        if(minLineW > lineW)
        {
            minLineW = lineW;
            indexLine = i;
        }
    }
    
    
    CGFloat x = [self xMarginAtIndexPath:indexPath] + minLineW;
    
    if (minLineW == self.edgeInsets.left) {
        x = self.edgeInsets.left;
    }
    
    CGFloat y = self.edgeInsets.top + (self.yMargin + h) * indexLine;
    
    // 赋值frame
    atrbs.frame = CGRectMake(x, y, w, h);
    
    // 覆盖添加完后那一列;的最新宽度
    self.zj_LinesWidthArray[indexLine] = @(CGRectGetMaxX(atrbs.frame));
    
    return atrbs;
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.zj_AtrbsArray;
}


- (CGSize)collectionViewContentSize
{
    __block CGFloat maxColW = [self.zj_LinesWidthArray[0] doubleValue];
    
    [self.zj_LinesWidthArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (maxColW < [obj doubleValue]) {
            maxColW = [obj doubleValue];
        }
        
    }];
    
    return CGSizeMake(maxColW + self.edgeInsets.right, self.collectionView.frame.size.height);
}


- (NSMutableArray *)zj_AtrbsArray
{
    if(!_zj_AtrbsArray)
    {
        _zj_AtrbsArray = [NSMutableArray array];
    }
    return _zj_AtrbsArray;
}

- (NSMutableArray *)zj_LinesWidthArray
{
    if(_zj_LinesWidthArray == nil)
    {
        _zj_LinesWidthArray = [NSMutableArray array];
    }
    return _zj_LinesWidthArray;
}

- (NSInteger)lines
{
    if([self.delegate respondsToSelector:@selector(zj_waterflowLayout:linesInCollectionView:)])
    {
        return [self.delegate zj_waterflowLayout:self linesInCollectionView:self.collectionView];
    }
    else
    {
        return ZJ_Lines;
    }
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

- (CGFloat)yMargin
{
    if([self.delegate respondsToSelector:@selector(zj_waterflowLayout:linesMarginInCollectionView:)])
    {
        return [self.delegate zj_waterflowLayout:self linesMarginInCollectionView:self.collectionView];
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
        return ZJ_EdgeInsets;
    }
}

- (id<ZJHorizontalFlowLayoutDelegate>)delegate
{
    return (id<ZJHorizontalFlowLayoutDelegate>)self.collectionView.dataSource;
}

- (instancetype)initWithDelegate:(id<ZJHorizontalFlowLayoutDelegate>)delegate
{
    if (self = [super init]) {
        
    }
    return self;
}


+ (instancetype)flowLayoutWithDelegate:(id<ZJHorizontalFlowLayoutDelegate>)delegate
{
    return [[self alloc] initWithDelegate:delegate];
}



@end
