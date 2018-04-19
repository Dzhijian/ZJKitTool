//
//  ZJElementsCollectionViewController.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/30.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJElementsCollectionViewController.h"
#import "ZJCollectionViewCell.h"
#import "ZJImageModel.h"

@interface ZJElementsCollectionViewController ()<ZJElementsFlowLayoutDelegate>

@property (nonatomic, strong) NSMutableArray<NSValue *> *elementsHight;
@property(nonatomic ,strong) NSMutableArray             *dataArray;

@end

@implementation ZJElementsCollectionViewController

/**
 *  ZJUIKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJUIKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下,给个Star。😆
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CollectionView 普通首页布局";
    [self.collectionView registerClass:[ZJCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ZJCollectionViewCell class])];
    
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        ZJImageModel *model = [[ZJImageModel alloc]init];
        _dataArray = (NSMutableArray *)model.imageUrlArr;
    }
    return _dataArray;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZJCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZJCollectionViewCell class]) forIndexPath:indexPath];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:self.dataArray[indexPath.item]] placeholderImage:kImageName(@"003")];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.item);
}


#pragma mark - ZJElementsFlowLayoutDelegate
// cell的大小
-(CGSize)zj_waterflowLayout:(ZJElementsFlowLayout *)waterFlowLayout collectionView:(UICollectionView *)collectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.elementsHight[indexPath.item].CGSizeValue;
}

/**
 *  列间距, 默认10
 */
-(CGFloat)zj_waterflowLayout:(ZJElementsFlowLayout *)waterflowLayout
              collectionView:(UICollectionView *)collectionView
columnsMarginForItemAtIndexPath:(NSIndexPath *)indexPath{
    return 10;
}

/**
 *  行间距, 默认10
 */
- (CGFloat)zj_waterflowLayout:(ZJElementsFlowLayout *)waterflowLayout
               collectionView:(UICollectionView *)collectionView
linesMarginForItemAtIndexPath:(NSIndexPath *)indexPath{
    return 10;
}
/**
 *  距离collectionView四周的间距, 默认{10, 10, 10, 10}
 */
-(UIEdgeInsets)zj_waterflowLayout:(ZJElementsFlowLayout *)waterflowLayout edgeInsetsInCollectionView:(UICollectionView *)collectionView{
    return UIEdgeInsetsMake(1, 10, 10, 10);
    
}

#pragma mark - LMJCollectionViewControllerDataSource
-(UICollectionViewLayout *)zj_collectionViewController:(ZJBaseCollectionViewController *)collectionViewController layoutForCollectionView:(UICollectionView *)collectionView{
    ZJElementsFlowLayout *elementFlowLayout = [[ZJElementsFlowLayout alloc]initWithDelegate:self];
    
    return elementFlowLayout;
}

- (NSMutableArray<NSValue *> *)elementsHight
{
    if(_elementsHight == nil)
    {
        _elementsHight = [NSMutableArray array];
        
        for (NSInteger i = 0; i < self.dataArray.count; i++) {
            
            if (i == 0) {
                
                [_elementsHight addObject:[NSValue valueWithCGSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 200)]];
                
            }else if (i == 1)
            {
                
                [_elementsHight addObject:[NSValue valueWithCGSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, 100)]];
                
            }else if (i == 2)
            {
                
                [_elementsHight addObject:[NSValue valueWithCGSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, 80)]];
                
            }else if (i ==3)
            {
                
                [_elementsHight addObject:[NSValue valueWithCGSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 10, 300)]];
            }else
            {
                
                [_elementsHight addObject:[NSValue valueWithCGSize:CGSizeMake(([UIScreen mainScreen].bounds.size.width - 30) * 0.5, ([UIScreen mainScreen].bounds.size.width - 30) * 0.5)]];
            }
            
            
            
        }
    }
    return _elementsHight;
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
