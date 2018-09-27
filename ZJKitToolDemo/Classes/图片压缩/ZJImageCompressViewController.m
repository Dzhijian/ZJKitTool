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
@property (nonatomic, strong) UILabel *originLab;

// 压缩后的图片
@property (nonatomic, strong) UIImageView *compressImagV;
@property (nonatomic, strong) UILabel *compressLab;

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
        make.top.mas_equalTo(AdaptedWidth(20));
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
    
    
    self.originLab = [UILabel zj_labelWithFontSize:12 text:@"" superView:self.view constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orginImageV.mas_bottom);
        make.left.equalTo(self.orginImageV.mas_left);
        make.height.mas_equalTo(AdaptedWidth(40));
    }];
    self.originLab.numberOfLines = 2;
    
    // 压缩图片View
    self.compressImagV = [UIImageView zj_imageViewWithImage:nil SuperView:self.view constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orginImageV.mas_bottom).offset(AdaptedWidth(50));
        make.left.mas_equalTo(AdaptedWidth(20));
        make.right.mas_equalTo(AdaptedWidth(-20));
        make.height.mas_equalTo(AdaptedWidth(200));
    }];
    self.compressImagV.backgroundColor = kRGBColor(220, 220, 220);
    
    self.compressLab = [UILabel zj_labelWithFontSize:14 text:@"" superView:self.view constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.compressImagV.mas_bottom);
        make.left.equalTo(self.compressImagV.mas_left);
        make.height.mas_equalTo(AdaptedWidth(35));
    }];
    self.compressLab.numberOfLines = 2;
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
            // 原始数据大小
            NSString *originLength = [NSString stringWithFormat:@"原数据大小:%.4f MB",((double)originData.length/1024.0f/1024.0f)];
            // 原始数据尺寸
            NSString *orighnSize = [NSString stringWithFormat:@"原数据尺寸: width:%.2f height:%.2f",originImg.size.width,originImg.size.height];
            NSLog(@"%@\n%@",originLength,orighnSize);
            
            self.originLab.text = [NSString stringWithFormat:@"%@\n%@",originLength,orighnSize];
            self.orginImageV.image = originImg;
        });
    });
    
    
    // 压缩后的图片大小
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 子线程压缩,先压缩质量再压缩尺寸
        NSData *compressData = [originImg zj_compressWithMaxLengLimit:500.0f * 1024.0f];
        UIImage *compressImage = [UIImage imageWithData:compressData];
        
        // 回到主线程显示
        dispatch_async(dispatch_get_main_queue(), ^{
            // 压缩后的尺寸
            NSString *compressSize = [NSString stringWithFormat:@"压缩后图片数据尺寸: width:%.2f height:%.2f",compressImage.size.width,compressImage.size.height];
            // 压缩后的数据大小
            NSString *compressLength = [NSString stringWithFormat:@"压缩后图片数据大小:%.4f MB",((double)compressData.length/1024.0f/1024.0f)];
            NSLog(@"%@\n%@",compressLength,compressSize);
            
            self.compressLab.text = [NSString stringWithFormat:@"%@\n%@",compressLength,compressSize];
            
            self.compressImagV.image = compressImage;
        });
    });
    
    
    
}

#pragma mark - 压缩图片方法(压缩尺寸)
-(void)compressWithOriginImage:(UIImage *)originImage{
    // 压缩图片方法(压缩尺寸)
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *compressData = [originImage zj_compressQualityWithMaxLengthLimit:500.0f * 1024.0f];
        UIImage *compressImage = [UIImage imageWithData:compressData];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 压缩后的尺寸
            NSString *compressSize = [NSString stringWithFormat:@"压缩后图片数据尺寸: width:%.2f height:%.2f",compressImage.size.width,compressImage.size.height];
            // 压缩后的数据大小
            NSString *compressLength = [NSString stringWithFormat:@"压缩后图片数据大小:%.4f MB",((double)compressData.length/1024.0f/1024.0f)];
            NSLog(@"%@\n%@",compressLength,compressSize);
            
            self.compressLab.text = [NSString stringWithFormat:@"%@\n%@",compressLength,compressSize];
            self.compressImagV.image = compressImage;
        });
    });
}


// 取消事件
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
