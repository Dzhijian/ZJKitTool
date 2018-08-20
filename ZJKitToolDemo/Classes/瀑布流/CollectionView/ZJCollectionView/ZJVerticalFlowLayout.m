//
//  ZJVerticalFlowLayout.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/30.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJVerticalFlowLayout.h"
#define ZJXX(x) floorf(x)
#define ZJXS(s) ceilf(s)

static const NSInteger ZJ_Columns_ = 3;
static const CGFloat ZJ_XMargin_ = 10;
static const CGFloat ZJ_YMargin_ = 10;
static const UIEdgeInsets ZJ_EdgeInsets = {20, 10, 10, 10};

/**
 *  ZJKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下,给个Star。😆
 */

@interface ZJVerticalFlowLayout()
/** 所有的cell的attrbts */
@property (nonatomic, strong) NSMutableArray *zj_AtrbsArray;

/** 每一列的最后的高度 */
@property (nonatomic, strong) NSMutableArray *zj_ColumnsHeightArray;

- (NSInteger)columns;

- (CGFloat)xMargin;

- (CGFloat)yMarginAtIndexPath:(NSIndexPath *)indexPath;

- (UIEdgeInsets)edgeInsets;
    
@end

@implementation ZJVerticalFlowLayout

/**
 *  刷新布局的时候回重新调用
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    //如果重新刷新就需要移除之前存储的高度
    [self.zj_ColumnsHeightArray removeAllObjects];
    
    //复赋值以顶部的高度, 并且根据列数
    for (NSInteger i = 0; i < self.columns; i++) {
        
        [self.zj_ColumnsHeightArray addObject:@(self.edgeInsets.top)];
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
    
    CGFloat w = 1.0 * (self.collectionView.frame.size.width - self.edgeInsets.left - self.edgeInsets.right - self.xMargin * (self.columns - 1)) / self.columns;
    
    w = ZJXX(w);
    
    // 高度由外界决定, 外界必须实现这个方法
    CGFloat h = [self.delegate zj_waterflowLayout:self collectionView:self.collectionView heightForItemAtIndexPath:indexPath itemWidth:w];
    
    // 拿到最后的高度最小的那一列, 假设第0列最小
    NSInteger indexCol = 0;
    CGFloat minColH = [self.zj_ColumnsHeightArray[indexCol] doubleValue];
    
    for (NSInteger i = 1; i < self.zj_ColumnsHeightArray.count; i++)
    {
        CGFloat colH = [self.zj_ColumnsHeightArray[i] doubleValue];
        if(minColH > colH)
        {
            minColH = colH;
            indexCol = i;
        }
    }
    
    
    CGFloat x = self.edgeInsets.left + (self.xMargin + w) * indexCol;
    
    CGFloat y = minColH + [self yMarginAtIndexPath:indexPath];
    
    // 是第一行
    if (minColH == self.edgeInsets.top) {
        
        y = self.edgeInsets.top;
    }
    
    // 赋值frame
    atrbs.frame = CGRectMake(x, y, w, h);
    
    // 覆盖添加完后那一列;的最新高度
    self.zj_ColumnsHeightArray[indexCol] = @(CGRectGetMaxY(atrbs.frame));
    
    return atrbs;
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.zj_AtrbsArray;
}

-(CGSize)collectionViewContentSize{
    
    CGFloat maxColH = [self.zj_ColumnsHeightArray.firstObject doubleValue];
    
    for (NSInteger i = 1; i<self.zj_ColumnsHeightArray.count; i++) {
        CGFloat colH = [self.zj_ColumnsHeightArray[i] doubleValue];
        if (maxColH<colH) {
            maxColH = colH;
        }
    }
    return CGSizeMake(self.collectionView.frame.size.width, maxColH + self.edgeInsets.bottom);
}


-(NSInteger)columns{
    if ([self.delegate respondsToSelector:@selector(zj_waterflowLayout:columnsInCollectionView:)]) {
        return [self.delegate zj_waterflowLayout:self columnsInCollectionView:self.collectionView];
    }else{
        return ZJ_Columns_;
    }
}

-(CGFloat)xMargin{
    if ([self.delegate respondsToSelector:@selector(zj_waterflowLayout:columnsMarginInCollectionView:)]) {
        return [self.delegate zj_waterflowLayout:self columnsMarginInCollectionView:self.collectionView];
    }else{
        return ZJ_XMargin_;
    }
}

-(CGFloat)yMarginAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(zj_waterflowLayout:collectionView:linesMarginForItemAtIndexPath:)]) {
        return [self.delegate zj_waterflowLayout:self collectionView:self.collectionView linesMarginForItemAtIndexPath:indexPath];
    }else{
        return ZJ_YMargin_;
    }
}

-(id<ZJVerticalFlowLayoutDelegate>)delegate{
    
    return (id<ZJVerticalFlowLayoutDelegate>)self.collectionView.dataSource;

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


-(instancetype)initWithDelegate:(id<ZJVerticalFlowLayoutDelegate>)delegate{
    if (self = [super init]) {
        
    }
    return self;
}

+(instancetype)flowLayoutWithDelegate:(id<ZJVerticalFlowLayoutDelegate>)delegate{
    return [[self alloc]initWithDelegate:delegate];
}


/**
*  每一列的最后的高度数组
*/
-(NSMutableArray *)zj_ColumnsHeightArray{
    if (!_zj_ColumnsHeightArray) {
        _zj_ColumnsHeightArray = [NSMutableArray array];
    }
    return _zj_ColumnsHeightArray;
}

/**
  所有的cell的attrbts
*/
-(NSMutableArray *)zj_AtrbsArray{
    if (!_zj_AtrbsArray) {
        _zj_AtrbsArray = [NSMutableArray array];
    }
    return _zj_AtrbsArray;
}



@end
