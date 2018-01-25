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

#import "GDPerformanceMonitor.h"

#import "GDPerformanceView.h"

@interface GDPerformanceMonitor ()

@property (nonatomic, strong) GDPerformanceView *performanceView;

@property (nonatomic, getter=isPerformanceViewPaused) BOOL performanceViewPaused;

@property (nonatomic, getter=isPerformanceViewHidden) BOOL performanceViewHidden;

@property (nonatomic, getter=isPerformanceViewStopped) BOOL performanceViewStopped;

@property (nonatomic) BOOL prefersStatusBarHidden;

@property (nonatomic) UIStatusBarStyle preferredStatusBarStyle;

@end

@implementation GDPerformanceMonitor

#pragma mark -
#pragma mark - Init Methods & Superclass Overriders

+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^ {
        instance =  [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self subscribeToNotifications];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark - Notifications & Observers

- (void)applicationDidBecomeActive:(NSNotification *)notification {
    if (self.isPerformanceViewPaused) {
        return;
    }
    
    [self startOrResumeMonitoring];
}

- (void)applicationWillResignActive:(NSNotification *)notification {
    [self.performanceView pauseMonitoring];
}

#pragma mark -
#pragma mark - Public Methods

- (void)configureStatusBarAppearanceWithPrefersStatusBarHidden:(BOOL)prefersStatusBarHidden preferredStatusBarStyle:(NSInteger)preferredStatusBarStyle {
    self.prefersStatusBarHidden = prefersStatusBarHidden;
    self.preferredStatusBarStyle = preferredStatusBarStyle;
    
    [self checkAndApplyStatusBarAppearanceWithPrefersStatusBarHidden:prefersStatusBarHidden preferredStatusBarStyle:preferredStatusBarStyle];
}

- (void)startMonitoringWithConfiguration:(void (^)(UILabel *))configuration {
    self.performanceViewPaused = NO;
    self.performanceViewHidden = NO;
    self.performanceViewStopped = NO;
    
    [self startOrResumeMonitoring];
    
    if (configuration) {
        UILabel *textLabel = [self.performanceView textLabel];
        configuration(textLabel);
    }
}

- (void)startMonitoring {
    self.performanceViewPaused = NO;
    self.performanceViewHidden = NO;
    self.performanceViewStopped = NO;
    
    [self startOrResumeMonitoring];
}

- (void)pauseMonitoring {
    self.performanceViewPaused = YES;
    
    [self.performanceView pauseMonitoring];
}

- (void)hideMonitoring {
    self.performanceViewHidden = YES;
    
    [self.performanceView hideMonitoring];
}

- (void)stopMonitoring {
    self.performanceViewStopped = YES;
    
    [self.performanceView stopMonitoring];
    self.performanceView = nil;
}

- (void)configureWithConfiguration:(void (^)(UILabel *))configuration {
    if (!self.performanceView) {
        return;
    }
    
    if (configuration) {
        UILabel *textLabel = [self.performanceView textLabel];
        configuration(textLabel);
    }
}

#pragma mark -
#pragma mark - Private Methods

#pragma mark - Default Setups

- (void)subscribeToNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
}

#pragma mark - Monitoring

- (void)startOrResumeMonitoring {
    if (!self.performanceView) {
        [self setupPerformanceView];
    } else {
        [self.performanceView resumeMonitoringAndShowMonitoringView:!self.isPerformanceViewHidden];
    }
    
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive) {
        [self.performanceView addMonitoringViewAboveStatusBar];
    }
}

- (void)setupPerformanceView {
    if (self.isPerformanceViewStopped) {
        return;
    }
    
    self.performanceView = [[GDPerformanceView alloc] init];
    [self.performanceView setAppVersionHidden:self.appVersionHidden];
    [self.performanceView setDeviceVersionHidden:self.deviceVersionHidden];
    [self.performanceView setPerformanceDelegate:self.delegate];
    [self checkAndApplyStatusBarAppearanceWithPrefersStatusBarHidden:self.prefersStatusBarHidden preferredStatusBarStyle:self.preferredStatusBarStyle];
    
    if (self.isPerformanceViewPaused) {
        [self.performanceView pauseMonitoring];
    }
    if (self.isPerformanceViewHidden) {
        [self.performanceView hideMonitoring];
    }
}

#pragma mark - Other Methods

- (void)checkAndApplyStatusBarAppearanceWithPrefersStatusBarHidden:(BOOL)prefersStatusBarHidden preferredStatusBarStyle:(UIStatusBarStyle)preferredStatusBarStyle {
    if (!self.performanceView) {
        return;
    }
    
    if (self.performanceView.prefersStatusBarHidden != prefersStatusBarHidden || self.performanceView.preferredStatusBarStyle != preferredStatusBarStyle) {
        self.performanceView.prefersStatusBarHidden = prefersStatusBarHidden;
        self.performanceView.preferredStatusBarStyle = preferredStatusBarStyle;
        
        [self.performanceView configureRootViewController];
    }
}

#pragma mark -
#pragma mark - Setters & Getters

- (void)setDelegate:(id<GDPerformanceMonitorDelegate>)delegate {
    _delegate = delegate;
    
    [self.performanceView setPerformanceDelegate:delegate];
}

- (void)setAppVersionHidden:(BOOL)appVersionHidden {
    _appVersionHidden = appVersionHidden;
    
    if (self.performanceView) {
        [self.performanceView setAppVersionHidden:appVersionHidden];
    }
}

- (void)setDeviceVersionHidden:(BOOL)deviceVersionHidden {
    _deviceVersionHidden = deviceVersionHidden;
    
    if (self.performanceView) {
        [self.performanceView setDeviceVersionHidden:deviceVersionHidden];
    }
}

@end
