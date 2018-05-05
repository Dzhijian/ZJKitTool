//
//  ZJVerticalWaterFallViewController.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/30.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJVerticalWaterFallViewController.h"
#import "ZJCollectionViewCell.h"
#import "ZJImageModel.h"

@interface ZJVerticalWaterFallViewController ()<ZJVerticalFlowLayoutDelegate>

@property(nonatomic ,strong) NSArray *dataArray;

@end

@implementation ZJVerticalWaterFallViewController

/**
 *  ZJUIKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJUIKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下,给个Star。😆
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    [self zj_setNavTitle:@"垂直瀑布流"];
    self.collectionView.backgroundColor = k16RGBColor(0xCCCCCC);
    [self.collectionView registerClass:[ZJCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ZJCollectionViewCell class])];
    
    ZJImageModel *model = [[ZJImageModel alloc]init];
    self.dataArray = model.imageUrlArr;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZJCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZJCollectionViewCell class]) forIndexPath:indexPath];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:self.dataArray[indexPath.item]] placeholderImage:kImageName(@"001")];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选中第%ld个",indexPath.item);
}

#pragma mark - ZJVerticalFlowLayoutDelegate

/**
 * 需要显示的列数, 默认3
 */
- (NSInteger)zj_waterflowLayout:(ZJVerticalFlowLayout *)waterflowLayout columnsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}



/**
 * 设置cell的高度

 @param indexPath 索引
 @param itemWidth 宽度
 */
-(CGFloat)zj_waterflowLayout:(ZJVerticalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth{
    return (arc4random() % 3 + 1) * itemWidth;
}

/**
 * 列间距
 */
-(CGFloat)zj_waterflowLayout:(ZJVerticalFlowLayout *)waterflowLayout columnsMarginInCollectionView:(UICollectionView *)collectionView{
    return 10;
}


/**
 * 行间距, 默认10
 */
- (CGFloat)zj_waterflowLayout:(ZJVerticalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView linesMarginForItemAtIndexPath:(NSIndexPath *)indexPath{
    return 10;
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
