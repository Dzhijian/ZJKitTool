//
//  ZJKitBaseController.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

/**
 *  ZJUIKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJUIKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下。😆
 */


#import "ZJKitBaseController.h"
#import <objc/runtime.h>
#import "ZJHelperKit.h"



@interface ZJKitBaseController ()

@property (nonatomic, strong) NSMutableArray *zj_notificationNames;
@property (nonatomic, strong) UIActivityIndicatorView *zj_loadingView;

@end

@implementation ZJKitBaseController

- (void)dealloc {
    [self zj_removeAllNotifications];
    
#if DEBUG
    NSLog(@"%@ dealloc", [[self class] description]);
#endif
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = kWhiteColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    if (@available(iOS 11.0, *)) {
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
#if DEBUG
    NSLog(@"%@ viewDidAppear", [[self class] description]);
#endif
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
#if DEBUG
    NSLog(@"%@ viewDidDisappear", [[self class] description]);
#endif
}

- (UIButton *)zj_leftButtonItem {
    return [[self zj_leftButtonItems] zj_objectAtIndex:0];
}

- (NSArray<UIButton *> *)zj_leftButtonItems {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    NSArray *leftItems = self.navigationItem.leftBarButtonItems;
    for (UIBarButtonItem *item in leftItems) {
        if ([item isKindOfClass:[UIBarButtonItem class]]) {
            if ([item.customView isKindOfClass:[UIButton class]]) {
                [array addObject:item.customView];
            }
        }
    }
    
    return array;
}

- (UIButton *)zj_rightButtonItem {
    return [[self zj_rightButtonItems] zj_objectAtIndex:0];
}

- (NSArray<UIButton *> *)zj_rightButtonItems {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    NSArray *rightItems = self.navigationItem.rightBarButtonItems;
    for (UIBarButtonItem *item in rightItems) {
        if ([item isKindOfClass:[UIBarButtonItem class]]) {
            if ([item.customView isKindOfClass:[UIButton class]]) {
                [array addObject:item.customView];
            }
        }
    }
    
    return array;
}

- (void)zj_adjustNavigationTitleToCenter {
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    
    long previousViewControllerIndex = [viewControllerArray indexOfObject:self] - 1;
    UIViewController *previous;
    
    if (previousViewControllerIndex >= 0) {
        previous = [viewControllerArray objectAtIndex:previousViewControllerIndex];
        previous.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                                     initWithTitle:@" "
                                                     style:UIBarButtonItemStylePlain
                                                     target:self
                                                     action:nil];
    }
}

- (void)zj_setNavTitle:(id)title
             rightTitle:(NSString *)rightTitle
             rightBlock:(ZJButtonBlock)rightBlock {
    if (kIsEmptyString(rightTitle)) {
        return [self zj_setNavTitle:title];
    }
    
    return [self zj_setNavTitle:title rightTitles:@[rightTitle] rightBlock:^(NSUInteger index, UIButton *sender) {
        if (rightBlock) {
            rightBlock(sender);
        }
    }];
}

- (void)zj_setNavTitle:(id)title
            rightTitles:(NSArray<NSString *> *)rightTitles
             rightBlock:(ZJButtonIndexBlock)rightBlock {
    [self zj_setNavTitle:title];
    
    if (kIsArray(rightTitles) && rightTitles.count >= 1) {
        NSUInteger i = 0;
        NSMutableArray *rightButtons = [[NSMutableArray alloc] init];
        for (NSString *title in rightTitles) {
            
            
            
            UIButton *btn = [UIButton zj_buttonWithTitle:title superView:nil constraints:nil touchUp:^(UIButton *sender) {
                if (rightBlock) {
                    rightBlock(i, sender);
                }
            }];
            
            
            
            [rightButtons addObject:btn];
            i++;
        }
        
        [self _zj_setNavItems:rightButtons isLeft:NO];
    }
}

- (void)zj_setNavTitle:(id)title
            rightImages:(NSArray *)rightImages
             rightBlock:(ZJButtonIndexBlock)rightBlock {
    return [self zj_setNavTitle:title
                     rightImages:rightImages
                   rightHgImages:nil
                      rightBlock:rightBlock];
}

- (void)zj_setNavTitle:(id)title
            rightImages:(NSArray *)rightImages
          rightHgImages:(NSArray *)rightHgImages
             rightBlock:(ZJButtonIndexBlock)rightBlock {
    [self zj_setNavTitle:title];
    
    if (kIsArray(rightImages) && rightHgImages.count >= 1) {
        NSUInteger i = 0;
        NSMutableArray *rightButtons = [[NSMutableArray alloc] init];
        for (NSString *imgName in rightImages) {
            NSString *last = [rightHgImages zj_objectAtIndex:i];
            
            UIButton *btn = [UIButton zj_buttonWithNorImage:imgName cornerRadius:0 supView:nil constraints:nil touchUp:^(UIButton *sender) {
                if (rightBlock) {
                    rightBlock(i, sender);
                }
            }];
            
            UIImage *hgImage = nil;
            if ([last isKindOfClass:[UIImage class]]) {
                hgImage = (UIImage *)last;
            } else if ([last isKindOfClass:[NSString class]]) {
                hgImage = kImageName(last);
            }
            
            if (hgImage) {
                [btn setImage:hgImage forState:UIControlStateHighlighted];
            }
            
            [rightButtons addObject:btn];
            i++;
        }
        
        [self _zj_setNavItems:rightButtons isLeft:NO];
    }
}

