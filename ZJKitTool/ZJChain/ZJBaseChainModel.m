//
//  ZJBaseChainModel.m
//  ZJKitTool
//
//  Created by 邓志坚 on 2020/3/22.
//  Copyright © 2020 kapokcloud. All rights reserved.
//


#import "ZJBaseChainModel.h"
#import "UIView+ZJChainFrame.h"

#import <objc/runtime.h>
#define weak_self(value)     __weak typeof(value) weakSelf = value

#define  ZJ_CHAIN_VIEW_IMPLEMENTATION(methodName, viewMethod, ParmaType)  ZJ_CHAIN_IMPLEMENTATION(methodName, viewMethod, ParmaType, id , UIView)

#pragma mark - Masonry
#define  ZJ_CHAIN_MASONRY_IMPLEMENTATION(methodName, masonryMethod) \
- (id (^)( void (^constraints)(__kindof UIView *, MASConstraintMaker *)))methodName{  \
    __weak typeof(self) weakSelf = self; \
    return ^id ( void (^constraints)(__kindof UIView *, MASConstraintMaker *) ) { \
        if (weakSelf.view.superview) { \
            [weakSelf.view  masonryMethod:^(MASConstraintMaker *make){ \
                constraints(weakSelf.view, make); \
            }]; \
        } \
        return weakSelf; \
    }; \
} \


#define  ZJ_CHAIN_MASONRY_IMPLEMENTATION_NULL(methodName, masonryMethod) \
- (id (^)( void (^constraints)(__kindof UIView *, MASConstraintMaker *)) )methodName    \
{   \
    __weak typeof(self) weakSelf = self; \
    return ^id ( void (^constraints)(__kindof UIView *, MASConstraintMaker *) ) {  \
        return weakSelf;    \
    };  \
}

#define  ZJ_CHAIN_VIEW_lAYER_IMPLEMENTATION(methodName, viewMethod, ParmaType) \
- (id  _Nonnull (^)(ParmaType param))methodName{ \
    __weak typeof(self) weakSelf = self; \
    if ([self.view.layer.class instancesRespondToSelector:@selector(viewMethod:)]) {\
        return ^(ParmaType param){ \
            [weakSelf.view.layer viewMethod:param];   \
            return weakSelf; \
        };  \
    }else{  \
        return ^(ParmaType param){ \
            return weakSelf; \
        }; \
    } \
} \

@implementation ZJBaseChainModel

#pragma mark - Masonry
#if __has_include(<Masonry.h>) || __has_include("Masonry.h")

ZJ_CHAIN_MASONRY_IMPLEMENTATION(makeMasonry, mas_makeConstraints);
ZJ_CHAIN_MASONRY_IMPLEMENTATION(updateMasonry, mas_updateConstraints);
ZJ_CHAIN_MASONRY_IMPLEMENTATION(remakeMasonry, mas_remakeConstraints);

#else
ZJ_CHAIN_MASONRY_IMPLEMENTATION_NULL(makeMasonry, mas_makeConstraints);
ZJ_CHAIN_MASONRY_IMPLEMENTATION_NULL(updateMasonry, mas_updateConstraints);
ZJ_CHAIN_MASONRY_IMPLEMENTATION_NULL(remakeMasonry, mas_remakeConstraints);

#endif


ZJ_CHAIN_VIEW_IMPLEMENTATION(frame, setFrame, CGRect);
ZJ_CHAIN_VIEW_IMPLEMENTATION(origin, setOrigin, CGPoint);

ZJ_CHAIN_VIEW_IMPLEMENTATION(backgroundColor, setBackgroundColor, UIColor *);
ZJ_CHAIN_VIEW_IMPLEMENTATION(userInteractionEnabled, setUserInteractionEnabled, BOOL);
ZJ_CHAIN_VIEW_IMPLEMENTATION(clipsToBounds, setClipsToBounds, BOOL);
ZJ_CHAIN_VIEW_IMPLEMENTATION(contentMode, setContentMode, UIViewContentMode);


#pragma mark - Layer
ZJ_CHAIN_VIEW_lAYER_IMPLEMENTATION(borderColor, setBorderColor, CGColorRef);
ZJ_CHAIN_VIEW_lAYER_IMPLEMENTATION(borderWidth, setBorderWidth, CGFloat);
ZJ_CHAIN_VIEW_lAYER_IMPLEMENTATION(cornerRadius, setCornerRadius, CGFloat);

ZJ_CHAIN_VIEW_lAYER_IMPLEMENTATION(shadowColor, setShadowColor, CGColorRef);
ZJ_CHAIN_VIEW_lAYER_IMPLEMENTATION(shadowRadius, setShadowRadius, CGFloat);
ZJ_CHAIN_VIEW_lAYER_IMPLEMENTATION(shadowOffset, setShadowOffset, CGSize);
ZJ_CHAIN_VIEW_lAYER_IMPLEMENTATION(shadowOpacity, setShadowOpacity, float);
ZJ_CHAIN_VIEW_lAYER_IMPLEMENTATION(masksToBounds, setMasksToBounds, BOOL);

- (id  _Nonnull (^)(UIView * _Nonnull))superView{
    __weak typeof(self) weakSelf = self;
    return  ^(UIView * _Nonnull superView) {
        [superView addSubview:weakSelf.view];
        return weakSelf;
    };
    
}



@end
