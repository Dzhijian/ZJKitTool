//
//  ZJButtonChainModel.m
//  ZJKitTool
//
//  Created by 邓志坚 on 2020/3/28.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJButtonChainModel.h"
#import <objc/runtime.h>

#define  ZJ_CHAIN_BUTTON_IMPLEMENTATION(methodName, viewMethod, ParmaType)  ZJ_CHAIN_IMPLEMENTATION(methodName, viewMethod, ParmaType, ZJButtonChainModel * , UIButton)

#define  ZJ_CHAIN_UIBUTTON_IMPLEMENTATION(methodType, methodName, viewMethod, ParmaType, StateType) \
- (methodType)methodName{ \
   __weak typeof(self) weakSelf = self; \
if ([self.view.class instancesRespondToSelector:@selector(viewMethod:forState:)]) { \
        return ^(ParmaType param, StateType state){ \
            [(UIButton *)weakSelf.view viewMethod:param forState:state]; \
            return weakSelf; \
        }; \
    } \
    return ^(ParmaType paramt, StateType state){ \
        NSLog(@" ❌ 当前对象使用类:%@,不能使用此方法:%s ", NSStringFromClass(self.view.class),__func__); \
        return weakSelf; \
    }; \
} \


static const void *s_ZJButtonChainTouchUpKey     = "s_ZJButtonChainTouchUpKey";

@implementation ZJButtonChainModel

//ZJ_CHAIN_BUTTON_IMPLEMENTATION(title, title, setTitle, NSString *, UIControlState);
- (ZJButtonChainModel * _Nullable (^)(NSString * _Nonnull, UIControlState))title{
    __weak typeof(self) weakSelf = self;
    if ([self.view.class instancesRespondToSelector:@selector(setTitle:forState:)]) {
        return ^(NSString *title, UIControlState state ){
            [(UIButton *)weakSelf.view setTitle:title forState:state];
            return weakSelf;
        };
    }
    return ^(NSString *title,UIControlState state){
        NSLog(@" ❌ 当前对象使用类:%@,不能使用此方法:%s ", NSStringFromClass(self.view.class),__func__);
        return weakSelf;
    };
}
- (ZJButtonChainModel * _Nullable (^)(UIColor * _Nonnull, UIControlState))titleColor{
    __weak typeof(self) weakSelf = self;
    if ([self.view.class instancesRespondToSelector:@selector(setTitleColor:forState:)]) {
        return ^(UIColor *titleColor, UIControlState state ){
            [(UIButton *)weakSelf.view setTitleColor:titleColor forState:state];
            return weakSelf;
        };
    }
    return ^(UIColor *title, UIControlState state ){
        NSLog(@" ❌ 当前对象使用类:%@,不能使用此方法:%s ", NSStringFromClass(self.view.class),__func__);
        return weakSelf;
    };
}
- (ZJButtonChainModel * _Nullable (^)(UIFont * _Nonnull))titleFont{
    __weak typeof(self) weakSelf = self;
       return ^(UIFont *titleFont){
           [((UIButton *)weakSelf.view).titleLabel setFont:titleFont];
           return weakSelf;
       };
}

- (ZJButtonChainModel * _Nullable (^)(NSAttributedString * _Nonnull, UIControlState))attributedTitle{
    __weak typeof(self) weakSelf = self;
    if ([self.view.class instancesRespondToSelector:@selector(setAttributedTitle:forState:)]) {
        return ^(NSAttributedString *attributedTitle, UIControlState state ){
            [(UIButton *)weakSelf.view setAttributedTitle:attributedTitle forState:state];
            return weakSelf;
        };
    }
    return ^(NSAttributedString *attributedTitle, UIControlState state){
        NSLog(@" ❌ 当前对象使用类:%@,不能使用此方法:%s ", NSStringFromClass(self.view.class),__func__);
        return weakSelf;
    };
}

