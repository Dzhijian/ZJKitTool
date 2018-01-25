//
// Copyright © 2017 Gavrilov Daniil
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import <Foundation/Foundation.h>

#import "GDPerformanceMonitorProtocol.h"

@class UILabel;

@interface GDPerformanceMonitor : NSObject

/**
 GDPerformanceMonitorDelegate delegate.
 */
@property (nonatomic, weak) id<GDPerformanceMonitorDelegate> delegate;

/**
 Change it to hide or show application version from monitoring view. Default is NO.
 */
@property (nonatomic, getter=isAppVersionHidden) BOOL appVersionHidden;

/**
 Change it to hide or show device iOS version from monitoring view. Default is NO.
 */
@property (nonatomic, getter=isDeviceVersionHidden) BOOL deviceVersionHidden;


/**
 Creates and returns instance of GDPerformanceMonitor, as singleton.
 */
+ (instancetype)sharedInstance;

/**
 Creates and returns instance of GDPerformanceMonitor.
 */
- (instancetype)init NS_DESIGNATED_INITIALIZER;

/**
 Overrides prefersStatusBarHidden and preferredStatusBarStyle properties to return the desired status bar attributes.
 
 Default prefersStatusBarHidden is NO, preferredStatusBarStyle is UIStatusBarStyleDefault.
 */
- (void)configureStatusBarAppearanceWithPrefersStatusBarHidden:(BOOL)prefersStatusBarHidden preferredStatusBarStyle:(NSInteger)preferredStatusBarStyle;

/**
 Starts or resumes performance monitoring, initialize monitoring view if not initialized and shows monitoring view. Use configuration block to change appearance as you like.
 */
- (void)startMonitoringWithConfiguration:(void (^)(UILabel *textLabel))configuration;

/**
 Starts or resumes performance monitoring, initialize monitoring view if not initialized and shows monitoring view.
 */
- (void)startMonitoring;

/**
 Pauses performance monitoring and hides monitoring view.
 */
- (void)pauseMonitoring;

/**
 Hides monitoring view.
 */
- (void)hideMonitoring;

/**
 Stops and removes monitoring view. Call when you're done with performance monitoring.
 */
- (void)stopMonitoring;

/**
 Use configuration block to change appearance as you like.
 */
- (void)configureWithConfiguration:(void (^)(UILabel *textLabel))configuration;

@end
