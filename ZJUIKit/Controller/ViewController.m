//
//  ViewController.m
//  ZJUIKit
//
//  Created by dzj on 2017/12/1.
//  Copyright © 2017年 kapokcloud. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+ZJButton.h"
#import "UILabel+ZJLabel.h"
#import "UIColor+ZJColor.h"
#import "UIAlertController+ZJAlert.h"
#import "UITextView+ZJTextView.h"
#import "UITextField+ZJTextField.h"
#import "UIImage+ZJImage.h"
#import "ZJChooseViewController.h"
#import "ZJUIMasonsyKit.h"
#import "ZJKitNaigationController.h"

#import "ZJCommitViewController.h"

@interface ViewController ()

@property(nonatomic ,strong) UIButton *btn;
@property(nonatomic ,strong) UIButton *button;
@property(nonatomic ,strong) UILabel *label;



@end

@implementation ViewController

/**
 *  ZJUIKitTool
 *  GitHub地址：https://github.com/Dzhijian/ZJUIKitTool
 *
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ZJUIKit";
    
    UIButton *chooseBtn = [UIButton zj_buttonWithFrame:CGRectMake(50, 60, 100, 40) title:@"筛选" titleColor:[UIColor whiteColor] imageName:nil backColor:[UIColor orangeColor] fontSize:15 cornerRadius:4 traget:self action:@selector(goToChooseViewController)];
    [self.view addSubview:chooseBtn];
    
    kWeakObject(self);
    
    [UIButton  zj_buttonWithTitle:@"评论列表" titleColor:kWhiteColor backColor:kOrangeColor fontSize:16 isBold:YES cornerRadius:3 supView:self.view constraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(chooseBtn.mas_centerY);
        make.left.equalTo(chooseBtn.mas_right).offset(50);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    } touchUp:^(id sender) {
        NSLog(@"123456");
        ZJCommitViewController *commmit = [[ZJCommitViewController alloc]init];
        [weakObject.navigationController pushViewController:commmit animated:YES];
    }];
    
    [self zj_UIKitAndMasonry];
    
    
    
    
}

#pragma mark - 快速创建控件 + marsonry 布局
-(void)zj_UIKitAndMasonry{
    
    [UILabel zj_labelWithFont:14 lines:1 text:@"哈哈哈哈哈" textColor:kRedColor superView:self.view constraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(150);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];

    
    UILabel *lab = [UILabel zj_labelWithFont:16 text:@"666666666"];
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(190);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    
    kWeakObject(self);
    [UIView zj_viewWithBackColor:kRedColor supView:self.view constraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(-60);
        make.width.height.mas_equalTo(100);
    } onTap:^(UITapGestureRecognizer *gesture) {
        
        [weakObject.view zj_showBusyHUD];
    }];
    
    
    
   [UITextView zj_textViewWithFontSize:16 textColor:[UIColor orangeColor] borderColor:k16RGBColor(0xCCCCCC) borderWidth:0.5 cornerRadiu:4 placeColor:k16RGBColor(0xBBBBBB) placeText:@"请输入..." superView:self.view constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-100);
        make.height.mas_equalTo(180);
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
    UIButton *btn = [UIButton zj_buttonWithFrame:CGRectMake(100, 300, 80, 40) title:@"截图" titleColor:[UIColor redColor] imageName:nil backColor:[UIColor orangeColor] fontSize:15 cornerRadius:6 traget:self action:@selector(btnTestClick:)];
    [self.view addSubview:btn];
}

-(void)btnTestClick:(UIButton *)sender{
    UIImage *image = [UIImage zj_snapshotCurrentcreen];
    if (image) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSaving:contextInfo:), (__bridge void * _Nullable)(self));
    }
}


-(void)image:(UIImage *)image didFinishSaving:(NSError *)error contextInfo:(void *)contextInfo{
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}




-(void)alertTest{
    
    UITextField *field = [UITextField zj_textFieldWithFrame:CGRectMake(30, 50, ScreenWidth - 60, 50) textColor:[UIColor blackColor] fontSize:15 placeText:@"haha" placeColor:[UIColor redColor] borderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:field];
    
    
    UIAlertController *alert = [UIAlertController zj_alertControllerWithTitle:@"qwe" message:nil optionStyle:OptionStyleStyleOK_Cancel OkTitle:@"确定" cancelTitle:@"取消" okBlock:^{
        NSLog(@"123");
    } cancelBlock:^{
        NSLog(@"456");
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
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
    self.btn = [UIButton zj_buttonWithFrame:CGRectMake(50, 50, 100, 40) title:@"dzj" titleColor:[UIColor blueColor] imageName:@"" backColor:[UIColor orangeColor] fontSize:16 cornerRadius:5 traget:nil action:nil];
    
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
}

-(UIButton *)button{
    if (!_button) {
        _button = [UIButton zj_buttonWithFrame:CGRectMake(50, 120, 100, 40) title:@"haha" titleColor:[UIColor redColor] imageName:@"" backColor:[UIColor greenColor] fontSize:16 cornerRadius:5 traget:self action:@selector(btnClick:)];
    }
    return _button;
}

-(void)btnClick:(UIButton *)sender{
    NSLog(@"%@",sender);
    [self.view addSubview:self.btn];
    [self.view addSubview:self.button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
