#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "GDMarginLabel.h"
#import "GDPerformanceMonitor.h"
#import "GDPerformanceMonitorProtocol.h"
#import "GDPerformanceView.h"
#import "GDWindowViewController.h"

FOUNDATION_EXPORT double GDPerformanceViewVersionNumber;
FOUNDATION_EXPORT const unsigned char GDPerformanceViewVersionString[];

