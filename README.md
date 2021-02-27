# ZJKitTool

[![Version](https://img.shields.io/cocoapods/v/ZJKitTool.svg?style=flat)](https://cocoapods.org/pods/ZJKitTool)
[![License](https://img.shields.io/cocoapods/l/ZJKitTool.svg?style=flat)](https://cocoapods.org/pods/ZJKitTool)
[![Platform](https://img.shields.io/cocoapods/p/ZJKitTool.svg?style=flat)](https://cocoapods.org/pods/ZJKitTool)

## Statement

ZJKitTool 可以更加便捷高效的添加UIKit控件,使用链式编程的思想，结合使用Masonry，以及其他工具类的简单使用,底层的封装.

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

#### ZJChain UIKIt 链式语法

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
UIButton *btn  = [[UIButton alloc]init];
btn.zj_chain.superView(self.view)
.title(@"这是一个按钮", UIControlStateNormal)
.titleColor([UIColor whiteColor], UIControlStateNormal)
.titleFont([UIFont boldSystemFontOfSize:16])
.backgroundColor([UIColor systemTealColor])
.cornerRadius(6)
.onTouchUp(^(id  _Nonnull sender) {
    NSLog(@"点击了按钮");
})
.makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
    make.top.equalTo(textView.mas_bottom).offset(20);
    make.left.mas_equalTo(30);
    make.right.mas_equalTo(-30);
    make.height.mas_equalTo(50);
});    
```


> 快速添加一个带placeholder的UITextView控件,并可以修改颜色

```Objc
UITextView *textView = [[UITextView alloc]init];
textView.zj_chain.superView(self.view)
.textColor([UIColor grayColor])
.font([UIFont systemFontOfSize:15])
.borderColor([UIColor blackColor].CGColor)
.borderWidth(1)
.placeholder(@"这是一个 UITextView")
.placeholderColor([UIColor redColor])
.makeMasonry(^(__kindof UIView * _Nonnull sender, MASConstraintMaker * _Nonnull make) {
    make.top.equalTo(textField.mas_bottom).offset(20);
    make.left.mas_equalTo(30);
    make.right.mas_equalTo(-30);
    make.height.mas_equalTo(90);
});
    
```

> 地区选择器，确认点击事件通过 block 返回

``` OBjc
// 地区选择弹窗,推荐用这种形式创建
ZJAddressPickerView *address = [[ZJAddressPickerView alloc]initWithPickerMode:(ZJAddressPickerModeArea)];
address.leftBtnTitleColor = [UIColor orangeColor];
address.rightBtnTitleColor = [UIColor purpleColor];
address.selectRowBGColor = [UIColor lightGrayColor];
address.selecteRowTextColor = [UIColor orangeColor];
address.isAutoSelect = true;
address.rowHeight = 40;
[address showPickerViewWithAnimation:true];
address.resultBlock = ^(ZJProvinceModel *province, ZJCityModel *city, ZJAreaModel *area) {
    lab1.text = [NSString stringWithFormat:@"%@-%@-%@",province.name,city.name,area.name];
    
};
```

MVVM模式设计的图文混排评论列表，简单可随意更改的筛选视图，后期会不断完善，以及各个控件的封装，Block回调可以简单快速创建和使用Masonry布局，以及实现方法。还包括许多工具类的封装。
请各位大神多多指教，多多支持点个Star。

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


  
 

  
  


