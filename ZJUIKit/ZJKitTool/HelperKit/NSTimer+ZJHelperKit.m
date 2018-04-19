//
//  NSTimer+ZJHelperKit.m
//  ZJUIKit
//
//  Created by dzj on 2018/1/19.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "NSTimer+ZJHelperKit.h"
#import <objc/runtime.h>


static const void *s_zj_private_currentCountTime = "s_zj_private_currentCountTime";

@implementation NSTimer (ZJHelperKit)

- (NSNumber *)zj_private_currentCountTime {
    NSNumber *obj = objc_getAssociatedObject(self, s_zj_private_currentCountTime);
    
    if (obj == nil) {
        obj = @(0);
        
        [self setzj_private_currentCountTime:obj];
    }
    
    return obj;
}

- (void)setzj_private_currentCountTime:(NSNumber *)time {
    objc_setAssociatedObject(self,
                             s_zj_private_currentCountTime,
                             time, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSTimer *)zj_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                          count:(NSInteger)count
                                       callback:(ZJTimerCallback)callback {
    if (count <= 0) {
        return [self zj_scheduledTimerWithTimeInterval:interval
                                                repeats:YES
                                               callback:callback];
    }
    
    NSDictionary *userInfo = @{@"callback"     : callback,
                               @"count"        : @(count)};
    return [NSTimer scheduledTimerWithTimeInterval:interval
                                            target:self
                                          selector:@selector(zj_onTimerUpdateCountBlock:)
                                          userInfo:userInfo
                                           repeats:YES];
}

+ (NSTimer *)zj_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                        repeats:(BOOL)repeats
                                       callback:(ZJTimerCallback)callback {
    return [NSTimer scheduledTimerWithTimeInterval:interval
                                            target:self
                                          selector:@selector(zj_onTimerUpdateBlock:)
                                          userInfo:callback
                                           repeats:repeats];
}

- (void)zj_fireTimer {
    [self setFireDate:[NSDate distantPast]];
}

- (void)zj_unfireTimer {
    [self setFireDate:[NSDate distantFuture]];
}

- (void)zj_invalidate {
    if (self.isValid) {
        [self invalidate];
    }
}

#pragma mark - Private
+ (void)zj_onTimerUpdateBlock:(NSTimer *)timer {
    ZJTimerCallback block = timer.userInfo;
    
    if (block) {
        block(timer);
    }
}

+ (void)zj_onTimerUpdateCountBlock:(NSTimer *)timer {
    NSInteger currentCount = [[timer zj_private_currentCountTime] integerValue];
    
    NSDictionary *userInfo = timer.userInfo;
    ZJTimerCallback callback = userInfo[@"callback"];
    NSNumber *count = userInfo[@"count"];
    
    if (currentCount < count.integerValue) {
        currentCount++;
        [timer setzj_private_currentCountTime:@(currentCount)];
        
        if (callback) {
            callback(timer);
        }
    } else {
        currentCount = 0;
        [timer setzj_private_currentCountTime:@(currentCount)];
        
        [timer zj_unfireTimer];
        [timer zj_invalidate];
    }
}


@end
