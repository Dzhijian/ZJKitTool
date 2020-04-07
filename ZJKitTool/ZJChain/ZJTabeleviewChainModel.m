//
//  ZJTabeleviewChainModel.m
//  ZJKitTool
//
//  Created by 邓志坚 on 2020/3/29.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "ZJTabeleviewChainModel.h"
#import <objc/runtime.h>

#define  ZJ_CHAIN_TABLEVIEW_IMPLEMENTATION(methodName, viewMethod, ParmaType)  ZJ_CHAIN_IMPLEMENTATION(methodName, viewMethod, ParmaType, ZJTabeleviewChainModel * , UITableView)
#define  ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(methodName, viewMethod, ParmaType)  ZJ_CHAIN_IMPLEMENTATION(methodName, viewMethod, ParmaType, ZJTabeleviewChainModel * , UITableView)
@implementation ZJTabeleviewChainModel


ZJ_CHAIN_TABLEVIEW_IMPLEMENTATION(delegate, setDelegate, id<UITableViewDelegate>)
ZJ_CHAIN_TABLEVIEW_IMPLEMENTATION(dataSource, setDataSource, id<UITableViewDataSource>)

ZJ_CHAIN_TABLEVIEW_IMPLEMENTATION(rowHeight, setRowHeight, CGFloat)
ZJ_CHAIN_TABLEVIEW_IMPLEMENTATION(sectionHeaderHeight, setSectionHeaderHeight, CGFloat)
ZJ_CHAIN_TABLEVIEW_IMPLEMENTATION(sectionFooterHeight,setSectionFooterHeight ,CGFloat)
ZJ_CHAIN_TABLEVIEW_IMPLEMENTATION(estimatedRowHeight,setEstimatedRowHeight, CGFloat)
ZJ_CHAIN_TABLEVIEW_IMPLEMENTATION(estimatedSectionHeaderHeight,setEstimatedSectionHeaderHeight ,CGFloat)
ZJ_CHAIN_TABLEVIEW_IMPLEMENTATION(estimatedSectionFooterHeight,setEstimatedSectionFooterHeight ,CGFloat)
ZJ_CHAIN_TABLEVIEW_IMPLEMENTATION(separatorInset,setSeparatorInset ,UIEdgeInsets)


ZJ_CHAIN_TABLEVIEW_IMPLEMENTATION(editing,setEditing ,BOOL)
ZJ_CHAIN_TABLEVIEW_IMPLEMENTATION(allowsSelection, setAllowsSelection,BOOL)
ZJ_CHAIN_TABLEVIEW_IMPLEMENTATION(allowsMultipleSelection,setAllowsMultipleSelection, BOOL)
ZJ_CHAIN_TABLEVIEW_IMPLEMENTATION(allowsSelectionDuringEditing,setAllowsSelectionDuringEditing, BOOL)
ZJ_CHAIN_TABLEVIEW_IMPLEMENTATION(allowsMultipleSelectionDuringEditing,setAllowsMultipleSelectionDuringEditing ,BOOL)

ZJ_CHAIN_TABLEVIEW_IMPLEMENTATION(separatorStyle, setSeparatorStyle,UITableViewCellSeparatorStyle)
ZJ_CHAIN_TABLEVIEW_IMPLEMENTATION(separatorColor, setSeparatorColor,UIColor *)

ZJ_CHAIN_TABLEVIEW_IMPLEMENTATION(tableHeaderView,setTableHeaderView,UIView *)
ZJ_CHAIN_TABLEVIEW_IMPLEMENTATION(tableFooterView,setTableFooterView, UIView *)

ZJ_CHAIN_TABLEVIEW_IMPLEMENTATION(sectionIndexBackgroundColor, setSectionIndexBackgroundColor,UIColor *)
ZJ_CHAIN_TABLEVIEW_IMPLEMENTATION(sectionIndexColor, setSectionIndexColor,UIColor *)

#pragma mark - UIScrollView
ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(contentSize,setContentSize ,CGSize)
ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(contentOffset, setContentOffset,CGPoint)
ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(contentInset, setContentInset,UIEdgeInsets)

ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(bounces, setBounces,BOOL)
ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(alwaysBounceVertical, setAlwaysBounceVertical,BOOL)
ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(alwaysBounceHorizontal, setAlwaysBounceHorizontal,BOOL)

ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(pagingEnabled, setPagingEnabled,BOOL)
ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(scrollEnabled, setScrollEnabled,BOOL)

ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(showsHorizontalScrollIndicator, setShowsHorizontalScrollIndicator, BOOL)
ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(showsVerticalScrollIndicator, setShowsVerticalScrollIndicator,BOOL)

ZJ_CHAIN_SCROLLVIEW_IMPLEMENTATION(scrollsToTop, setScrollsToTop,BOOL)

@end

@implementation UITableView (ZJChain)

- (ZJTabeleviewChainModel *)zj_chain{
    
    ZJTabeleviewChainModel *model = objc_getAssociatedObject(self, _cmd);
    if (!model) {

        NSAssert(![self isKindOfClass:[ZJTabeleviewChainModel class]], @"类型错误");
        model = [ZJTabeleviewChainModel new];
        model.view = self;
        objc_setAssociatedObject(self, _cmd, model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
    }
    return model;
}
@end
