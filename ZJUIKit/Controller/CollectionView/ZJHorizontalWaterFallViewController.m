//
//  ZJHorizontalWaterFallViewController.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/30.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJHorizontalWaterFallViewController.h"
#import "ZJCollectionViewCell.h"
#import "ZJImageModel.h"

@interface ZJHorizontalWaterFallViewController ()<ZJHorizontalFlowLayoutDelegate>

@property(nonatomic ,strong) NSArray *dataArray;

@end
/**
 *  ZJUIKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJUIKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下,给个Star。😆
 */

@implementation ZJHorizontalWaterFallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self zj_setNavTitle:@"水平瀑布流"];
    
    self.collectionView.contentInset = UIEdgeInsetsZero;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    // 注册cell
    [self.collectionView registerClass:[ZJCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ZJCollectionViewCell class])];
    
    // 加载数据
    [self loadFlowData];
}

-(void)loadFlowData{
    
    [self.view zj_showText:@"加载中"];
    ZJImageModel *model = [[ZJImageModel alloc]init];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view zj_hideBusyHUD];
        
        self.dataArray = model.imageUrlArr;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    });
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZJCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZJCollectionViewCell class]) forIndexPath:indexPath];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:self.dataArray[indexPath.item]] placeholderImage:kImageName(@"002")];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选中了第%ld个,",indexPath.item);
}

// 指定布局样式
-(UICollectionViewLayout *)zj_collectionViewController:(ZJBaseCollectionViewController *)collectionViewController layoutForCollectionView:(UICollectionView *)collectionView{
    // 水平布局
    ZJHorizontalFlowLayout *layout = [[ZJHorizontalFlowLayout alloc]initWithDelegate:self];
    return layout;
}




#pragma mark - LMJHorizontalFlowLayoutDelegate
// cell 的宽度
- (CGFloat)zj_waterflowLayout:(ZJHorizontalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView widthForItemAtIndexPath:(NSIndexPath *)indexPath itemHeight:(CGFloat)itemHeight
{
    
    return (arc4random() % 4 + 1) * itemHeight;
}

/**
 *  需要显示的行数, 默认3
 */
- (NSInteger)zj_waterflowLayout:(ZJHorizontalFlowLayout *)waterflowLayout linesInCollectionView:(UICollectionView *)collectionView{
    return 4;
}
/**
 *  列间距, 默认10
 */
- (CGFloat)zj_waterflowLayout:(ZJHorizontalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView columnsMarginForItemAtIndexPath:(NSIndexPath *)indexPath{
    return 10;
}
/**
 *  行间距, 默认10
 */
- (CGFloat)zj_waterflowLayout:(ZJHorizontalFlowLayout *)waterflowLayout linesMarginInCollectionView:(UICollectionView *)collectionView{
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
