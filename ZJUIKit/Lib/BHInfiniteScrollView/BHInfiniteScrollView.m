//
//  BHInfiniteScrollView.m
//  BHInfiniteScrollView
//
//  Created by libohao on 16/3/6.
//  Copyright © 2016年 libohao. All rights reserved.
//
/*
 *********************************************************************************
 *
 * 如果您使用轮播图库的过程中遇到Bug,请联系我,我将会及时修复Bug，为你解答问题。
 * QQ讨论群 :  206177395 (BHInfiniteScrollView讨论群)
 * Email:  375795423@qq.com
 * GitHub: https://github.com/qylibohao
 *
 *
 *********************************************************************************
 */

#import "BHInfiniteScrollView.h"
#import "BHInfiniteScrollViewCell.h"

@interface BHInfiniteScrollView()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    BOOL _firstShow;
    NSInteger _multiple;
    NSInteger _totalPageCount;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, weak) NSTimer *timer;

@property (nonatomic, strong) FXPageControl* pageControl;

@end

@implementation BHInfiniteScrollView

#pragma mark - Init Method

+ (instancetype)infiniteScrollViewWithFrame:(CGRect)frame Delegate:(id<BHInfiniteScrollViewDelegate>)delegate ImagesArray:(NSArray *)images {
    BHInfiniteScrollView *infiniteScrollView = [[self alloc] initWithFrame:frame];
    infiniteScrollView.delegate = delegate;
    infiniteScrollView.imagesArray = [NSMutableArray arrayWithArray:images];
    return infiniteScrollView;
}

+ (instancetype)infiniteScrollViewWithFrame:(CGRect)frame Delegate:(id<BHInfiniteScrollViewDelegate>)delegate
                                ImagesArray:(NSArray *)images PlageHolderImage:(UIImage*)placeHolderImage {
    BHInfiniteScrollView *infiniteScrollView = [BHInfiniteScrollView infiniteScrollViewWithFrame:frame Delegate:delegate ImagesArray:images];
    infiniteScrollView.placeholderImage = placeHolderImage;
    return infiniteScrollView;
}

+ (instancetype)infiniteScrollViewWithFrame:(CGRect)frame Delegate:(id<BHInfiniteScrollViewDelegate>)delegate ImagesArray:(NSArray *)images PlageHolderImage:(UIImage*)placeHolderImage InfiniteLoop:(BOOL)loop {
    BHInfiniteScrollView *infiniteScrollView = [BHInfiniteScrollView infiniteScrollViewWithFrame:frame Delegate:delegate ImagesArray:images PlageHolderImage:placeHolderImage];
    infiniteScrollView.infiniteLoop = loop;
    return infiniteScrollView;
}


#pragma mark - Life Cycle

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
        [self addSubview:self.collectionView];
        [self addSubview:self.titleView];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)awakeFromNib
{
    [self initialize];
    [self addSubview:self.collectionView];
    [self addSubview:self.titleView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.flowLayout.itemSize = self.frame.size;
    
    
    [self setupPageControl];
    [self updateTitleView];
    
    //scroll to middle postion
    [self scrollToMiddlePosition];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self resetTimer];
    }
}

- (void)dealloc {
    [self resetTimer];
    self.collectionView.delegate = nil;
    self.collectionView.dataSource = nil;
    
}

- (void)initialize {
    _firstShow = NO;
    _multiple = 10000;
    _scrollTimeInterval = 3.2;
    _autoScrollToNextPage = YES;
    _scrollDirection = BHInfiniteScrollViewScrollDirectionHorizontal;
    _reverseDirection = NO;
    _pageViewContentMode = UIViewContentModeScaleAspectFill;
    _infiniteLoop = YES;
    _pageControlHidden = NO;
    
    _pageControlAlignmentH =  BHInfiniteScrollViewPageControlAlignHorizontalCenter;
    _pageControlAlignmentV = BHInfiniteScrollViewPageControlAlignVerticalButtom;
    
    if (_scrollDirection == BHInfiniteScrollViewScrollDirectionVertical) {
        _pageControlAlignmentOffset = CGSizeMake(20, 0);
    }else {
        _pageControlAlignmentOffset = CGSizeMake(0, 20);
    }
    
    _selectedDotColor = [UIColor whiteColor];
    _dotSize = 10;
    _dotColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1];
}

