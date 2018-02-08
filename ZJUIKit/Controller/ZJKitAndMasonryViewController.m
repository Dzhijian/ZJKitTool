//
//  ZJKitAndMasonryViewController.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/24.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//
/**
 *  ZJUIKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJUIKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下。😆
 */
#import "ZJKitAndMasonryViewController.h"

#import "ZJChooseViewController.h"
#import "ZJUIMasonsyKit.h"
#import "ZJCommitViewController.h"
@interface ZJKitAndMasonryViewController ()

@property(nonatomic ,strong) UIButton           *btn;
@property(nonatomic ,strong) UIButton           *button;
@property(nonatomic ,strong) UILabel            *label;

// 测试字段
@property(nonatomic ,assign) NSInteger          testNum;
// 倒计时
@property(nonatomic ,strong) ZJTimeCountDown    *timeDown;
@property(nonatomic ,strong) UILabel            *timeLabel;
// 字体大小适配Label
@property(nonatomic ,strong) UILabel            *adaptLabel;
@property(nonatomic ,strong) UIImageView        *imgView;

@end

@implementation ZJKitAndMasonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.testNum = 1;
    [self setUpAllView];
}

-(void)setUpAllView{
    kWeakObject(self);
    // 设置返回按钮
    [self zj_setNavLeftImage:kImageName(@"new_goback") block:^(id sender) {
        [weakObject.navigationController popViewControllerAnimated:YES];
    }];
    // 设置标题
    [self zj_setNavTitle:@"ZJUIKit+Masonry"];
    // 倒计时test
    [self timeCountDownTest];
    // 快速创建控件 + marsonry 布局
    [self zj_UIKitAndMasonry];
    
   
    [self svaimgPhotiTest];
}

#pragma mark - 倒计时Test
-(void)timeCountDownTest{
    
    self.timeLabel = [UILabel zj_labelWithFontSize:14 lines:1 text:nil textColor:kOrangeColor superView:self.view constraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(30);
    }];
    
    // 单个倒计时最好使用 alloc init 创建，不要使用单例，避免退出页面时，倒计时没有及时销毁
    self.timeDown = [[ZJTimeCountDown alloc]init];
    kWeakObject(self);
    [_timeDown zj_timeCountDownWithSecondTime:300 completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        weakObject.timeLabel.text = [NSString stringWithFormat:@"还剩%ld天%ld小时%ld分钟%ld秒开始",day,hour,minute,second];
    }];
    
}


#pragma mark - 快速创建控件 + marsonry 布局
-(void)zj_UIKitAndMasonry{
    
    // 筛选视图
    UIButton *chooseBtn = [UIButton zj_buttonWithFrame:CGRectMake(20, 20, 80, 40) title:@"筛选" titleColor:[UIColor whiteColor] imageName:nil backColor:[UIColor orangeColor] fontSize:15 cornerRadius:4 traget:self action:@selector(goToChooseViewController)];
    [self.view addSubview:chooseBtn];
    
    kWeakObject(self);
    
    // 评论列表
    UIButton *comBtn = [UIButton  zj_buttonWithTitle:@"评论列表" titleColor:kWhiteColor backColor:kOrangeColor fontSize:15 isBold:NO cornerRadius:4 supView:self.view constraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(chooseBtn.mas_centerY);
        make.left.equalTo(chooseBtn.mas_right).offset(30);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
    } touchUp:^(id sender) {
        NSLog(@"123456");
        ZJCommitViewController *commmit = [[ZJCommitViewController alloc]init];
        [weakObject.navigationController pushViewController:commmit animated:YES];
    }];
    
    // alertView
    UIButton *alertBtn = [UIButton  zj_buttonWithTitle:@"AlertView" titleColor:kWhiteColor backColor:kOrangeColor fontSize:16 isBold:NO cornerRadius:3 supView:self.view constraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(comBtn.mas_centerY);
        make.left.equalTo(comBtn.mas_right).offset(30);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
    } touchUp:^(id sender) {

        [weakObject alertTest];
    }];
    
    
    
    
      [UILabel zj_labelWithFontSize:14 lines:1 text:@"哈哈哈哈哈" textColor:kRedColor superView:self.view constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(alertBtn.mas_bottom).offset(10);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    
    
    
    

    UIView *redView = [UIView zj_viewWithBackColor:kRedColor supView:self.view constraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(-90);
        make.width.height.mas_equalTo(80);
    } onTap:^(UITapGestureRecognizer *gesture) {
        // 显示加载视图
        [weakObject.view zj_showBusyHUD];
    }];
    
    self.adaptLabel = [UILabel  zj_labelWithFont:AdaptedFontSize(15) lines:0 text:@"湾桃园一炼油厂突然发生爆炸，顿时火光烈焰冲天，方圆5公里内住户都被巨大爆炸声响震醒。据《中时电子报》消息，爆炸位置发生在“中油”公司在桃园市龟山区民生北路的炼油厂，桃园市消防局已接获大量报案电话，先遣芦竹消防分队入厂查看，发现起火点约在3、4层楼高位置，火势猛烈有蔓延之势，初步了解并无伤亡。" textColor:kLightGrayColor superView:self.view constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.equalTo(redView.mas_left).offset(-10);
        make.top.equalTo(_timeLabel.mas_bottom).offset(10);
    }];
    
    
    
}



