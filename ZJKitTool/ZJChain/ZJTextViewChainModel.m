//
//  ZJTextViewChainModel.m
//  ZJKitTool
//
//  Created by 邓志坚 on 2020/3/28.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJTextViewChainModel.h"
#import <objc/runtime.h>

#define  ZJ_CHAIN_TEXTVIEW_IMPLEMENTATION(methodName, viewMethod, ParmaType)  ZJ_CHAIN_IMPLEMENTATION(methodName, viewMethod, ParmaType, ZJTextViewChainModel * , UITextView)
#define  ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(methodName, viewMethod, ParmaType)  ZJ_CHAIN_IMPLEMENTATION(methodName, viewMethod, ParmaType, ZJTextViewChainModel * , UITextView)
@implementation ZJTextViewChainModel

ZJ_CHAIN_TEXTVIEW_IMPLEMENTATION(delegate,setDelegate, id<UITextViewDelegate>);

ZJ_CHAIN_TEXTVIEW_IMPLEMENTATION(text, setText,NSString *);
ZJ_CHAIN_TEXTVIEW_IMPLEMENTATION(font, setFont, UIFont *);
ZJ_CHAIN_TEXTVIEW_IMPLEMENTATION(textColor, setTextColor, UIColor *);

ZJ_CHAIN_TEXTVIEW_IMPLEMENTATION(textAlignment, setTextAlignment, NSTextAlignment);
ZJ_CHAIN_TEXTVIEW_IMPLEMENTATION(selectedRange, setSelectedRange, NSRange);
ZJ_CHAIN_TEXTVIEW_IMPLEMENTATION(editable, setEditable, BOOL);
ZJ_CHAIN_TEXTVIEW_IMPLEMENTATION(selectable, setSelectable, BOOL);
ZJ_CHAIN_TEXTVIEW_IMPLEMENTATION(dataDetectorTypes, setDataDetectorTypes, UIDataDetectorTypes);

ZJ_CHAIN_TEXTVIEW_IMPLEMENTATION(keyboardType, setKeyboardType, UIKeyboardType);

ZJ_CHAIN_TEXTVIEW_IMPLEMENTATION(allowsEditingTextAttributes, setAllowsEditingTextAttributes, BOOL);
ZJ_CHAIN_TEXTVIEW_IMPLEMENTATION(attributedText, setAttributedText, NSAttributedString *);
ZJ_CHAIN_TEXTVIEW_IMPLEMENTATION(typingAttributes, setTypingAttributes, NSDictionary *);

ZJ_CHAIN_TEXTVIEW_IMPLEMENTATION(clearsOnInsertion, setClearsOnInsertion, BOOL);

ZJ_CHAIN_TEXTVIEW_IMPLEMENTATION(textContainerInset, setTextContainerInset, UIEdgeInsets);
ZJ_CHAIN_TEXTVIEW_IMPLEMENTATION(linkTextAttributes, setLinkTextAttributes, NSDictionary *);

#pragma mark - UIScrollView
ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(contentSize, setContentSize, CGSize)
ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(contentOffset, setContentOffset, CGPoint)
ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(contentInset, setContentInset, UIEdgeInsets)

ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(bounces, setBounces, BOOL)
ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(alwaysBounceVertical, setAlwaysBounceVertical, BOOL)
ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(alwaysBounceHorizontal, setAlwaysBounceHorizontal, BOOL)

ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(pagingEnabled, setPagingEnabled, BOOL)
ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(scrollEnabled, setScrollEnabled, BOOL)

ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(showsHorizontalScrollIndicator, setShowsHorizontalScrollIndicator, BOOL)
ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(showsVerticalScrollIndicator, setShowsVerticalScrollIndicator, BOOL)

ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(scrollsToTop,setScrollsToTop, BOOL)
@end

@implementation UITextView (ZJChain)

- (ZJTextViewChainModel *)zj_chain{
    
    ZJTextViewChainModel *model = objc_getAssociatedObject(self, _cmd);
    if (!model) {

        NSAssert(![self isKindOfClass:[ZJTextViewChainModel class]], @"类型错误");
        model = [ZJTextViewChainModel new];
        model.view = self;
        objc_setAssociatedObject(self, _cmd, model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
    }
    return model;
}
+(void)load{
    
    // 获取类方法 class_getClassMethod
    // 获取对象方法 class_getInstanceMethod
    Method setFontMethod = class_getInstanceMethod(self, @selector(setFont:));
    Method was_setFontMethod =class_getInstanceMethod(self, @selector(was_setFont:));
    // 交换方法的实现
    method_exchangeImplementations(setFontMethod, was_setFontMethod);
    
}

-(void)zj_textViewsSetPlaceholderWithText:(NSString *)text Color:(UIColor *)color{
    //多余 强指针换了指向以后label自动销毁
    //防止重复设置 cell复用等问题
    //    for (UIView *view in self.subviews) {
    //        if ([view isKindOfClass:[UILabel class]]) {
    //            [view removeFromSuperview];
    //        }
    //    }
    
    //设置占位label
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = self.font;
    label.textColor = color;
    label.numberOfLines = 0;
    [self addSubview:label];
    [self setValue:label forKey:@"_placeholderLabel"];
}

- (void)was_setFont:(UIFont *)font{
    //调用原方法 setFont:
    [self was_setFont:font];
    //设置占位字符串的font
    UILabel *label = [self valueForKey:@"_placeholderLabel"];
    label.font = font;
    NSLog(@"%s", __func__);
}

@end
