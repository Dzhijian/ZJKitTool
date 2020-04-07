//
//  ZJTextFieldChainModel.m
//  ZJKitTool
//
//  Created by 邓志坚 on 2020/3/28.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJTextFieldChainModel.h"
#import <objc/runtime.h>

#define  ZJ_CHAIN_TEXTFIELD_IMPLEMENTATION(methodName, viewMethod, ParmaType)  ZJ_CHAIN_IMPLEMENTATION(methodName, viewMethod, ParmaType, ZJTextFieldChainModel * , UITextField)

@implementation ZJTextFieldChainModel


ZJ_CHAIN_TEXTFIELD_IMPLEMENTATION(text, setText ,NSString *);
ZJ_CHAIN_TEXTFIELD_IMPLEMENTATION(attributedText, setAttributedText, NSAttributedString *);

ZJ_CHAIN_TEXTFIELD_IMPLEMENTATION(font, setFont, UIFont *);
ZJ_CHAIN_TEXTFIELD_IMPLEMENTATION(textColor,setTextColor, UIColor *);

ZJ_CHAIN_TEXTFIELD_IMPLEMENTATION(textAlignment, setTextAlignment, NSTextAlignment);
ZJ_CHAIN_TEXTFIELD_IMPLEMENTATION(borderStyle,setBorderStyle, UITextBorderStyle);

ZJ_CHAIN_TEXTFIELD_IMPLEMENTATION(defaultTextAttributes,setDefaultTextAttributes, NSDictionary *);

ZJ_CHAIN_TEXTFIELD_IMPLEMENTATION(placeholder,setPlaceholder,  NSString *);
ZJ_CHAIN_TEXTFIELD_IMPLEMENTATION(attributedPlaceholder,setAttributedPlaceholder, NSAttributedString *);

ZJ_CHAIN_TEXTFIELD_IMPLEMENTATION(keyboardType,setKeyboardType, UIKeyboardType);

ZJ_CHAIN_TEXTFIELD_IMPLEMENTATION(clearsOnBeginEditing,setClearsOnBeginEditing, BOOL);
ZJ_CHAIN_TEXTFIELD_IMPLEMENTATION(adjustsFontSizeToFitWidth,setAdjustsFontSizeToFitWidth, BOOL);
ZJ_CHAIN_TEXTFIELD_IMPLEMENTATION(minimumFontSize,setMinimumFontSize, CGFloat);

ZJ_CHAIN_TEXTFIELD_IMPLEMENTATION(delegate,setDelegate, id<UITextFieldDelegate>);

ZJ_CHAIN_TEXTFIELD_IMPLEMENTATION(background,setBackground, UIImage *);
ZJ_CHAIN_TEXTFIELD_IMPLEMENTATION(disabledBackground,setDisabledBackground, UIImage *);

ZJ_CHAIN_TEXTFIELD_IMPLEMENTATION(allowsEditingTextAttributes,setAllowsEditingTextAttributes, BOOL);
ZJ_CHAIN_TEXTFIELD_IMPLEMENTATION(typingAttributes,setTypingAttributes, NSDictionary *);

ZJ_CHAIN_TEXTFIELD_IMPLEMENTATION(clearButtonMode,setClearButtonMode, UITextFieldViewMode);
ZJ_CHAIN_TEXTFIELD_IMPLEMENTATION(leftView, setLeftView, UIView *);
ZJ_CHAIN_TEXTFIELD_IMPLEMENTATION(leftViewMode, setLeftViewMode,UITextFieldViewMode);
ZJ_CHAIN_TEXTFIELD_IMPLEMENTATION(rightView, setRightView,UIView *);
ZJ_CHAIN_TEXTFIELD_IMPLEMENTATION(rightViewMode, setRightViewMode, UITextFieldViewMode);

ZJ_CHAIN_TEXTFIELD_IMPLEMENTATION(inputView,setInputView, UIView *);
ZJ_CHAIN_TEXTFIELD_IMPLEMENTATION(inputAccessoryView,setInputAccessoryView, UIView *);

ZJ_CHAIN_TEXTFIELD_IMPLEMENTATION(enabled,setEnabled, BOOL);


@end


@implementation UITextField (ZJChain)

- (ZJTextFieldChainModel *)zj_chain{
    
    ZJTextFieldChainModel *model = objc_getAssociatedObject(self, _cmd);
    if (!model) {

        NSAssert(![self isKindOfClass:[ZJTextFieldChainModel class]], @"类型错误");

        model = [ZJTextFieldChainModel new];
        model.view = self;
        objc_setAssociatedObject(self, _cmd, model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
    }
    return model;
}
@end
