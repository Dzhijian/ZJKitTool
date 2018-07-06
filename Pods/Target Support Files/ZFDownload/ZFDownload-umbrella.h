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

#import "ZFCommonHelper.h"
#import "ZFDownloadDelegate.h"
#import "ZFDownloadManager.h"
#import "ZFFileModel.h"
#import "ZFHttpRequest.h"

FOUNDATION_EXPORT double ZFDownloadVersionNumber;
FOUNDATION_EXPORT const unsigned char ZFDownloadVersionString[];

