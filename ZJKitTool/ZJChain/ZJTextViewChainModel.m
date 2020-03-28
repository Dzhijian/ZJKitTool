//
//  ZJTextViewChainModel.m
//  ZJKitTool
//
//  Created by 邓志坚 on 2020/3/28.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJTextViewChainModel.h"

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
@end
