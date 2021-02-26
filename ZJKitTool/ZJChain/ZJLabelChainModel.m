//
//  ZJLabelChainModel.m
//  ZJKitTool
//
//  Created by 邓志坚 on 2020/3/27.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJLabelChainModel.h"
#import <objc/runtime.h>
#include <CoreText/CTStringAttributes.h>

#define  ZJ_CHAIN_LABEL_IMPLEMENTATION(methodName, viewMethod, ParmaType)  ZJ_CHAIN_IMPLEMENTATION(methodName, viewMethod, ParmaType, ZJLabelChainModel * , UILabel)
static const void *s_zjChain_label_tapGestureKey = "s_zjChain_label_tapGestureKey";

@implementation ZJLabelChainModel

ZJ_CHAIN_LABEL_IMPLEMENTATION(text, setText, NSString *);
ZJ_CHAIN_LABEL_IMPLEMENTATION(font, setFont, UIFont *);
ZJ_CHAIN_LABEL_IMPLEMENTATION(textColor, setTextColor, UIColor *);
ZJ_CHAIN_LABEL_IMPLEMENTATION(attributedText, setAttributedText, NSAttributedString *);
ZJ_CHAIN_LABEL_IMPLEMENTATION(textAlignment, setTextAlignment, NSTextAlignment);
ZJ_CHAIN_LABEL_IMPLEMENTATION(numberOfLines, setNumberOfLines, NSInteger);
ZJ_CHAIN_LABEL_IMPLEMENTATION(lineBreakMode, setLineBreakMode, NSLineBreakMode);
ZJ_CHAIN_LABEL_IMPLEMENTATION(adjustsFontSizeToFitWidth, setAdjustsFontSizeToFitWidth, BOOL);

- (ZJLabelChainModel * _Nonnull (^)(CGFloat))columnSpace{
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat columnSpace){
        [(UILabel *)weakSelf.view setColumnSpace:columnSpace];
        return weakSelf;
    };
}

- (ZJLabelChainModel * _Nonnull (^)(CGFloat))rowSpace{
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat rowSpace){
        [(UILabel *)weakSelf.view setRowSpace:rowSpace];
        return weakSelf;
    };
}

- (ZJLabelChainModel * _Nonnull (^)(ZJTapGestureBlock _Nonnull))onTap{
    __weak typeof(self) weakSelf = self;
    return ^ZJLabelChainModel* (ZJTapGestureBlock _Nonnull tap) {
        [weakSelf.view addTapGestureWithCallback:tap];
        return weakSelf;
    };
}

@end


@implementation UILabel (ZJChain)

- (ZJLabelChainModel *)zj_chain{
    
    ZJLabelChainModel *model = objc_getAssociatedObject(self, _cmd);
    if (!model) {

        NSAssert(![self isKindOfClass:[ZJLabelChainModel class]], @"类型错误");

        model = [ZJLabelChainModel new];
        model.view = self;
        objc_setAssociatedObject(self, _cmd, model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
    }
    return model;
}

- (void)setColumnSpace:(CGFloat)columnSpace
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    //调整间距
    [attributedString addAttribute:(__bridge NSString *)kCTKernAttributeName value:@(columnSpace) range:NSMakeRange(0, [attributedString length])];
    self.attributedText = attributedString;
}

- (void)setRowSpace:(CGFloat)rowSpace
{
    self.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    //调整行距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = rowSpace;
    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = self.textAlignment;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
}

- (void)addTapGestureWithCallback:(ZJTapGestureBlock)onTaped{
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.zj_onTaped = onTaped;
    [self addGestureRecognizer:tap];
    
    objc_setAssociatedObject(self,
                             s_zjChain_label_tapGestureKey,
                             tap,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
