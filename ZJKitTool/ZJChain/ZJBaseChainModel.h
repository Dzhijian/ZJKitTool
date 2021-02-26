//
//  ZJBaseChainModel.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2020/3/22.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "UIGestureRecognizer+ZJActionBlock.h"

NS_ASSUME_NONNULL_BEGIN

#define ZJ_CHAIN_PROPERTY  @property (nonatomic, copy, readonly)


#define  ZJ_CHAIN_IMPLEMENTATION(methodName, viewMethod, ParmaType, ZJViewChainModelType, ZJViewClass) \
- (ZJViewChainModelType (^)(ParmaType param))methodName{ \
    __weak typeof(self) weakSelf = self; \
    if ([self.view.class instancesRespondToSelector:@selector(viewMethod:)]) {\
        return ^(ParmaType param){ \
            [(ZJViewClass *)weakSelf.view viewMethod:param];   \
            return weakSelf; \
        };  \
    }else{  \
        return ^(ParmaType param){ \
            return weakSelf; \
        }; \
    } \
} \


@class MASConstraintMaker;

@interface ZJBaseChainModel <ObjcType>  : NSObject
/// 视图的唯一标示

@property (nonatomic, strong) __kindof UIView *view;

ZJ_CHAIN_PROPERTY ObjcType (^ superView)(UIView *superView);


#pragma mark - AutoLayout
ZJ_CHAIN_PROPERTY ObjcType (^makeMasonry)( void (^constraints)(__kindof UIView *sender, MASConstraintMaker *make) );
ZJ_CHAIN_PROPERTY ObjcType (^updateMasonry)( void (^constraints)(__kindof UIView *sender, MASConstraintMaker *make) );
ZJ_CHAIN_PROPERTY ObjcType (^remakeMasonry)( void (^constraints)(__kindof UIView *sender, MASConstraintMaker *make) );

#pragma mark - # Frame
ZJ_CHAIN_PROPERTY ObjcType (^frame)(CGRect frame);

ZJ_CHAIN_PROPERTY ObjcType (^origin)(CGPoint origin);
ZJ_CHAIN_PROPERTY ObjcType (^backgroundColor)(UIColor *backgroundColor);


ZJ_CHAIN_PROPERTY ObjcType (^contentMode)(UIViewContentMode contentMode);
ZJ_CHAIN_PROPERTY ObjcType (^opaque)(BOOL opaque);
ZJ_CHAIN_PROPERTY ObjcType (^hidden)(BOOL hidden);

#pragma mark - # Layer
ZJ_CHAIN_PROPERTY ObjcType (^cornerRadius)(CGFloat cornerRadius);
ZJ_CHAIN_PROPERTY ObjcType (^borderColor)(CGColorRef borderColor);
ZJ_CHAIN_PROPERTY ObjcType (^borderWidth)(CGFloat borderWidth);
ZJ_CHAIN_PROPERTY ObjcType (^userInteractionEnabled)(BOOL userInteractionEnabled);
ZJ_CHAIN_PROPERTY ObjcType (^clipsToBounds)(BOOL clipsToBounds);

#pragma mark - Shadow
ZJ_CHAIN_PROPERTY ObjcType (^shadowColor)(CGColorRef shadowColor);
ZJ_CHAIN_PROPERTY ObjcType (^shadowOffset)(CGSize shadowOffset);
ZJ_CHAIN_PROPERTY ObjcType (^shadowRadius)(CGFloat shadowRadius);
ZJ_CHAIN_PROPERTY ObjcType (^shadowOpacity)(float shadowOpacity);
ZJ_CHAIN_PROPERTY ObjcType (^shadowPath)(CGRect roundedRect, CGFloat cornerRadius);
ZJ_CHAIN_PROPERTY ObjcType (^masksToBounds)(BOOL masksToBounds);
ZJ_CHAIN_PROPERTY ObjcType (^setShadow)(CGColorRef shadowColor,CGSize shadowOffset,CGFloat shadowRadius,float shadowOpacity);
@end

NS_ASSUME_NONNULL_END