-(void)textViewTest{
    // 创建UITextView 并设置 placeText
    [UITextView zj_textViewWithFontSize:16 textColor:[UIColor orangeColor] borderColor:k16RGBColor(0xCCCCCC) borderWidth:0.5 cornerRadiu:4 placeColor:k16RGBColor(0xBBBBBB) placeText:@"请在这里输入..." superView:self.view constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.equalTo(_adaptLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(140);
    }];
}


-(void)goToChooseViewController{
    
    ZJChooseViewController *choose = [[ZJChooseViewController alloc]init];
    [self.navigationController pushViewController:choose animated:YES];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}



-(void)imageCorner{
    UIImageView *cornerView =[[UIImageView alloc]initWithFrame:CGRectMake(100, 300, 100, 100)];
    cornerView.backgroundColor= [UIColor redColor];
    cornerView.image = [[UIImage imageNamed:@"001"] zj_imageAddCornerWithRadius:50 andSize:CGSizeMake(100, 100)];
    [self.view addSubview:cornerView];
}

-(void)svaimgPhotiTest{
    UIButton *btn = [UIButton zj_buttonWithFrame:CGRectMake(100, 330, 100, 40) title:@"截取屏幕图片" titleColor:kWhiteColor imageName:nil backColor:[UIColor orangeColor] fontSize:15 cornerRadius:6 traget:self action:@selector(btnTestClick:)];
    [self.view addSubview:btn];
}

-(void)btnTestClick:(UIButton *)sender{
    //获取截取屏幕的图片
    
    UIImage *image = [UIImage zj_snapshotCurrentcreen];
    if (image) {
        
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSaving:contextInfo:), (__bridge void * _Nullable)(self));
        
        [self.view addSubview:self.imgView];
        self.imgView.image = image;
    }
}

// 完成截图回调
-(void)image:(UIImage *)image didFinishSaving:(NSError *)error contextInfo:(void *)contextInfo{
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}




-(void)alertTest{
    
    UIAlertController *alert = [UIAlertController zj_alertControllerWithTitle:@"这是一个Alert" message:nil optionStyle:OptionStyleStyleOK_Cancel OkTitle:@"确定" cancelTitle:@"取消" okBlock:^{
        self.testNum = 2;
        [self.view zj_showWarning:[NSString stringWithFormat:@"%ld",self.testNum]];
        NSLog(@"确定");
    } cancelBlock:^{
        NSLog(@"取消");
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
}


-(void)textfieldTest{
    UITextField *field = [UITextField zj_textFieldWithFrame:CGRectMake(30, 50, ScreenWidth - 60, 50) textColor:[UIColor blackColor] fontSize:15 placeText:@"haha" placeColor:[UIColor redColor] borderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:field];
}


-(void)labelTest{
    self.label = [UILabel zj_labelWithFrame:CGRectMake(30, 50, self.view.frame.size.width - 60, 220) text:nil fontSize:18 isBold:NO textColor:[UIColor blueColor] textAligment:0 numLines:0];
    [self.view addSubview:self.label];
    self.label.text = @"记者：台湾军方23日称，解放军轰-6K等各型军机开展出岛链远海训练，其中部分机种经巴士海峡飞往西太平洋后沿原航路返回基地，台湾军方全程依规派舰机进行监侦应对。有媒体称，中国空军出岛链训练已成为常态。请问对此有何评论？";
    // 设置字间距
    [self.label setColumnSpace:1];
    // 设置行间距
    [self.label setRowSpace:5];
    self.label.textColor = [UIColor zj_colorWithHexString:@"0x123456" alpha:1.0];
    
}
-(void)buttonTest{
    self.btn = [UIButton zj_buttonWithFrame:CGRectMake(50, 50, 100, 40) title:@"dzj" titleColor:[UIColor blueColor] imageName:nil backColor:[UIColor orangeColor] fontSize:16 cornerRadius:5 traget:nil action:nil];
    
    [self.btn zj_addBtnActionHandler:^{
        NSLog(@"1234");
        [self.btn zj_showIndicator];
    }];
    
    __weak typeof(self)weakSelf = self;
    [self.btn zj_startTime:10 waitBlock:^(NSInteger remainTime) {
        
    } finishBlock:^{
        [weakSelf.btn zj_hideIndicator];
    }];
    
    [self.button zj_addBtnActionHandler:^{
        NSLog(@"wqerty");
        [self.btn zj_hideIndicator];
    }];
    [self.view addSubview:self.btn];
    [self.view addSubview:self.button];
    
    
    dispatch_block_t block = dispatch_block_create(0, ^{
        self.testNum = 2;
        NSLog(@"这是一个block-->%ld",self.testNum);
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

-(UIButton *)button{
    if (!_button) {
        _button = [UIButton zj_buttonWithFrame:CGRectMake(50, 120, 100, 40) title:@"haha" titleColor:[UIColor redColor] imageName:@"" backColor:[UIColor greenColor] fontSize:16 cornerRadius:5 traget:self action:@selector(btnClick:)];
    }
    return _button;
}

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 400, 120, 180)];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        _imgView.layer.borderColor = kLightGrayColor.CGColor;
        _imgView.layer.borderWidth = 0.5;
    }
    return _imgView;
}
-(void)btnClick:(UIButton *)sender{
    NSLog(@"%@",sender);
    [self.view addSubview:self.btn];
    [self.view addSubview:self.button];
}

-(void)dealloc{
    // 销毁计时器
    [_timeDown zj_timeDestoryTimer];
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