- (ZJButtonChainModel * _Nullable (^)(UIImage * _Nonnull, UIControlState))image{
    __weak typeof(self) weakSelf = self;
    if ([self.view.class instancesRespondToSelector:@selector(setImage:forState:)]) {
        return ^(UIImage *image, UIControlState state){
            [(UIButton *)weakSelf.view setImage:image forState:state];
            return weakSelf;
        };
    }
    return ^(UIImage *image, UIControlState state){
        NSLog(@" ❌ 当前对象使用类:%@,不能使用此方法:%s ", NSStringFromClass(self.view.class),__func__);
        return weakSelf;
    };
}

- (ZJButtonChainModel * _Nullable (^)(UIImage * _Nonnull, UIControlState))backgroundImage{
    __weak typeof(self) weakSelf = self;
         if ([self.view.class instancesRespondToSelector:@selector(setBackgroundImage:forState:)]) {
             return ^(UIImage *image, UIControlState state){
                 [(UIButton *)weakSelf.view setBackgroundImage:image forState:state];
                 return weakSelf;
             };
         }
         return ^(UIImage *image, UIControlState state){
             NSLog(@" ❌ 当前对象使用类:%@,不能使用此方法:%s ", NSStringFromClass(self.view.class),__func__);
             return weakSelf;
         };
}

- (ZJButtonChainModel * _Nullable (^)(UIColor * _Nonnull, UIControlState))backgroundColorState{
    __weak typeof(self) weakSelf = self;
    if ([self.view.class instancesRespondToSelector:@selector(setBackgroundImage:forState:)]) {
        return ^(UIColor *color, UIControlState state ){
            [(UIButton *)weakSelf.view setBackgroundImage:[self zj_imageWithColor:color] forState:state];
            return weakSelf;
        };
    }
    return ^(UIColor *title, UIControlState state ){
        NSLog(@" ❌ 当前对象使用类:%@,不能使用此方法:%s ", NSStringFromClass(self.view.class),__func__);
        return weakSelf;
    };
}


ZJ_CHAIN_BUTTON_IMPLEMENTATION(contentEdgeInsets,setContentEdgeInsets,UIEdgeInsets);
ZJ_CHAIN_BUTTON_IMPLEMENTATION(titleEdgeInsets,setTitleEdgeInsets,UIEdgeInsets);
ZJ_CHAIN_BUTTON_IMPLEMENTATION(imageEdgeInsets,setImageEdgeInsets,UIEdgeInsets);

ZJ_CHAIN_BUTTON_IMPLEMENTATION(enabled,setEnabled,BOOL);
ZJ_CHAIN_BUTTON_IMPLEMENTATION(selected,setSelected,BOOL);
ZJ_CHAIN_BUTTON_IMPLEMENTATION(highlighted,setHighlighted,BOOL);

- (UIImage *)zj_imageWithColor:(UIColor *)color{
    if (!color) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (ZJButtonChainModel * _Nullable (^)(ZJButtonChainBlock _Nonnull))onTouchUp{
    __weak typeof(self) weakSelf = self;
    return ^ZJButtonChainModel* _Nullable(ZJButtonChainBlock onTouchUp) {
        ((UIButton *)weakSelf.view).onTouchUp = onTouchUp;
        return weakSelf;
    };
}
@end


@implementation UIButton (ZJChain)

- (ZJButtonChainModel *)zj_chain{
    
    ZJButtonChainModel *model = objc_getAssociatedObject(self, _cmd);
    if (!model) {

        NSAssert(![self isKindOfClass:[ZJButtonChainModel class]], @"类型错误");

        model = [ZJButtonChainModel new];
        model.view = self;
        objc_setAssociatedObject(self, _cmd, model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
    }
    return model;
}

-(ZJButtonChainBlock)onTouchUp{
    return objc_getAssociatedObject(self, s_ZJButtonChainTouchUpKey);
}

-(void)setOnTouchUp:(ZJButtonChainBlock)onTouchUp{
    objc_setAssociatedObject(self, s_ZJButtonChainTouchUpKey, onTouchUp, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self removeTarget:self action:@selector(zj_chain_private_onTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    
    if (onTouchUp) {
        [self addTarget:self action:@selector(zj_chain_private_onTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

-(void)zj_chain_private_onTouchUp:(id)sender{
    ZJButtonChainBlock block  = [self onTouchUp];
    if (block) {
        block(sender);
    }
}
@end
