//
//  ZJTextFieldChainModel.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2020/3/28.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJBaseChainModel.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZJTextFieldChainModel;

@interface ZJTextFieldChainModel : ZJBaseChainModel<ZJTextFieldChainModel *>


ZJ_CHAIN_PROPERTY ZJTextFieldChainModel *(^ text)(NSString *text);
ZJ_CHAIN_PROPERTY ZJTextFieldChainModel *(^ attributedText)(NSAttributedString *attributedText);

ZJ_CHAIN_PROPERTY ZJTextFieldChainModel *(^ font)(UIFont *font);
ZJ_CHAIN_PROPERTY ZJTextFieldChainModel *(^ textColor)(UIColor *textColor);

ZJ_CHAIN_PROPERTY ZJTextFieldChainModel *(^ textAlignment)(NSTextAlignment textAlignment);
ZJ_CHAIN_PROPERTY ZJTextFieldChainModel *(^ borderStyle)(UITextBorderStyle borderStyle);

ZJ_CHAIN_PROPERTY ZJTextFieldChainModel *(^ defaultTextAttributes)(NSDictionary *defaultTextAttributes);

ZJ_CHAIN_PROPERTY ZJTextFieldChainModel *(^ placeholder)(NSString *placeholder);
ZJ_CHAIN_PROPERTY ZJTextFieldChainModel *(^ attributedPlaceholder)(NSAttributedString *attributedPlaceholder);

ZJ_CHAIN_PROPERTY ZJTextFieldChainModel *(^ keyboardType)(UIKeyboardType keyboardType);

ZJ_CHAIN_PROPERTY ZJTextFieldChainModel *(^ clearsOnBeginEditing)(BOOL clearsOnBeginEditing);
ZJ_CHAIN_PROPERTY ZJTextFieldChainModel *(^ adjustsFontSizeToFitWidth)(BOOL adjustsFontSizeToFitWidth);
ZJ_CHAIN_PROPERTY ZJTextFieldChainModel *(^ minimumFontSize)(CGFloat minimumFontSize);

ZJ_CHAIN_PROPERTY ZJTextFieldChainModel *(^ delegate)(id<UITextFieldDelegate> delegate);

ZJ_CHAIN_PROPERTY ZJTextFieldChainModel *(^ background)(UIImage *background);
ZJ_CHAIN_PROPERTY ZJTextFieldChainModel *(^ disabledBackground)(UIImage *disabledBackground);

ZJ_CHAIN_PROPERTY ZJTextFieldChainModel *(^ allowsEditingTextAttributes)(BOOL allowsEditingTextAttributes);
ZJ_CHAIN_PROPERTY ZJTextFieldChainModel *(^ typingAttributes)(NSDictionary *typingAttributes);

ZJ_CHAIN_PROPERTY ZJTextFieldChainModel *(^ clearButtonMode)(UITextFieldViewMode clearButtonMode);
ZJ_CHAIN_PROPERTY ZJTextFieldChainModel *(^ leftView)(UIView *leftView);
ZJ_CHAIN_PROPERTY ZJTextFieldChainModel *(^ leftViewMode)(UITextFieldViewMode leftViewMode);
ZJ_CHAIN_PROPERTY ZJTextFieldChainModel *(^ rightView)(UIView *rightView);
ZJ_CHAIN_PROPERTY ZJTextFieldChainModel *(^ rightViewMode)(UITextFieldViewMode rightViewMode);

ZJ_CHAIN_PROPERTY ZJTextFieldChainModel *(^ inputView)(UIView *inputView);
ZJ_CHAIN_PROPERTY ZJTextFieldChainModel *(^ inputAccessoryView)(UIView *inputAccessoryView);

ZJ_CHAIN_PROPERTY ZJTextFieldChainModel *(^ enable)(BOOL enable);

@end

@interface UITextField (ZJChain)

-(ZJTextFieldChainModel *)zj_chain;

@end
NS_ASSUME_NONNULL_END
