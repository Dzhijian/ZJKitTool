//
//  ZJNetworkViewController.m
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/7/6.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJNetworkViewController.h"

@interface ZJNetworkViewController ()

@property (nonatomic, strong) UITextView *textView;
@end

@implementation ZJNetworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ZJNewWorking网络请求";
    
    self.textView = [UITextView zj_textViewWithFontSize:14 textColor:kOrangeColor placeColor:kBlackColor placeText:@"请点击右边按钮请求数据" superView:self.view constraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(10);
        make.right.bottom.mas_equalTo(-10);
    }];
    
    
    kWeakObject(self);
    [self zj_setNavRightButtonTitle:@"请求网络" onCliked:^(id sender) {
        
        [ZJNetworking getWithURLString:@"http://www.590edu.com/api/merchant/top_category_list" refreshCache:YES success:^(NSString  *response) {
            
            weakObject.textView.text = [NSString stringWithFormat:@"%@",response];
            
        } fail:^(NSError *error) {
            
        }];
        
    }];
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
