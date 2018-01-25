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

#import "GDPerformanceView.h"

#import <mach/mach.h>
#import <QuartzCore/QuartzCore.h>

#import "GDMarginLabel.h"
#import "GDWindowViewController.h"

@interface GDPerformanceView ()

@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic, strong) GDMarginLabel *monitoringTextLabel;

@property (nonatomic) int screenUpdatesCount;

@property (nonatomic) CFTimeInterval screenUpdatesBeginTime;

@property (nonatomic) CFTimeInterval averageScreenUpdatesTime;

@property (nonatomic) NSString *versionsString;

@end

@implementation GDPerformanceView

#pragma mark -
#pragma mark - Init Methods & Superclass Overriders

- (instancetype)init {
    self = [super initWithFrame:[GDPerformanceView windowFrame]];
    if (self) {
        [self setupWindowAndDefaultVariables];
        [self setupDisplayLink];
        [self setupTextLayers];
        [self subscribeToNotifications];
        [self configureVersionsString];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self layoutWindow];
}

- (void)becomeKeyWindow {
    [self setHidden:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setHidden:NO];
    });
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return NO;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark - Notifications & Observers

- (void)applicationWillChangeStatusBarFrame:(NSNotification *)notification {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self layoutWindow];
    });
}

#pragma mark -
#pragma mark - Public Methods

- (UILabel *)textLabel {
    __weak UILabel *weakTextLabel = self.monitoringTextLabel;
    return weakTextLabel;
}

- (void)pauseMonitoring {
    [self.displayLink setPaused:YES];
    
    [self.monitoringTextLabel removeFromSuperview];
}

- (void)resumeMonitoringAndShowMonitoringView:(BOOL)showMonitoringView {
    [self.displayLink setPaused:NO];
    
    if (showMonitoringView) {
        [self addSubview:self.monitoringTextLabel];
    }
}

- (void)hideMonitoring {
    [self.monitoringTextLabel removeFromSuperview];
}

- (void)addMonitoringViewAboveStatusBar {
    if (![self isHidden]) {
        return;
    }
    
    [self setHidden:NO];
}

- (void)configureRootViewController {
    GDWindowViewController *rootViewController = [[GDWindowViewController alloc] init];
    [rootViewController configureStatusBarAppearanceWithPrefersStatusBarHidden:self.prefersStatusBarHidden preferredStatusBarStyle:self.preferredStatusBarStyle];
    
    self.rootViewController = rootViewController;
}

- (void)stopMonitoring {
    [self.displayLink invalidate];
    self.displayLink = nil;
}

#pragma mark -
#pragma mark - Private Methods

#pragma mark - Default Setups

- (void)setupWindowAndDefaultVariables {
    self.prefersStatusBarHidden = NO;
    self.preferredStatusBarStyle = UIStatusBarStyleDefault;
    self.screenUpdatesCount = 0;
    self.screenUpdatesBeginTime = 0.0f;
    self.averageScreenUpdatesTime = 0.017f;
    
    GDWindowViewController *rootViewController = [[GDWindowViewController alloc] init];
    
    [self setRootViewController:rootViewController];
    [self setWindowLevel:(UIWindowLevelStatusBar + 1.0f)];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setClipsToBounds:YES];
    [self setHidden:YES];
}

- (void)setupDisplayLink {
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)setupTextLayers {
    self.monitoringTextLabel = [[GDMarginLabel alloc] init];
    [self.monitoringTextLabel setTextAlignment:NSTextAlignmentCenter];
    [self.monitoringTextLabel setNumberOfLines:2];
    [self.monitoringTextLabel setBackgroundColor:[UIColor blackColor]];
    [self.monitoringTextLabel setTextColor:[UIColor whiteColor]];
    [self.monitoringTextLabel setClipsToBounds:YES];
    [self.monitoringTextLabel setFont:[UIFont systemFontOfSize:8.0f]];
    [self.monitoringTextLabel.layer setBorderWidth:1.0f];
    [self.monitoringTextLabel.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.monitoringTextLabel.layer setCornerRadius:5.0f];
    
    [self addSubview:self.monitoringTextLabel];
}

- (void)subscribeToNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillChangeStatusBarFrame:) name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
}

#pragma mark - Monitoring

- (void)displayLinkAction:(CADisplayLink *)displayLink {
    if (self.screenUpdatesBeginTime == 0.0f) {
        self.screenUpdatesBeginTime = displayLink.timestamp;
    } else {
        self.screenUpdatesCount += 1;
        
        CFTimeInterval screenUpdatesTime = self.displayLink.timestamp - self.screenUpdatesBeginTime;
        
        if (screenUpdatesTime >= 1.0) {
            CFTimeInterval updatesOverSecond = screenUpdatesTime - 1.0f;
            int framesOverSecond = updatesOverSecond / self.averageScreenUpdatesTime;
            
            self.screenUpdatesCount -= framesOverSecond;
            if (self.screenUpdatesCount < 0) {
                self.screenUpdatesCount = 0;
            }
            
            [self takeReadings];
        }
    }
}

