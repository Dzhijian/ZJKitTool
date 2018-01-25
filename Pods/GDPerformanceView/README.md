#GDPerformanceView
Shows FPS, CPU usage, app and iOS versions above the status bar and report FPS and CPU usage via delegate.

[![Pod Version](https://img.shields.io/badge/Pod-1.3.1-6193DF.svg)](https://cocoapods.org/)
![Swift Version](https://img.shields.io/badge/xCode-8.2+-blue.svg) 
![Swift Version](https://img.shields.io/badge/iOS-8.0+-blue.svg) 
![Plaform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)
![License MIT](https://img.shields.io/badge/License-MIT-lightgrey.svg) 

![Alt text](https://github.com/dani-gavrilov/GDPerformanceView/blob/master/performance_view.PNG?raw=true "Example PNG")
![Alt text](https://github.com/dani-gavrilov/GDPerformanceView/blob/master/performance_view_2.PNG?raw=true "Example PNG")
![Alt text](https://github.com/dani-gavrilov/GDPerformanceView/blob/master/performance_view_3.PNG?raw=true "Example PNG")
![Alt text](https://github.com/dani-gavrilov/GDPerformanceView/blob/master/performance_view_4.PNG?raw=true "Example PNG")

## Installation
Simply add GDPerformanceMonitoring folder with files to your project, or use CocoaPods.

#### Podfile
You can use [CocoaPods](http://cocoapods.org/) to install `GDPerformanceView` by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!

target 'project_name' do
	pod 'GDPerformanceView', '~> 1.3.1'
end
```
Don't forget to import GDPerformanceView by adding: 

```objective-c
#import <GDPerformanceView/GDPerformanceMonitor.h>
```

## Usage example

Simply start monitoring. Performance view will be added above the status bar automatically.
Also, you can configure appearance as you like or just hide the monitoring view and use its delegate.

#### Start monitoring

Call to start or resume monitoring and show monitoring view.

```objective-c
[[GDPerformanceMonitor sharedInstance] startMonitoring];
```

```objective-c
self.performanceMonitor = [GDPerformanceMonitor alloc] init];
[self.performanceMonitor startMonitoring];
```

#### Stop monitoring

Call when you're done with performance monitoring.

```objective-c
[self.performanceMonitor stopMonitoring];
```

Call to hide and pause monitoring.

```objective-c
[self.performanceMonitor pauseMonitoring];
```

#### Configuration

Call to change appearance.

```objective-c
[self.performanceMonitor configureWithConfiguration:^(UILabel *textLabel) {
	[textLabel setBackgroundColor:[UIColor blackColor]];
	[textLabel setTextColor:[UIColor whiteColor]];
	[textLabel.layer setBorderColor:[[UIColor blackColor] CGColor]];
}];
```

Call to change output information.

```objective-c
[self.performanceMonitor setAppVersionHidden:YES]
```
```objective-c
[self.performanceMonitor setDeviceVersionHidden:YES];
```

Call to hide monitoring view.

```objective-c
[self.performanceMonitor hideMonitoring];
```

Call to change status bar appearance.

```objective-c
[self.performanceMonitor configureStatusBarAppearanceWithPrefersStatusBarHidden:NO preferredStatusBarStyle:UIStatusBarStyleLightContent];
```

#### Start monitoring and configure

```objective-c
[self.performanceMonitor startMonitoringWithConfiguration:^(UILabel *textLabel) {
	[textLabel setBackgroundColor:[UIColor blackColor]];
	[textLabel setTextColor:[UIColor whiteColor]];
	[textLabel.layer setBorderColor:[[UIColor blackColor] CGColor]];
}];
```

#### Delegate

Set the delegate and implement its method.

```objective-c
[self.performanceMonitor setDelegate:self];
```

```objective-c
- (void)performanceMonitorDidReportFPS:(int)fpsValue CPU:(float)cpuValue {
    NSLog(@"%d %f", fpsValue, cpuValue);
}
```

## Requirements
- iOS 8.0+
- xCode 8.2+

## Meta

Daniil Gavrilov - [VK](https://vk.com/dani_gavrilov) - [FB](https://www.facebook.com/danigavrilov)

GDPerformanceView is available under the MIT license. See the LICENSE file for more info.