- (void)zj_setNavLeftButtonTitle:(NSString *)title onCliked:(ZJButtonBlock)block {
    UIButton *btn = [UIButton zj_buttonWithTitle:title
                                        superView:nil
                                      constraints:nil
                                          touchUp:block];
    
    [self _zj_setNavItems:@[btn] isLeft:YES];
}

- (void)zj_setNavLeftImage:(id)image block:(ZJButtonBlock)block {
    UIImage *normalImage = image;
    
    if ([normalImage isKindOfClass:[NSString class]]) {
        normalImage = kImageName(image);
    }
    
    UIButton *btn = [UIButton zj_buttonWithNorImage:image
                                       cornerRadius:0
                                            supView:nil
                                        constraints:nil touchUp:block];
    
    [self _zj_setNavItems:@[btn] isLeft:YES];
}

- (void)zj_setNavTitle:(id)title {
    if ([title isKindOfClass:[NSString class]]) {
        self.navigationItem.title = title;
    } else if ([title isKindOfClass:[UIView class]]) {
        self.navigationItem.titleView = title;
    } else if ([title isKindOfClass:[UIImage class]]) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:(UIImage *)title];
        self.navigationItem.titleView = imageView;
        [imageView sizeToFit];
    }
}

#pragma mark - Notification
- (void)zj_addObserverWithNotificationName:(NSString *)notificationName
                                   callback:(ZJNotificationBlock)callback {
    if (kIsEmptyString(notificationName)) {
        return;
    }
    
    [self zj_addNotificationName:notificationName];
    
    [kNotificationCenter addObserver:self
                            selector:@selector(zj_onRecievedNotification:)
                                name:notificationName
                              object:nil];
    objc_setAssociatedObject(self,
                             (__bridge const void *)(notificationName),
                             callback,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)zj_removeAllNotifications {
    // 移除监听
    for (NSString *name in self.zj_notificationNames) {
        [kNotificationCenter removeObserver:self name:name object:nil];
        // 取消关联
        objc_setAssociatedObject(self,
                                 (__bridge const void *)(name),
                                 nil,
                                 OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    [kNotificationCenter removeObserver:self];
}

- (void)zj_removeAllNotificationWithName:(NSString *)nofiticationName {
    if (kIsEmptyString(nofiticationName)) {
        return;
    }
    
    // 移除监听
    for (NSString *name in self.zj_notificationNames) {
        if ([name isEqualToString:nofiticationName]) {
            [kNotificationCenter removeObserver:self name:name object:nil];
            // 取消关联
            objc_setAssociatedObject(self,
                                     (__bridge const void *)(name),
                                     nil,
                                     OBJC_ASSOCIATION_COPY_NONATOMIC);
            break;
        }
    }
}

- (UIActivityIndicatorView *)zj_startIndicatorAnimating {
    return [self zj_startIndicatorAnimatingWithStyle:UIActivityIndicatorViewStyleGray];
}

- (UIActivityIndicatorView *)zj_startIndicatorAnimatingWithStyle:(UIActivityIndicatorViewStyle)style {
    if (self.zj_loadingView == nil) {
        self.zj_loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
        [self.view addSubview:self.zj_loadingView];
        
        kWeakObject(self);
        if (self.navigationController && self.navigationController.navigationBarHidden == NO) {
            [self.zj_loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakObject.view);
                make.centerY.equalTo(weakObject.view).offset(-64 / 2);
            }];
        } else {
            [self.zj_loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(weakObject.view);
            }];
        }
    }
    
    [self.view bringSubviewToFront:self.zj_loadingView];
    [self.zj_loadingView startAnimating];
    
    return self.zj_loadingView;
}

- (void)zj_stopIndicatorAnimating {
    [self.zj_loadingView stopAnimating];
    
    [self.zj_loadingView removeFromSuperview];
    self.zj_loadingView = nil;
}

#pragma mark - Private
- (void)_zj_setNavItems:(NSArray *)buttons isLeft:(BOOL)isLeft {
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil
                                       action:nil];
    negativeSpacer.width = -8;
    if (kIOSVersion < 7) {
        negativeSpacer.width = 0;
    }
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:buttons.count];
    [items addObject:negativeSpacer];
    
    for (NSUInteger i = 0; i < buttons.count; ++i) {
        UIButton *btn = [buttons zj_objectAtIndex:i];
        [btn sizeToFit];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [items addObject:item];
    }
    
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = items;
    } else {
        self.navigationItem.rightBarButtonItems = items;
    }
}

- (void)zj_addNotificationName:(NSString *)name {
    for (NSString *notificationName in self.zj_notificationNames) {
        if ([notificationName isEqualToString:name]) {
            return;
        }
    }
    
    [self.zj_notificationNames addObject:name];
}

- (void)zj_onRecievedNotification:(NSNotification *)notification {
    for (NSString *name in self.zj_notificationNames) {
        if ([name isEqualToString:notification.name]) {
            ZJNotificationBlock block = objc_getAssociatedObject(self,
                                                                  (__bridge const void *)(notification.name));
            if (block) {
                block(notification);
            }
            
            break;
        }
    }
}

- (NSMutableArray *)zj_notificationNames {
    if (_zj_notificationNames == nil) {
        _zj_notificationNames = [[NSMutableArray alloc] init];
    }
    
    return _zj_notificationNames;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
