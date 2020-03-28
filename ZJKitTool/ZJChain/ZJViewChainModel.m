//
//  ZJViewChainModel.m
//  ZJKitTool
//
//  Created by 邓志坚 on 2020/3/23.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJViewChainModel.h"

#define weak_self(value)     __weak typeof(value) weakSelf = value

#pragma mark - Masonry
#define  ZJ_CHAIN_MASONRY_IMPLEMENTATION(methodType, methodName, masonryMethod, view) \
- (methodType)methodName{  \
    __weak typeof(self) weakSelf = self; \
    return ^ZJViewChainModel * ( void (^constraints)(__kindof UIView *, MASConstraintMaker *) ) { \
        if (weakSelf.chainView.superview) { \
            [view  masonryMethod:^(MASConstraintMaker *make){ \
                constraints(view, make); \
            }]; \
        } \
        return weakSelf; \
    }; \
} \


#define  ZJ_CHAIN_MASONRY_IMPLEMENTATION_NULL(methodType, methodName, masonryMethod) \
- (methodType)methodName{ \
    __weak typeof(self) weakSelf = self; \
    return ^id ( void (^constraints)(__kindof UIView *, MASConstraintMaker *) ) { \
        return weakSelf; \
    }; \
}\

#pragma mark - Shadow
#define  ZJ_CHAIN_SHADOW_IMPLEMENTATION(methodType, methodName, layerMethod, view, ParmaType) \
- (methodType)methodName{ \
    weak_self(self); \
    return ^(ParmaType parma){ \
        [view.layer layerMethod:parma]; \
        return weakSelf; \
    }; \
} \

#define  ZJ_CHAIN_VIEW_IMPLEMENTATION(className, methodType, methodName, viewMethod, ParmaType) \
- (methodType)methodName{ \
   __weak typeof(self) weakSelf = self; \
    if ([self.chainView.class instancesRespondToSelector:@selector(viewMethod:)]) { \
        return ^(ParmaType param){ \
            [(className *)weakSelf.chainView viewMethod:param]; \
            return weakSelf; \
        }; \
    } \
    return ^(ParmaType paramt){ \
        NSLog(@" ❌ 当前对象使用类:%@,不能使用此方法:%s ", NSStringFromClass(self.chainView.class),__func__); \
        return weakSelf; \
    }; \
} \



@implementation ZJViewChainModel

//#pragma mark - Masonry
//#if __has_include(<Masonry.h>) || __has_include("Masonry.h")
//
//ZJ_CHAIN_MASONRY_IMPLEMENTATION(makeMasonry, makeMasonry, mas_makeConstraints, self.chainView);
//ZJ_CHAIN_MASONRY_IMPLEMENTATION(updateMasonry, updateMasonry, mas_updateConstraints, self.chainView);
//ZJ_CHAIN_MASONRY_IMPLEMENTATION(remakeMasonry, remakeMasonry, mas_remakeConstraints, self.chainView);
//
//#else
//ZJ_CHAIN_MASONRY_IMPLEMENTATION_NULL(makeMasonry, makeMasonry, mas_makeConstraints);
//ZJ_CHAIN_MASONRY_IMPLEMENTATION_NULL(updateMasonry, updateMasonry, mas_updateConstraints);
//ZJ_CHAIN_MASONRY_IMPLEMENTATION_NULL(remakeMasonry, remakeMasonry, mas_remakeConstraints);
//
//#endif

//
//- (frame)frame{
//    __weak typeof(self) weakSelf = self;
//    return ^(CGRect frame){
//        weakSelf.chainView.frame = frame;
//        return weakSelf;
//    };
//}
//
//- (background_color)background_color{
//    __weak typeof(self) weakSelf = self;
//    return ^(UIColor *background_color){
//        weakSelf.chainView.backgroundColor = background_color;
//        return weakSelf;
//    };
//}
//
//- (border_color)border_color{
//    __weak typeof(self) weakSelf = self;
//    return ^(UIColor *border_color){
//        weakSelf.chainView.layer.borderColor = border_color.CGColor;
//        return weakSelf;
//    };
//}
//
//- (border_width)border_width{
//    __weak typeof(self) weakSelf = self;
//    return ^(CGFloat border_width){
//        weakSelf.chainView.layer.borderWidth = border_width;
//        return weakSelf;
//    };
//}
//
//- (userInteraction_enabled)userInteraction_enabled{
//    __weak typeof(self) weakSelf = self;
//       return ^(BOOL userInteraction_enabled){
//           weakSelf.chainView.userInteractionEnabled = userInteraction_enabled;
//           return weakSelf;
//       };
//}

