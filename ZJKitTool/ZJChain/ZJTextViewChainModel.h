//
//  ZJTextViewChainModel.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2020/3/28.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJBaseChainModel.h"

NS_ASSUME_NONNULL_BEGIN

@class ZJTextViewChainModel;

@interface ZJTextViewChainModel : ZJBaseChainModel<ZJTextViewChainModel *>
ZJ_CHAIN_PROPERTY ZJTextViewChainModel *(^ delegate)(id<UITextViewDelegate> delegate);

ZJ_CHAIN_PROPERTY ZJTextViewChainModel *(^ text)(NSString *text);
ZJ_CHAIN_PROPERTY ZJTextViewChainModel *(^ font)(UIFont *font);
ZJ_CHAIN_PROPERTY ZJTextViewChainModel *(^ textColor)(UIColor *textColor);

ZJ_CHAIN_PROPERTY ZJTextViewChainModel *(^ textAlignment)(NSTextAlignment textAlignment);
ZJ_CHAIN_PROPERTY ZJTextViewChainModel *(^ selectedRange)(NSRange numberOfLines);
ZJ_CHAIN_PROPERTY ZJTextViewChainModel *(^ editable)(BOOL editable);
ZJ_CHAIN_PROPERTY ZJTextViewChainModel *(^ selectable)(BOOL selectable);
ZJ_CHAIN_PROPERTY ZJTextViewChainModel*(^ dataDetectorTypes)(UIDataDetectorTypes dataDetectorTypes);

ZJ_CHAIN_PROPERTY ZJTextViewChainModel *(^ keyboardType)(UIKeyboardType keyboardType);

ZJ_CHAIN_PROPERTY ZJTextViewChainModel *(^ allowsEditingTextAttributes)(BOOL allowsEditingTextAttributes);
ZJ_CHAIN_PROPERTY ZJTextViewChainModel *(^ attributedText)(NSAttributedString *attributedText);
ZJ_CHAIN_PROPERTY ZJTextViewChainModel*(^ typingAttributes)(NSDictionary *typingAttributes);

ZJ_CHAIN_PROPERTY ZJTextViewChainModel *(^ clearsOnInsertion)(BOOL clearsOnInsertion);

ZJ_CHAIN_PROPERTY ZJTextViewChainModel *(^ textContainerInset)(UIEdgeInsets textContainerInset);
ZJ_CHAIN_PROPERTY ZJTextViewChainModel *(^ linkTextAttributes)(NSDictionary *linkTextAttributes);

#pragma mark - UIScrollView
ZJ_CHAIN_PROPERTY ZJTextViewChainModel *(^ contentSize)(CGSize contentSize);
ZJ_CHAIN_PROPERTY ZJTextViewChainModel *(^ contentOffset)(CGPoint contentOffset);
ZJ_CHAIN_PROPERTY ZJTextViewChainModel *(^ contentInset)(UIEdgeInsets contentInset);

ZJ_CHAIN_PROPERTY ZJTextViewChainModel *(^ bounces)(BOOL bounces);
ZJ_CHAIN_PROPERTY ZJTextViewChainModel *(^ alwaysBounceVertical)(BOOL alwaysBounceVertical);
ZJ_CHAIN_PROPERTY ZJTextViewChainModel *(^ alwaysBounceHorizontal)(BOOL alwaysBounceHorizontal);

ZJ_CHAIN_PROPERTY ZJTextViewChainModel *(^ pagingEnabled)(BOOL pagingEnabled);
ZJ_CHAIN_PROPERTY ZJTextViewChainModel *(^ scrollEnabled)(BOOL scrollEnabled);

ZJ_CHAIN_PROPERTY ZJTextViewChainModel *(^ showsHorizontalScrollIndicator)(BOOL showsHorizontalScrollIndicator);
ZJ_CHAIN_PROPERTY ZJTextViewChainModel *(^ showsVerticalScrollIndicator)(BOOL showsVerticalScrollIndicator);

ZJ_CHAIN_PROPERTY ZJTextViewChainModel *(^ scrollsToTop)(BOOL scrollsToTop);
/// placeholder 占位符
ZJ_CHAIN_PROPERTY ZJTextViewChainModel *(^ placeholder)(NSString *placeholder);
/// placeholder 占位符颜色,请在设置 placeholder 后,再使用 placeholderColor
ZJ_CHAIN_PROPERTY ZJTextViewChainModel *(^ placeholderColor)(UIColor *placeholderColor);

@end


@interface UITextView (ZJChain)

-(ZJTextViewChainModel *)zj_chain;
/// 设置 placeholder
- (void)zj_textViewsPlaceholder:(NSString *)placeholder;
/// 设置 placeholderColor
- (void)zj_textViewsSetPlaceholderColor:(UIColor *)placeholderColor;

@end


NS_ASSUME_NONNULL_END