- (void)setupPageControl {
    if (_pageControl) {
        [self.pageControl removeFromSuperview];
    }
    
    if (self.imagesArray.count <= 1) {
        return;
    }
    
    FXPageControl *pageControl = [[FXPageControl alloc] init];
    pageControl.numberOfPages = self.imagesArray.count;
    pageControl.selectedDotColor = _selectedDotColor;
    pageControl.dotSize = _dotSize;
    pageControl.dotColor = _dotColor;
    pageControl.backgroundColor = [UIColor clearColor];
    pageControl.userInteractionEnabled = NO;
    pageControl.hidesForSinglePage = YES;
    pageControl.vertical = _scrollDirection == BHInfiniteScrollViewScrollDirectionVertical ? YES : NO;
    pageControl.hidden = _pageControlHidden;
    [self addSubview:pageControl];
    _pageControl = pageControl;

    
    [self updatePageControl];

}

- (void)updatePageControl {
    if (!self.imagesArray.count) {
        return;
    }
    
    CGSize size = [self.pageControl sizeForNumberOfPages:self.imagesArray.count];
    
    if (self.scrollDirection == BHInfiniteScrollViewScrollDirectionHorizontal) {
        size = CGSizeMake(size.width * 1.1, size.height);
    }else {
        size = CGSizeMake(size.width, size.height * 1.1);
    }
    
    CGFloat x = 0.0, y = 0.0;
    
    if (self.pageControlAlignmentH == BHInfiniteScrollViewPageControlAlignHorizontalRight) {

        x = CGRectGetWidth(self.frame) - size.width - self.pageControlAlignmentOffset.width;

    }else if (self.pageControlAlignmentH == BHInfiniteScrollViewPageControlAlignHorizontalCenter) {

        x = CGRectGetWidth(self.frame) * 0.5 - size.width*0.5;

    }else if (self.pageControlAlignmentH == BHInfiniteScrollViewPageControlAlignHorizontalLeft) {

        x = self.pageControlAlignmentOffset.width;

    }

    if (self.pageControlAlignmentV == BHInfiniteScrollViewPageControlAlignVerticalButtom) {

        y = CGRectGetHeight(self.frame) - size.height - self.pageControlAlignmentOffset.height;

    }else if (self.pageControlAlignmentV == BHInfiniteScrollViewPageControlAlignVerticalTop) {

        y = self.pageControlAlignmentOffset.height;

    }else if (self.pageControlAlignmentV == BHInfiniteScrollViewPageControlAlignVerticalCenter) {

        y = CGRectGetHeight(self.frame)*0.5 - size.height*0.5;

    }

    self.pageControl.numberOfPages = self.imagesArray.count;
    self.pageControl.frame = CGRectMake(x, y, size.width, size.height);
    self.pageControl.currentPage = 0;
}

- (void)updateTitleView {
    if (self.currentPageIndex < self.titlesArray.count) {
        self.titleView.titleText = self.titlesArray[self.currentPageIndex];
    }
    
}

#pragma mark - setter

- (void)setImagesArray:(NSArray *)imageUrlsArray {
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    _imagesArray = imageUrlsArray;
    if (self.infiniteLoop) {
        _totalPageCount = imageUrlsArray.count * _multiple * 2;
    }else {
        _totalPageCount = imageUrlsArray.count;
    }
    
    if (imageUrlsArray.count > 1) {
        self.collectionView.scrollEnabled = YES;
        
        [self setAutoScrollToNextPage:_autoScrollToNextPage];
    }else {
        self.collectionView.scrollEnabled = NO;
    }
    
    [self.collectionView reloadData];
    [self scrollToMiddlePosition];
    [self setupPageControl];
}

- (void)setScrollDirection:(BHInfiniteScrollViewScrollDirection)scrollDirection {
    _scrollDirection = scrollDirection;
    _flowLayout.scrollDirection = scrollDirection == BHInfiniteScrollViewScrollDirectionHorizontal ? UICollectionViewScrollDirectionHorizontal : UICollectionViewScrollDirectionVertical;;
}

- (void)setScrollTimeInterval:(NSTimeInterval)scrollTimeInterval {
    _scrollTimeInterval = scrollTimeInterval;
    
    [self resetTimer];
    
    if (_autoScrollToNextPage) {
        [self setupTimer];
    }
    
}