#pragma mark - Shadow

//ZJ_CHAIN_SHADOW_IMPLEMENTATION(shadowRadius, shadowRadius, setShadowRadius, self.chainView, CGFloat);
//ZJ_CHAIN_SHADOW_IMPLEMENTATION(shadowColor, shadowColor, setShadowColor, self.chainView, CGColorRef);
//ZJ_CHAIN_SHADOW_IMPLEMENTATION(shadowOpacity, shadowOpacity, setShadowOpacity, self.chainView, float);
//ZJ_CHAIN_SHADOW_IMPLEMENTATION(shadowOffset, shadowOffset, setShadowOffset, self.chainView, CGSize);
//ZJ_CHAIN_SHADOW_IMPLEMENTATION(layerMasksToBounds, layerMasksToBounds, setMasksToBounds, self.chainView, BOOL);

//
//- (shadowPath)shadowPath{
//    weak_self(self);
//    return ^(CGRect roundedRect, CGFloat cornerRadius){
//        [weakSelf.chainView.layer setShadowPath:[UIBezierPath bezierPathWithRoundedRect:roundedRect cornerRadius:cornerRadius].CGPath];
//        return weakSelf;
//    };
//}
//
//- (setShadow)setShadow{
//    weak_self(self);
//    return ^(CGColorRef shadowColor,CGSize shadowOffset,CGFloat shadowRadius,float shadowOpacity){
//        [weakSelf.chainView.layer setShadowColor:shadowColor];
//        [weakSelf.chainView.layer setShadowOffset:shadowOffset];
//        [weakSelf.chainView.layer setShadowRadius:shadowRadius];
//        [weakSelf.chainView.layer setShadowOpacity:shadowOpacity];
//        return weakSelf;
//    };
//}

#pragma mark - Label
//ZJ_CHAIN_VIEW_IMPLEMENTATION(UILabel, text, lab_text, setText, NSString *);
//ZJ_CHAIN_VIEW_IMPLEMENTATION(UILabel, text_color, lab_text_color, setTextColor, UIColor *);
//ZJ_CHAIN_VIEW_IMPLEMENTATION(UILabel, font, lab_font, setFont, UIFont *);
//ZJ_CHAIN_VIEW_IMPLEMENTATION(UILabel, textAlignment, lab_textAlignment, setTextAlignment, NSTextAlignment);
//ZJ_CHAIN_VIEW_IMPLEMENTATION(UILabel, numberOfLines, lab_numberOfLines, setNumberOfLines, NSInteger);

#pragma mark - TextField
//ZJ_CHAIN_VIEW_IMPLEMENTATION(UITextField, text, tf_text, setText, NSString *);
//ZJ_CHAIN_VIEW_IMPLEMENTATION(UITextField, text_color, tf_text_color, setTextColor, UIColor *);
//ZJ_CHAIN_VIEW_IMPLEMENTATION(UITextField, font, tf_font, setFont, UIFont *);
//ZJ_CHAIN_VIEW_IMPLEMENTATION(UITextField, textAlignment, tf_textAlignment, setTextAlignment, NSTextAlignment);
//ZJ_CHAIN_VIEW_IMPLEMENTATION(UITextField, text, tf_text, setText, NSString *);
//ZJ_CHAIN_VIEW_IMPLEMENTATION(UITextField, text, tf_text, setText, NSString *);
//ZJ_CHAIN_VIEW_IMPLEMENTATION(UITextField, text, tf_text, setText, NSString *);
//ZJ_CHAIN_VIEW_IMPLEMENTATION(UITextField, text, tf_text, setText, NSString *);
//ZJ_CHAIN_VIEW_IMPLEMENTATION(UITextField, text, tf_text, setText, NSString *);
//ZJ_CHAIN_VIEW_IMPLEMENTATION(UITextField, text, tf_text, setText, NSString *);

@end

@implementation UIView (ZJChain)



- (ZJViewChainModel *)zj_chain{
    
    ZJViewChainModel *model = objc_getAssociatedObject(self, _cmd);
    if (!model) {

        NSAssert(![self isKindOfClass:[ZJViewChainModel class]], @"类型错误");

        model = [ZJViewChainModel new];
        model.view = self;
        objc_setAssociatedObject(self, _cmd, model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
    }
    return model;
}

@end
