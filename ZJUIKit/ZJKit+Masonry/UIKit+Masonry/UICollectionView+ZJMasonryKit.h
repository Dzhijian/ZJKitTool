//
//  UICollectionView+ZJMasonryKit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/17.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//



@interface UICollectionView (ZJMasonryKit)

/**
 *    Create a colellection view with flow layout, scroll horizontal or vertical,
 *  set item size, delegate, data source, item spacing and line spacing and so on.
 *
 *  When super view is not nil, it will be automatically added constraints with edges of
 *  super view.
 *
 *    @param delegate                                Delegate and data source.
 *    @param isHorizontal                            UICollectionViewScrollDirection
 *    @param superView                                The super view of collection view.
 *
 *    @return The instance of UICollectionView.
 */
+ (instancetype)zj_collectionViewWithDelegate:(id)delegate
                                    horizontal:(BOOL)isHorizontal
                                     superView:(UIView *)superView;

/**
 *
 *    Create a colellection view with flow layout, scroll horizontal or vertical,
 *  set item size, delegate, data source, item spacing and line spacing and so on.
 *
 *  When super view is not nil, it will be automatically added constraints with edges of
 *  super view.
 *
 *    @param delegate                                Delegate and data source.
 *    @param isHorizontal                            UICollectionViewScrollDirection
 *    @param itemSize                                The size of collection view cell.
 *    @param superView                                The super view of collection view.
 *
 *    @return The instance of UICollectionView.
 */
+ (instancetype)zj_collectionViewWithDelegate:(id)delegate
                                    horizontal:(BOOL)isHorizontal
                                          size:(CGSize)itemSize
                                     superView:(UIView *)superView;

/**
 *
 *    Create a colellection view with flow layout, scroll horizontal or vertical,
 *  set item size, delegate, data source, item spacing and line spacing and so on.
 *
 *  When super view is not nil, it will be automatically added constraints with edges of
 *  super view.
 *
 *    @param delegate                                Delegate and data source.
 *    @param isHorizontal                            UICollectionViewScrollDirection
 *    @param itemSize                                The size of collection view cell.
 *    @param minimumInteritemSpacing    The minunum interitem spacing.
 *    @param minimumLineSpacing            The mininum line spacing.
 *    @param superView                                The super view of collection view.
 *
 *    @return The instance of UICollectionView.
 */
+ (instancetype)zj_collectionViewWithDelegate:(id)delegate
                                    horizontal:(BOOL)isHorizontal
                                          size:(CGSize)itemSize
                                   itemSpacing:(CGFloat)minimumInteritemSpacing
                                   lineSpacing:(CGFloat)minimumLineSpacing
                                     superView:(UIView *)superView;

/**
 *
 *    Create a colellection view with flow layout, scroll horizontal or vertical,
 *  set item size, delegate, data source, item spacing and line spacing and so on.
 *
 *    @param delegate                                Delegate and data source.
 *    @param isHorizontal                            UICollectionViewScrollDirection
 *    @param itemSize                                The size of collection view cell.
 *    @param minimumInteritemSpacing    The minunum interitem spacing.
 *    @param minimumLineSpacing            The mininum line spacing.
 *    @param superView                                The super view of collection view.
 *    @param constraints                            The constraints added to the collection view.
 *
 *    @return The instance of UICollectionView.
 */
+ (instancetype)zj_collectionViewWithDelegate:(id)delegate
                                    horizontal:(BOOL)isHorizontal
                                          size:(CGSize)itemSize
                                   itemSpacing:(CGFloat)minimumInteritemSpacing
                                   lineSpacing:(CGFloat)minimumLineSpacing
                                     superView:(UIView *)superView
                                   constraints:(ZJConstrainMaker)constraints;

@end