- (void)setAutoScrollToNextPage:(BOOL)autoScrollToNextPage {
    _autoScrollToNextPage = autoScrollToNextPage;
    [self resetTimer];
    
    if (_autoScrollToNextPage) {
        [self setupTimer];
    }
}

- (void)setReverseDirection:(BOOL)reverseDirection {
    _reverseDirection = reverseDirection;
    [self resetTimer];
    
    if (_autoScrollToNextPage) {
        [self setupTimer];
    }
}

- (void)setInfiniteLoop:(BOOL)infiniteLoop {
    _infiniteLoop = infiniteLoop;
    
    if (self.infiniteLoop) {
        _totalPageCount = self.imagesArray.count * _multiple * 2;
    }else {
        _totalPageCount = self.imagesArray.count;
    }
}

#pragma pageControl setting

- (void)setDotImage:(UIImage *)dotImage
{
    if (_dotImage != dotImage)
    {
        _dotImage = dotImage;
        self.pageControl.dotImage = dotImage;
    }
}

- (void)setDotShape:(CGPathRef)dotShape
{
    if (_dotShape != dotShape)
    {
        _dotShape = dotShape;
        self.pageControl.dotShape = dotShape;
    }
}

- (void)setDotSize:(CGFloat)dotSize
{
    if (ABS(_dotSize - dotSize) > 0.001)
    {
        _dotSize = dotSize;
        self.pageControl.dotSize = dotSize;
    }
}

- (void)setDotColor:(UIColor *)dotColor
{
    if (_dotColor != dotColor)
    {
        _dotColor = dotColor;
        self.pageControl.dotColor = dotColor;
    }
}

- (void)setDotShadowColor:(UIColor *)dotColor
{
    if (_dotShadowColor != dotColor)
    {
        _dotShadowColor = dotColor;
        self.pageControl.dotShadowColor = dotColor;
    }
}

- (void)setDotShadowBlur:(CGFloat)dotShadowBlur
{
    if (ABS(_dotShadowBlur - dotShadowBlur) > 0.001)
    {
        _dotShadowBlur = dotShadowBlur;
        self.pageControl.dotShadowBlur = dotShadowBlur;
    }
}

- (void)setDotShadowOffset:(CGSize)dotShadowOffset
{
    if (!CGSizeEqualToSize(_dotShadowOffset, dotShadowOffset))
    {
        _dotShadowOffset = dotShadowOffset;
        self.pageControl.dotShadowOffset = dotShadowOffset;
    }
}

- (void)setSelectedDotImage:(UIImage *)dotImage
{
    if (_selectedDotImage != dotImage)
    {
        _selectedDotImage = dotImage;
        self.pageControl.selectedDotImage = dotImage;
    }
}

- (void)setSelectedDotColor:(UIColor *)dotColor
{
    if (_selectedDotColor != dotColor)
    {
        _selectedDotColor = dotColor;
        self.pageControl.selectedDotColor = dotColor;
    }
}

- (void)setSelectedDotShape:(CGPathRef)dotShape
{
    if (_selectedDotShape != dotShape)
    {
        _selectedDotShape = dotShape;
        self.pageControl.selectedDotShape = dotShape;
    }
}

- (void)setSelectedDotSize:(CGFloat)dotSize
{
    if (ABS(_selectedDotSize - dotSize) > 0.001)
    {
        _selectedDotSize = dotSize;
        self.pageControl.selectedDotSize = dotSize;
    }
}

- (void)setSelectedDotShadowColor:(UIColor *)dotColor
{
    if (_selectedDotShadowColor != dotColor)
    {
        _selectedDotShadowColor = dotColor;
        self.pageControl.selectedDotShadowColor = dotColor;
    }
}

- (void)setSelectedDotShadowBlur:(CGFloat)dotShadowBlur
{
    if (ABS(_selectedDotShadowBlur - dotShadowBlur) > 0.001)
    {
        _selectedDotShadowBlur = dotShadowBlur;
        self.pageControl.selectedDotShadowBlur = dotShadowBlur;
    }
}

