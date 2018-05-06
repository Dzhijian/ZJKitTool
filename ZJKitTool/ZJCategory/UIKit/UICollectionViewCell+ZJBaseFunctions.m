//
//  UICollectionViewCell+ZJBaseFunctions.m
//  Community_Pharmacy
//
//  Created by 邓志坚 on 2018/5/5.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

#import "UICollectionViewCell+ZJBaseFunctions.h"

@implementation UICollectionViewCell (ZJBaseFunctions)
#pragma mark - UI
- (void)zj_initWithAllView{
    
    self.contentView.clipsToBounds = YES;
    
}
#pragma mark - Class
+ (CGSize)itemSizeWithModel:(id)model{
    
    return CGSizeMake(0.f,0.f);
}
+ (CGSize)itemSize{
    
    return CGSizeMake(0.f,0.f);
}
+ (NSString *)identifierWithModel:(id)model{
    
    return NSStringFromClass([self class]);
}
+ (NSString *)identifier{
    
    return NSStringFromClass([self class]);
}
#pragma mark -  Notification
- (void)removeNotification{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end
