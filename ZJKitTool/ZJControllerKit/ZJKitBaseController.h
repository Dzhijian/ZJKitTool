//
//  ZJKitBaseController.h
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIControl+ZJActionBlock.h"
#import <Masonry/Masonry.h>
/**
 * For notification block.
 */
typedef void (^ZJNotificationBlock)(NSNotification *sender);
/**
 * Masonry Block
 *
 */
typedef void(^ZJConstrainMaker)(MASConstraintMaker *make);
/**
 * Button点击事件Block
 *
 * @param index  索引.
 * @param sender The responder.
 */
typedef void(^ZJButtonActionIndexBlock)(NSUInteger index, UIButton *sender);

@interface ZJKitBaseController : UIViewController

/**
 *
 *    Get the left item which using a button as custom view. It may be nil if
 *  navigation item left items are empty.
 */
@property (nonatomic, strong, readonly) UIButton *zj_leftButtonItem;

/**
 *
 *    Get all of left items that using button as custom view. It may be nil if
 *  navigation item left items are empty.
 */
@property (nonatomic, strong, readonly) NSArray<UIButton *> *zj_leftButtonItems;

/**
 *
 *    Get the first right button item. When using it to access right button, it usually
 *  just has a right item. It may be nil if there is no navigation right items.
 */
@property (nonatomic, strong, readonly) UIButton *zj_rightButtonItem;

/**
 *
 *    Get all right button items. When using ti to access right buttons. It may be nil if
 *  there is no navigation right items.
 */
@property (nonatomic, strong, readonly) NSArray<UIButton *> *zj_rightButtonItems;

/**
 *
 *    Adjust navigation title view to center, when it shows margin right, just because
 *  the previous navigation item's title is too long.
 */
- (void)zj_adjustNavigationTitleToCenter;

#pragma mark - Config Navigaiton Item
/**
 *
 *    Set the navigation title or title view.
 *
 *    @param title    Title, titleView or a UIImage instance will be automatically
 *                created a title view.
 */
- (void)zj_setNavTitle:(id)title;

/**
 *
 *    Add a title or title view to the navigation item, and add a button to the
 *  navigation item right item with callback.
 *
 *    @param title            The title view or a title.
 *    @param rightTitle    The right button item title.
 *    @param rightBlock    The button event callback.
 */
- (void)zj_setNavTitle:(id)title
             rightTitle:(NSString *)rightTitle
             rightBlock:(ZJButtonActionBlock)rightBlock;

/**
 *
 *    Add a title or title view, right items with titles to the navigation item.
 *
 *    @param title                The title view
 *    @param rightTitles    The right item button titles
 *    @param rightBlock    The callback of button touch up event.
 */
- (void)zj_setNavTitle:(id)title
            rightTitles:(NSArray<NSString *> *)rightTitles
             rightBlock:(ZJButtonActionIndexBlock)rightBlock;

/**
 *
 *    Add a title or title view, right items with images to the navigation item.
 *
 *    @param title        The title view
 *    @param rightImages    The right item button normal images.
 *    @param rightBlock      The callback of button touch up event.
 */
- (void)zj_setNavTitle:(id)title
            rightImages:(NSArray *)rightImages
             rightBlock:(ZJButtonActionIndexBlock)rightBlock;

/**
 *
 *    Add a title or title view, right items with images to the navigation item.
 *
 *    @param title        The title view
 *    @param rightImages    The right item button  normal images.
 *  @param rightHgImages The right item button highlighted images.
 *    @param rightBlock      The callback of button touch up event.
 */
- (void)zj_setNavTitle:(id)title
            rightImages:(NSArray *)rightImages
          rightHgImages:(NSArray *)rightHgImages
             rightBlock:(ZJButtonActionIndexBlock)rightBlock;

/**
 *
 *    Set navigation left item with button title.
 *
 *    @param title    The title of left item button.
 *    @param block    The button touch up event callback.
 */
- (void)zj_setNavLeftButtonTitle:(NSString *)title onCliked:(ZJButtonActionBlock)block;

/**
 *
 *    Config navigation left item with a image or image name.
 *
 *    @param image    UIImage instance or an image name.
 *    @param block    The callback of item clicked.
 */
- (void)zj_setNavLeftImage:(id)image block:(ZJButtonActionBlock)block;

/**
 *  设置导航栏右边的 baritem
 *  @param title  标题文本
 */
- (void)zj_setNavRightButtonTitle:(NSString *)title onCliked:(ZJButtonActionBlock)block;
/**
 *  设置导航栏右边的 baritem
 *  @param image 图片 或 图片名称
 */
- (void)zj_setNavRightImage:(id)image block:(ZJButtonActionBlock)block;

#pragma mark - About indicator animating
/**
 *
 *    Create an UIActivityIndicatorView view with UIActivityIndicatorViewStyleGray style
 *
 *    @return The instance of UIActivityIndicatorView
 */
- (UIActivityIndicatorView *)zj_startIndicatorAnimating;

/**
 *
 *    Create an UIActivityIndicatorView view with specified style.
 *
 *    @param style    The indicator view style
 *
 *    @return The instance of UIActivityIndicatorView
 */
- (UIActivityIndicatorView *)zj_startIndicatorAnimatingWithStyle:(UIActivityIndicatorViewStyle)style;

/**
 *
 *    Stop animating of indicator and remove from super view.
 */
- (void)zj_stopIndicatorAnimating;

#pragma mark - Notification
/**
 *
 *    Add a notification to the notification center with notification name.
 *
 *    @param notificationName    The name of notification
 *    @param callback                    The callback when received the notification.
 */
- (void)zj_addObserverWithNotificationName:(NSString *)notificationName
                                   callback:(ZJNotificationBlock)callback;

/**
 *
 *    Remove all notifications of the view controller.
 */
- (void)zj_removeAllNotifications;

/**
 *
 *    Remove the specified notification with notification name from notification
 *  center.
 *
 *    @param nofiticationName    The notification name.
 */
- (void)zj_removeAllNotificationWithName:(NSString *)nofiticationName;
@end