- (void)setSelectedDotShadowOffset:(CGSize)dotShadowOffset
{
    if (!CGSizeEqualToSize(_selectedDotShadowOffset, dotShadowOffset))
    {
        _selectedDotShadowOffset = dotShadowOffset;
        self.pageControl.selectedDotShadowOffset = dotShadowOffset;
    }
}

- (void)setDotSpacing:(CGFloat)dotSpacing {
    _dotSpacing = dotSpacing;
    self.pageControl.dotSpacing = dotSpacing;
}

- (void)setPageControlHidden:(BOOL)pageControlHidden {
    _pageControlHidden = pageControlHidden;
    self.pageControl.hidden = _pageControlHidden;
}


#pragma mark - timer func

- (void)setupTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.scrollTimeInterval target:self selector:@selector(scrollToNextPage) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)resetTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollToNextPage {
    if(self.imagesArray.count == 0 ) return;

    dispatch_async(dispatch_get_main_queue(), ^{
        
        BOOL hasScrollAnimation = YES;
    
        if (self.scrollDirection == BHInfiniteScrollViewScrollDirectionHorizontal) {
            CGFloat nextPageX ;
            if (self.reverseDirection) {
                nextPageX = self.collectionView.contentOffset.x - _flowLayout.itemSize.width;
                if (self.infiniteLoop) {
                    if (nextPageX < 0) {
                        nextPageX = _flowLayout.itemSize.width * self.imagesArray.count * _multiple;
                        hasScrollAnimation = NO;
                    }
                }
                
            }else {
                nextPageX = self.collectionView.contentOffset.x + _flowLayout.itemSize.width;
                if (self.infiniteLoop) {
                    if (nextPageX > _flowLayout.itemSize.width * self.imagesArray.count * _multiple * 2) {
                        nextPageX = _flowLayout.itemSize.width * self.imagesArray.count * _multiple;
                        hasScrollAnimation = NO;
                    }
                }
                
            }
            
            NSIndexPath* indexPath = [self.collectionView indexPathForItemAtPoint:CGPointMake(nextPageX,_flowLayout.itemSize.height * 0.5)];
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:hasScrollAnimation];
            
        }else {
            CGFloat nextPageY ;
            if (self.reverseDirection) {
                nextPageY = self.collectionView.contentOffset.y - _flowLayout.itemSize.height;
                if (self.infiniteLoop) {
                    if (nextPageY < 0) {
                        nextPageY = _flowLayout.itemSize.height * self.imagesArray.count * _multiple;
                        hasScrollAnimation = NO;
                    }
                }
                
            }else {
                nextPageY = self.collectionView.contentOffset.y + _flowLayout.itemSize.height;
                if (self.infiniteLoop) {
                    if (nextPageY > _flowLayout.itemSize.height * self.imagesArray.count * _multiple * 2) {
                        nextPageY = _flowLayout.itemSize.height * self.imagesArray.count * _multiple;
                        hasScrollAnimation = NO;
                    }
                }
                
            }
            
            NSIndexPath* indexPath = [self.collectionView indexPathForItemAtPoint:CGPointMake(_flowLayout.itemSize.width * 0.5, nextPageY)];
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:hasScrollAnimation];
        }
    });
}

- (void)scrollToPageAtIndex:(NSUInteger)pageIndex Animation:(BOOL)animation {
    if(self.imagesArray.count == 0 ) return;
    
    if (pageIndex < self.imagesArray.count) {
        NSInteger middleNum = 0;
        if (self.infiniteLoop) {
            middleNum =  _multiple * self.imagesArray.count;
        }
        
        
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:middleNum + pageIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:animation];
        
        self.pageControl.currentPage = pageIndex;
        
        if (pageIndex < self.titlesArray.count) {
            self.titleView.titleText = self.titlesArray[pageIndex];
        }
        
        if ([self.delegate respondsToSelector:@selector(infiniteScrollView:didScrollToIndex:)]) {
            [self.delegate infiniteScrollView:self didScrollToIndex:pageIndex];
        }
        
    }
}

- (void)startAutoScrollPage {
    if (!self.timer) {
        [self setupTimer];
    }
}

- (void)stopAutoScrollPage {
    if (self.timer) {
        [self resetTimer];
    }
}

