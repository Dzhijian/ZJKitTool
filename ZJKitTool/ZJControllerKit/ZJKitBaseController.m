//
//  ZJKitBaseController.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

/**
 *  ZJKitTool
 *
 *  GitHub地址：https://github.com/Dzhijian/ZJKitTool
 *
 *  本库会不断更新工具类，以及添加一些模块案例，请各位大神们多多指教，支持一下。😆
 */


#import "ZJKitBaseController.h"
#import <objc/runtime.h>
#import "ZJGeneraMacros.h"


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
    self.view.backgroundColor = [UIColor whiteColor];
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
    
    return [self zj_objecWtithArray:[self zj_leftButtonItems] AtIndex:0];
}

/**
 * 返回安全的索引
 
 @param index 索引
 */
-(id)zj_objecWtithArray:(NSArray *)array AtIndex:(NSInteger)index{
    NSInteger count = [array count];
    if (count > 0 && index < count) {
        return  [array objectAtIndex:index];
    }
    return nil;
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
    return [self zj_objecWtithArray:[self zj_rightButtonItems] AtIndex:0];

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
             rightBlock:(ZJButtonActionBlock)rightBlock {
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
            rightBlock:(ZJButtonActionIndexBlock)rightBlock {
    [self zj_setNavTitle:title];
    
    if (kIsArray(rightTitles) && rightTitles.count >= 1) {
        NSUInteger i = 0;
        NSMutableArray *rightButtons = [[NSMutableArray alloc] init];
        for (NSString *title in rightTitles) {
            
            
            UIButton *btn = [self buttonWithTitle:title
                                       titleColor:nil
                                         norImage:nil
                                     cornerRadius:0
                                          supView:nil
                                      constraints:nil
                                          touchUp:^(id sender) {
                                              
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
             rightBlock:(ZJButtonActionIndexBlock)rightBlock {
    
    return  [self zj_setNavTitle:title
                     rightImages:rightImages
                   rightHgImages:nil
                      rightBlock:rightBlock];
    
}


- (void)zj_setNavTitle:(id)title

           rightImages:(NSArray *)rightImages

         rightHgImages:(NSArray *)rightHgImages

            rightBlock:(ZJButtonActionIndexBlock)rightBlock {

    [self zj_setNavTitle:title];
    
    if (kIsArray(rightImages) && rightHgImages.count >= 1) {
        NSUInteger i = 0;
        
        NSMutableArray *rightButtons = [[NSMutableArray alloc] init];
        
        for (NSString *imgName in rightImages) {
            
            NSString *last = [self zj_objecWtithArray:rightHgImages AtIndex:i]; 

            UIButton *btn = [self buttonWithTitle:nil
                                       titleColor:nil
                                         norImage:imgName
                                     cornerRadius:0
                                          supView:nil
                                      constraints:nil
                                          touchUp:^(id sender) {
                                              
                                              if (rightBlock) {
                                                  
                                                  rightBlock(i, sender);
                                                  
                                              }
                                          }];
            
            UIImage *hgImage = nil;
            if ([last isKindOfClass:[UIImage class]]) {
                hgImage = (UIImage *)last;
            } else if ([last isKindOfClass:[NSString class]]) {
                hgImage = [UIImage imageNamed:last];
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

- (void)zj_setNavLeftButtonTitle:(NSString *)title onCliked:(ZJButtonActionBlock)block {
    

    UIButton *btn = [self buttonWithTitle:title
                               titleColor:nil
                                 norImage:nil
                             cornerRadius:0
                                  supView:nil
                              constraints:nil
                                  touchUp:block];
    
    [self _zj_setNavItems:@[btn] isLeft:YES];

}

- (void)zj_setNavLeftImage:(id)image block:(ZJButtonActionBlock)block {
    UIImage *normalImage = image;
    
    if ([normalImage isKindOfClass:[NSString class]]) {
        normalImage = [UIImage imageNamed:image];
    }

    
    UIButton *btn = [self buttonWithTitle:nil
                               titleColor:nil
                                 norImage:image
                             cornerRadius:0
                                  supView:nil
                              constraints:nil
                                  touchUp:block];
    
    [self _zj_setNavItems:@[btn] isLeft:YES];
}


/**
 *  设置导航栏右边的 baritem
 *  @param title  标题文本
 */
- (void)zj_setNavRightButtonTitle:(NSString *)title onCliked:(ZJButtonActionBlock)block{
    UIButton *btn = [self buttonWithTitle:title
                               titleColor:nil
                                 norImage:nil
                             cornerRadius:0
                                  supView:nil
                              constraints:nil
                                  touchUp:block];
    
    [self _zj_setNavItems:@[btn] isLeft:NO];
}
/**
 *  设置导航栏右边的 baritem
 *  @param image 图片 或 图片名称
 */
- (void)zj_setNavRightImage:(id)image block:(ZJButtonActionBlock)block{
    UIImage *normalImage = image;
    
    if ([normalImage isKindOfClass:[NSString class]]) {
        normalImage = [UIImage imageNamed:image];
    }
    
    UIButton *btn = [self buttonWithTitle:nil
                               titleColor:nil
                                 norImage:normalImage
                             cornerRadius:0
                                  supView:nil
                              constraints:nil
                                  touchUp:block];
    
    [self _zj_setNavItems:@[btn] isLeft:NO];
    
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
                                   callback:(void (^)(NSNotification *sender))callback {
    if (kIsEmptyString(notificationName)) {
        return;
    }
    
    [self zj_addNotificationName:notificationName];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
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
        [[NSNotificationCenter defaultCenter] removeObserver:self name:name object:nil];
        // 取消关联
        objc_setAssociatedObject(self,
                                 (__bridge const void *)(name),
                                 nil,
                                 OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)zj_removeAllNotificationWithName:(NSString *)nofiticationName {
    if (kIsEmptyString(nofiticationName)) {
        return;
    }
    
    // 移除监听
    for (NSString *name in self.zj_notificationNames) {
        if ([name isEqualToString:nofiticationName]) {
            [[NSNotificationCenter defaultCenter] removeObserver:self name:name object:nil];
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
        
        __weak __typeof(self) weakObject = self;
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
        UIButton *btn = [self zj_objecWtithArray:buttons AtIndex:i];
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

/**
 * 快速创建UIButton，设置：标题，标题颜色，默认图片，选中的图片，背景颜色，字体大小，是否加粗，边框宽度，边框颜色，圆角，父视图，Marsonry布局
 
 @param title           标题
 @param titleColor      标题颜色
 @param norImage        默认图片
 @param supView         父视图
 @param constaints      Marsonry布局
 @param touchUp         点击事件
 @return                返回一个 button
 */
-(UIButton *)buttonWithTitle:(NSString *)title
                       titleColor:(UIColor *)titleColor
                         norImage:(id)norImage
                     cornerRadius:(CGFloat)cornerRadius
                          supView:(UIView *)supView
                      constraints:(ZJConstrainMaker)constaints
                          touchUp:(ZJButtonActionBlock)touchUp
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.zj_btnOnTouchUp = touchUp;
    
    if (!kIsEmptyString(title)) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }else{
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    
    UIImage *normalImage = nil;
    if ([norImage isKindOfClass:[NSString class]]) {
        normalImage = [UIImage imageNamed:norImage];
    }else if([norImage isKindOfClass:[UIImage class]]){
        normalImage = norImage;
    }
    
    if (normalImage) {
        [button setImage:normalImage forState:UIControlStateNormal];
    }

    
    button.layer.cornerRadius = cornerRadius;

    [supView addSubview:button];
    
    if (supView && constaints) {
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            constaints(make);
        }];
    }
    
    return button;
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
