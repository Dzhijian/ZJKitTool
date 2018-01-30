//
//  ZJCollectionViewController.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/29.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJBaseCollectionViewController.h"

@interface ZJBaseCollectionViewController ()<ZJVerticalFlowLayoutDelegate>

@end

@implementation ZJBaseCollectionViewController

/**
 *  ZJUIKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJUIKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下,给个Star。😆
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBaseZJCollectionViewController];
}

-(void)setUpBaseZJCollectionViewController{
    self.collectionView.backgroundColor = self.view.backgroundColor;
    // 注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 150;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = kPurpleColor;
    cell.contentView.clipsToBounds = YES;
    
    return cell;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    UIEdgeInsets contentInset = self.collectionView.contentInset;
    contentInset.bottom -= self.collectionView.mj_footer.zj_height;
    self.collectionView.scrollIndicatorInsets = contentInset;
    
    [self.view endEditing:YES];
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:[UICollectionViewFlowLayout new]];
        [self.view addSubview: collectionView];
        
        _collectionView = collectionView;
        
        UICollectionViewLayout *layout = [self zj_collectionViewController:self layoutForCollectionView:collectionView];
        collectionView.collectionViewLayout = layout;
        
        collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        
    }
    return _collectionView;
}

#pragma mark - ZJCollectionViewControllerDataSource
-(UICollectionViewLayout *)zj_collectionViewController:(ZJBaseCollectionViewController *)collectionViewController layoutForCollectionView:(UICollectionView *)collectionView{
    ZJVerticalFlowLayout *layout = [[ZJVerticalFlowLayout alloc]initWithDelegate:self];
    
    return layout;
}



#pragma mark - ZJVerticalFlowLayoutDelegate

- (CGFloat)zj_waterflowLayout:(ZJVerticalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth
{
    return itemWidth * (arc4random() % 4 + 1);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
