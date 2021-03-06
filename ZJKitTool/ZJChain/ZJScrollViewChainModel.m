//
//  ZJScrollViewChainModel.m
//  ZJKitTool
//
//  Created by 邓志坚 on 2020/4/2.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJScrollViewChainModel.h"
#import <objc/runtime.h>

#define  ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(methodName, viewMethod, ParmaType)  ZJ_CHAIN_IMPLEMENTATION(methodName, viewMethod, ParmaType, ZJScrollViewChainModel * , UIScrollView)

@implementation ZJScrollViewChainModel

ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(delegate, setDelegate, id<UIScrollViewDelegate>)

ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(contentSize, setContentSize, CGSize)
ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(contentOffset, setContentOffset, CGPoint)
ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(contentInset,setContentInset, UIEdgeInsets)

ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(bounces,setBounces, BOOL)
ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(alwaysBounceVertical,setAlwaysBounceVertical, BOOL)
ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(alwaysBounceHorizontal,setAlwaysBounceHorizontal ,BOOL)

ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(pagingEnabled,setPagingEnabled, BOOL)
ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(scrollEnabled,setScrollEnabled, BOOL)

ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(showsHorizontalScrollIndicator,setShowsHorizontalScrollIndicator, BOOL)
ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(showsVerticalScrollIndicator,setShowsVerticalScrollIndicator ,BOOL)

ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(scrollsToTop, setScrollsToTop,BOOL)
@end

@implementation UIScrollView (ZJChain)

- (ZJScrollViewChainModel *)zj_chain{
    
    ZJScrollViewChainModel *model = objc_getAssociatedObject(self, _cmd);
    if (!model) {

        NSAssert(![self isKindOfClass:[ZJScrollViewChainModel class]], @"类型错误");
        model = [ZJScrollViewChainModel new];
        model.view = self;
        objc_setAssociatedObject(self, _cmd, model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
    }
    return model;
}
@end