- (void)takeReadings {
    int fps = self.screenUpdatesCount;
    float cpu = [self cpuUsage];
    
    self.screenUpdatesCount = 0;
    self.screenUpdatesBeginTime = 0.0f;
    
    [self reportFPS:fps CPU:cpu];
    [self updateMonitoringLabelWithFPS:fps CPU:cpu];
}

- (float)cpuUsage {
    kern_return_t kern;
    
    thread_array_t threadList;
    mach_msg_type_number_t threadCount;
    
    thread_info_data_t threadInfo;
    mach_msg_type_number_t threadInfoCount;
    
    thread_basic_info_t threadBasicInfo;
    uint32_t threadStatistic = 0;
    
    kern = task_threads(mach_task_self(), &threadList, &threadCount);
    if (kern != KERN_SUCCESS) {
        return -1;
    }
    if (threadCount > 0) {
        threadStatistic += threadCount;
    }
    
    float totalUsageOfCPU = 0;
    
    for (int i = 0; i < threadCount; i++) {
        threadInfoCount = THREAD_INFO_MAX;
        kern = thread_info(threadList[i], THREAD_BASIC_INFO, (thread_info_t)threadInfo, &threadInfoCount);
        if (kern != KERN_SUCCESS) {
            return -1;
        }
        
        threadBasicInfo = (thread_basic_info_t)threadInfo;
        
        if (!(threadBasicInfo -> flags & TH_FLAGS_IDLE)) {
            totalUsageOfCPU = totalUsageOfCPU + threadBasicInfo -> cpu_usage / (float)TH_USAGE_SCALE * 100.0f;
        }
    }
    
    kern = vm_deallocate(mach_task_self(), (vm_offset_t)threadList, threadCount * sizeof(thread_t));
    
    return totalUsageOfCPU;
}

#pragma mark - Other Methods

+ (CGRect)windowFrame {
    CGRect frame = CGRectZero;
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    if (window) {
        frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(window.bounds), 20.0f);
    }
    return frame;
}

- (void)reportFPS:(int)fpsValue CPU:(float)cpuValue {
    if (!self.performanceDelegate || ![self.performanceDelegate respondsToSelector:@selector(performanceMonitorDidReportFPS:CPU:)]) {
        return;
    }
    
    [self.performanceDelegate performanceMonitorDidReportFPS:fpsValue CPU:cpuValue];
}

- (void)updateMonitoringLabelWithFPS:(int)fpsValue CPU:(float)cpuValue {
    NSString *monitoringString = [NSString stringWithFormat:@"FPS : %d CPU : %.1f%%%@", fpsValue, cpuValue, self.versionsString];
    
    [self.monitoringTextLabel setText:monitoringString];
    [self layoutTextLabel];
}

- (void)layoutTextLabel {
    CGFloat windowWidth = CGRectGetWidth(self.bounds);
    CGFloat windowHeight = CGRectGetHeight(self.bounds);
    CGSize labelSize = [self.monitoringTextLabel sizeThatFits:CGSizeMake(windowWidth, windowHeight)];
    
    [self.monitoringTextLabel setFrame:CGRectMake((windowWidth - labelSize.width) / 2.0f, (windowHeight - labelSize.height) / 2.0f, labelSize.width, labelSize.height)];
}

- (void)layoutWindow {
    [self setFrame:[GDPerformanceView windowFrame]];
    [self layoutTextLabel];
}

- (void)configureVersionsString {
    if (!self.appVersionHidden || !self.deviceVersionHidden) {
        NSString *applicationVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        NSString *applicationBuild = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
        
        if (!self.appVersionHidden && !self.deviceVersionHidden) {
            self.versionsString = [NSString stringWithFormat:@"\napp v%@ (%@) iOS v%@", applicationVersion, applicationBuild, systemVersion];
        } else if (!self.appVersionHidden) {
            self.versionsString = [NSString stringWithFormat:@"\napp v%@ (%@)", applicationVersion, applicationBuild];
        } else if (!self.deviceVersionHidden) {
            self.versionsString = [NSString stringWithFormat:@"\niOS v%@", systemVersion];
        }
    } else {
        self.versionsString = @"";
    }
}

#pragma mark -
#pragma mark - Setters & Getters

- (void)setAppVersionHidden:(BOOL)appVersionHidden {
    if (appVersionHidden == _appVersionHidden) {
        return;
    }
    
    _appVersionHidden = appVersionHidden;
    
    [self configureVersionsString];
}

- (void)setDeviceVersionHidden:(BOOL)deviceVersionHidden {
    if (deviceVersionHidden == _deviceVersionHidden) {
        return;
    }
    
    _deviceVersionHidden = deviceVersionHidden;
    
    [self configureVersionsString];
}

@end
