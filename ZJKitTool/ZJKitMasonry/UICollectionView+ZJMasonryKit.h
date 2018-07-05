//
//  UICollectionView+ZJMasonryKit.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/17.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ZJKitMasonryTool.h"


@interface UICollectionView (ZJMasonryKit)

/**
 *   1. 创建一个带有流布局的colellection视图，滚动水平或垂直，设置项目大小、委托、数据源、项目间距和行间距等。
 *
 *    当父视图不是nil时，它将会自动添加约束。
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
 *   2. 创建一个带有流布局的colellection视图，滚动水平或垂直。,
 *  设置项目大小、委托、数据源、项目间距和行间距等。.
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
 *  3.  创建一个带有流布局的colellection视图，滚动水平或垂直,
 *  设置项目大小、委托、数据源、项目间距和行间距等.
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
 *   4. 创建一个带有流布局的colellection视图，滚动水平或垂直,
 *  设置项目大小、委托、数据源、项目间距和行间距等。.
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