#pragma mark - Property

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = self.scrollDirection == BHInfiniteScrollViewScrollDirectionHorizontal ? UICollectionViewScrollDirectionHorizontal : UICollectionViewScrollDirectionVertical;
        flowLayout.itemSize = self.frame.size;
        _flowLayout = flowLayout;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.pagingEnabled = YES;
        _collectionView.scrollsToTop = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[BHInfiniteScrollViewCell class] forCellWithReuseIdentifier:BHInfiniteScrollViewCellIdentifier];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
    }
    return _collectionView;
}

- (BHInfiniteScrollViewTitleView *)titleView {
    if (!_titleView) {
        _titleView = [[BHInfiniteScrollViewTitleView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame) - 20, CGRectGetWidth(self.frame), 20)];
    }
    return _titleView;
}

- (NSInteger)currentPageIndex {
    if (!self.imagesArray.count) return 0;

    NSInteger page;
    if (_scrollDirection == BHInfiniteScrollViewScrollDirectionHorizontal) {
        page = self.collectionView.contentOffset.x / _flowLayout.itemSize.width;
    }else {
        page = self.collectionView.contentOffset.y / _flowLayout.itemSize.height;
    }
    
    NSInteger index = page % self.imagesArray.count;
    
    return index;
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _totalPageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BHInfiniteScrollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BHInfiniteScrollViewCellIdentifier forIndexPath:indexPath];
    cell.contentMode = self.pageViewContentMode;
    if (self.imagesArray.count) {
        NSInteger index = indexPath.row % self.imagesArray.count;
        NSObject* object = [self.imagesArray objectAtIndex:index];
        if ([object isKindOfClass:[NSString class]]) {
            if ([(NSString*)object hasPrefix:@"http"]) {
                [cell setupWithUrlString:(NSString*)object placeholderImage:self.placeholderImage];
            }else {
                [cell setupWithImageName:(NSString*)object placeholderImage:self.placeholderImage];
            }
            
        }else if ([object isKindOfClass:[UIImage class]]) {
            [cell setupWithImage:(UIImage*)object placeholderImage:self.placeholderImage];
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(infiniteScrollView:didSelectItemAtIndex:)]) {
        [self.delegate infiniteScrollView:self didSelectItemAtIndex:self.currentPageIndex];
    }
    
    if (self.scrollViewDidSelectBlock) {
        self.scrollViewDidSelectBlock(self,self.currentPageIndex);
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!_firstShow) {
        [self scrollToMiddlePosition];
        _firstShow = YES;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.autoScrollToNextPage) {
        [self resetTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.autoScrollToNextPage) {
        [self setupTimer];
    }
    
    self.pageControl.currentPage = self.currentPageIndex;

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.currentPage = self.currentPageIndex;
    
    if (self.currentPageIndex < self.titlesArray.count) {
        self.titleView.titleText = self.titlesArray[self.currentPageIndex];
    }
    
    if ([self.delegate respondsToSelector:@selector(infiniteScrollView:didScrollToIndex:)]) {
        [self.delegate infiniteScrollView:self didScrollToIndex:self.currentPageIndex];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (!self.imagesArray.count) return;

    self.pageControl.currentPage = self.currentPageIndex;
    //NSLog(@"%ld",index);
    
    if ([self.delegate respondsToSelector:@selector(infiniteScrollView:didScrollToIndex:)]) {
        [self.delegate infiniteScrollView:self didScrollToIndex:self.currentPageIndex];
    }
    
    if (self.currentPageIndex < self.titlesArray.count) {
        self.titleView.titleText = self.titlesArray[self.currentPageIndex];
    }
    
}


- (void)scrollToMiddlePosition {
    if (self.imagesArray.count && self.infiniteLoop) {
        if (self.scrollDirection == BHInfiniteScrollViewScrollDirectionHorizontal) {
            CGFloat middlePageX = _flowLayout.itemSize.width * self.imagesArray.count * _multiple;
            [self.collectionView scrollRectToVisible:CGRectMake(middlePageX,0, _flowLayout.itemSize.width, _flowLayout.itemSize.height) animated:NO];
        }else {
            CGFloat middlePageY = _flowLayout.itemSize.height * self.imagesArray.count * _multiple;
            [self.collectionView scrollRectToVisible:CGRectMake(0, middlePageY, _flowLayout.itemSize.width, _flowLayout.itemSize.height) animated:NO];
        }
        
    }
}

@end
