# ZJKitTool

[![Version](https://img.shields.io/cocoapods/v/ZJKitTool.svg?style=flat)](https://cocoapods.org/pods/ZJKitTool)
[![License](https://img.shields.io/cocoapods/l/ZJKitTool.svg?style=flat)](https://cocoapods.org/pods/ZJKitTool)
[![Platform](https://img.shields.io/cocoapods/p/ZJKitTool.svg?style=flat)](https://cocoapods.org/pods/ZJKitTool)

## Statement

ZJKitTool 开发快速添加UIKit控件,结合Masonry，以及其他工具类的简单使用,底层的封装.

### iOS开发学习交流群

**群号:616477537**

> 加群请备注 iOS学习交流

![iOS学习交流群](http://image.coderdeng.xyz/iOS_study_chat.jpg/style03)

### Contact
Author: James
Email: 646724452@qq.com
QQ: 646724452
WeChat: 18819206239

## Installation

ZJKitTool is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ZJKitTool'
```


> 导入头文件

```Objc
#import <ZJKitTool.h>
```

## Usage

MVVM模式设计的图文混排评论列表，简单可随意更改的筛选视图，后期会不断完善，以及各个控件的封装，Block回调可以简单快速创建和使用Masonry布局，以及实现方法。还包括许多工具类的封装。
请各位大神多多指教，多多支持点个Star。

> 2.5.0 添加 UIKit 链式语法 支持 UIView 、UILabel、UIButton、UIImageView、UITextField、UITextView、UITableView、UICollection、UIScrollView、UISwitch。

> 可以结合使用 Masonry, 使用前必须先添加 `superView` ，否则 masonry 约束会无效，详细用法看 Demo 的 `ZJUIViewController` 控制器代码

示例代码如下：

```Objc
UIView *view = [[UIView alloc]init];
view.zj_chain.backgroundColor(kRedColor)
.shadowRadius(6)
.shadowOffset(CGSizeMake(3, 3))
.shadowOpacity(0.7)
.shadowColor(kBlackColor.CGColor)
.borderColor(kOrangeColor.CGColor)
.borderWidth(5)
.superView(self.view)
.makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
    make.bottom.mas_equalTo(-100);
    make.left.mas_equalTo(50);
    make.right.mas_equalTo(-50);
    make.height.mas_equalTo(100);
});

    
UILabel *label = [[UILabel alloc]init];
label.zj_chain
.frame(CGRectMake(50, 500, 220, 30))
.backgroundColor(kOrangeColor)
.text(@"James is the champion")
.font(kBoldFontWithSize(18))
.textAlignment(NSTextAlignmentRight)
.superView(self.view)
.textColor(kWhiteColor).makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
    make.bottom.equalTo(view.mas_top).offset(-30);
    make.centerX.mas_equalTo(0);
    make.width.mas_equalTo(300);
    make.height.mas_equalTo(40);
    NSLog(@"%@",sender);
});
```

> 快速创建一个按钮,赋给实例的按钮,并实现点击事件：

```Objc
  self.btn = [UIButton  zj_buttonWithTitle:@"评论列表"
                                  titleColor:kWhiteColor
                                   backColor:kOrangeColor
                                    fontSize:16 isBold:YES
                                cornerRadius:3
                                     supView:self.view constraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(chooseBtn.mas_centerY);
        make.left.equalTo(chooseBtn.mas_right).offset(50);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    } touchUp:^(id sender) {
        NSLog(@"这是按钮的点击事件");
    }];
    
```


> 快速添加一个带placeholder的UITextView控件,并可以修改颜色

```Objc
[UITextView zj_textViewWithFontSize:16
                              textColor:kOrangeColor
                            borderColor:k16RGBColor(0xCCCCCC)
                            borderWidth:0.5
                            cornerRadiu:4
                             placeColor:k16RGBColor(0xBBBBBB)
                              placeText:@"请输入..."
                              superView:self.view
                            constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-100);
        make.height.mas_equalTo(180);
    }];
```

> 创建一个按钮，并且点击弹出一个地区选择器

``` OBjc

[UIButton zj_buttonWithTitle:@"选择地区自定义" titleColor:kLightGrayColor
                       backColor:kWhiteColor fontSize:14 isBold:YES cornerRadius:4
                         supView:self.view constraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lab3.mas_centerY);
        make.left.equalTo(lab3.mas_right).offset(30);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(35);
    } touchUp:^(id sender) {
        
        [ZJAddressPickerView zj_showAddressPickerWithShowType:ZJAddressPickerModeArea
                                                   dataSource:nil
                                              defaultSelected:nil
                                                 isAutoSelect:YES
                                                    lineColor:[UIColor redColor]
                                           selectRowTextColor:[UIColor orangeColor]
                                             selectRowBGColor:kRGBColor(230, 230, 230)
                                         confirmBtnTitleColor:kRGBColor(116, 80, 200)
                                          cancelBtnTitleColor:kRGBColor(116, 80, 200)
                                                    rowHeight:50.0
                                                  resultBlock:^(ZJProvinceModel *province, ZJCityModel *city, ZJAreaModel *area) {
                                                      lab3.text = [NSString stringWithFormat:@"%@-%@-%@",province.name,city.name,area.name];
                                                  } cancelBlock:^{
                                                      
                                                  }];
    }];
    

```

 在评论列表中浏览图片推荐使用 KSPhotoBrowser 第三方库浏览
 
>  /*
>   * 使用 KSPhotoBrowser 浏览图片
>   * 使用cocoaPods 导入
>   * pod 'KSPhotoBrowser'
>   
>   */ 
  

  
  
| MVVM评论列表 | Masonry自动布局简单朋友圈 |
| --- | --- |
| ![](https://github.com/Dzhijian/ZJKitTool/blob/master/img-folder/commitMVVM.jpg?raw=true) | ![](https://github.com/Dzhijian/ZJKitTool/blob/master/img-folder/commmitsMasonry.jpg?raw=true)|

  



| 倒计时列表 | WKWebView与 JS交互 |
| --- | --- |
| ![](https://github.com/Dzhijian/ZJKitTool/blob/master/img-folder/countDown.jpg?raw=true) | ![](https://github.com/Dzhijian/ZJKitTool/blob/master/img-folder/WKWebView.jpeg?raw=true) |





 
 >  **瀑布流**
  
  
| 横向布局 | 垂直布局 |
| --- | --- |
| ![](https://github.com/Dzhijian/ZJKitTool/blob/master/img-folder/collectionViewhorizontal.jpg?raw=true) | ![](https://github.com/Dzhijian/ZJKitTool/blob/master/img-folder/collectionViewVertacal.jpg?raw=true)|





 >  **ZJPickerView**
 > 自定义日期时间、地区选择器，可以自定义数据，修改选择中行的文字颜色，背景颜色，按钮颜色，自动选择等等。
 
 
| 时间选择器 | 地区选择器 |
| --- | --- |
| ![](https://github.com/Dzhijian/ZJKitTool/blob/master/img-folder/datePickerView.jpg?raw=true) | ![](https://github.com/Dzhijian/ZJKitTool/blob/master/img-folder/normalPickerView.jpg?raw=true)|
 
## License
ZJKitTool is released under the MIT license. See LICENSE for details.


  
 

  
  


