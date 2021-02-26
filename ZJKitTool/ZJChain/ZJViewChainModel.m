//
//  ZJViewChainModel.m
//  ZJKitTool
//
//  Created by 邓志坚 on 2020/3/23.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJViewChainModel.h"

#import <objc/runtime.h>

static const void *s_zjChain_tapGestureKey = "s_zjChain_tapGestureKey";
static const void *s_zjChain_longGestureKey = "s_zjChain_longGestureKey";
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

- (ZJViewChainModel * _Nonnull (^)(ZJTapGestureBlock ))onTap{
    __weak typeof(self) weakSelf = self;
    return ^ZJViewChainModel* (ZJTapGestureBlock tap) {
        [weakSelf.view addTapGestureWithCallback:tap];
        return weakSelf;
    };
}

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


//- (UITapGestureRecognizer *)zj_tapGesture {
//    return objc_getAssociatedObject(self, s_zj_tapGestureKey);
//}
//
//- (UILongPressGestureRecognizer *)zj_longGesure {
//    return objc_getAssociatedObject(self, s_zj_longGestureKey);
//}

- (void)addTapGestureWithCallback:(ZJTapGestureBlock)onTaped{
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.zj_onTaped = onTaped;
    [self addGestureRecognizer:tap];
    
    objc_setAssociatedObject(self,
                             s_zjChain_tapGestureKey,
                             tap,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)addLongGestureWithCallback:(ZJLongGestureBlock)onLongPressed {
    self.userInteractionEnabled = YES;
    
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] init];
    gesture.zj_onLongPressed = onLongPressed;
    [self addGestureRecognizer:gesture];
    
    objc_setAssociatedObject(self,
                             s_zjChain_longGestureKey,
                             gesture,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
