//
//  UITableViewCell+ZJBaseFunctions.m
//  Community_Pharmacy
//
//  Created by 邓志坚 on 2018/5/5.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

#import "UITableViewCell+ZJBaseFunctions.h"

@implementation UITableViewCell (ZJBaseFunctions)
#pragma mark - UI
- (void)zj_initWithAllView{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.accessoryType = UITableViewCellAccessoryNone;
    
    self.contentView.clipsToBounds = YES;
    
}
#pragma mark - Class;
+ (CGFloat)heightWithModel:(id)model{
    
    return UITableViewAutomaticDimension;
}
+ (CGFloat)height{
    
    return UITableViewAutomaticDimension;
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
