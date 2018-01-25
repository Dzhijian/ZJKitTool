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

#import <UIKit/UIKit.h>

#import "GDPerformanceMonitorProtocol.h"

@interface GDPerformanceView : UIWindow

/**
 GDPerformanceMonitorDelegate delegate.
 */
@property (nonatomic, weak) id<GDPerformanceMonitorDelegate> performanceDelegate;

/**
 Change it to hide or show application version from monitoring view. Default is NO.
 */
@property (nonatomic, getter=isAppVersionHidden) BOOL appVersionHidden;

/**
 Change it to hide or show device iOS version from monitoring view. Default is NO.
 */
@property (nonatomic, getter=isDeviceVersionHidden) BOOL deviceVersionHidden;

/**
 Override this properties to return the desired status bar attributes.
 
 Default prefersStatusBarHidden is false, preferredStatusBarStyle is UIStatusBarStyle.default.
 */
@property (nonatomic) BOOL prefersStatusBarHidden;

@property (nonatomic) UIStatusBarStyle preferredStatusBarStyle;


/**
 Returns weak monitoring text label.
 */
- (UILabel *)textLabel;

/**
 Pauses performance monitoring and hides monitoring view.
 */
- (void)pauseMonitoring;

/**
 Resumes performance monitoring and shows monitoring view.
 */
- (void)resumeMonitoringAndShowMonitoringView:(BOOL)showMonitoringView;

/**
 Hides monitoring view.
 */
- (void)hideMonitoring;

/**
 Adds monitoring view above the status bar.
 */
- (void)addMonitoringViewAboveStatusBar;

/**
 Configures root view controller with prefersStatusBarHidden and preferredStatusBarStyle.
 */
- (void)configureRootViewController;

/**
 Stops and removes monitoring view. Call when you're done with performance monitoring.
 */
- (void)stopMonitoring;

@end
