//
//  ZJImageCompressViewController.m
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/9/27.
//  Copyright © 2018 kapokcloud. All rights reserved.
//

#import "ZJImageCompressViewController.h"
@interface ZJImageCompressViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

// 原始图片
@property (nonatomic, strong) UIImageView *orginImageV;
// 压缩后的图片
@property (nonatomic, strong) UIImageView *compressImagV;
@end

@implementation ZJImageCompressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpAllView];
}

#pragma mark - 设置 UI
-(void)setUpAllView{
    kWeakObject(self);
    
    // 按钮
    UIButton *btn =  [UIButton zj_buttonWithTitle:@"打开相册" titleColor: kWhiteColor norImage:nil selectedImage:nil backColor:kOrangeColor fontSize:14 isBold:NO cornerRadius:5 supView:self.view constraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(AdaptedWidth(50));
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(AdaptedWidth(120));
        make.height.mas_equalTo(AdaptedWidth(40));
    } touchUp:^(id sender) {
        [weakObject showImagePicker];
        
    }];
    
    // 原始图片View
    self.orginImageV = [UIImageView zj_imageViewWithImage:nil SuperView:self.view constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn.mas_bottom).offset(AdaptedWidth(30));
        make.left.mas_equalTo(AdaptedWidth(20));
        make.right.mas_equalTo(AdaptedWidth(-20));
        make.height.mas_equalTo(AdaptedWidth(200));
    }];
    self.orginImageV.backgroundColor = kRGBColor(220, 220, 220);
    
    // 压缩图片View
    self.compressImagV = [UIImageView zj_imageViewWithImage:nil SuperView:self.view constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orginImageV.mas_bottom).offset(AdaptedWidth(50));
        make.left.mas_equalTo(AdaptedWidth(20));
        make.right.mas_equalTo(AdaptedWidth(-20));
        make.height.mas_equalTo(AdaptedWidth(200));
    }];
    
    self.compressImagV.backgroundColor = kRGBColor(220, 220, 220);
    
}

#pragma mark - 显示图库
-(void)showImagePicker{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.sourceType       = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing    = YES;
        picker.delegate         = self;
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        NSLog(@"没有相册权限");
    }
}

#pragma mark - UIImagePickerControllerDelegate,UINavigationControllerDelegate
// 选中事件
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"info: %@",info);
    // 获取原始图片
    UIImage *originImg = info[@"UIImagePickerControllerOriginalImage"];
    // 编辑后的图片
//    UIImage *editImg = info[@"UIImagePickerControllerEditedImage"];
    
    // 子线程加载图片
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 原始图片大小
        NSData *originData = UIImageJPEGRepresentation(originImg, 1.0f);
        // 主线程显示图片
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@",[NSString stringWithFormat:@"原数据大小:%.4f MB",((double)originData.length/1024.0f/1024.0f)]);
            NSLog(@"原图片数据尺寸: width:%f height:%f",originImg.size.width,originImg.size.height);
            self.orginImageV.image = originImg;
        });
    });
    
    
    // 压缩后的图片大小
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 子线程压缩
        NSData *compressData = [originImg zj_compressWithMaxLengLimit:500.0f * 1024.0f];
        UIImage *compressImage = [UIImage imageWithData:compressData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"压缩后图片数据尺寸: width:%f height:%f",compressImage.size.width,compressImage.size.height);
            NSLog(@"压缩后图片数据大小:%.4f MB",(double)compressData.length/1024.0f/1024.0f);
            // 回到主线程显示
            self.compressImagV.image = compressImage;
        });
    });
    
    
    
    
}



// 取消事件
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
