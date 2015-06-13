//
//  AvesTimer.m
//  Yapluka
//
//  Created by Adrien Long on 13/06/2015.
//  Copyright (c) 2015 Adrien Long. All rights reserved.
//

#import "AvesTimer.h"


/**
 
 Creates a timer that executes code after delay.
 
 Canceling the timer
 
 Timer is Canceling automatically when it is deallocated. You can also cancel it manually
 
 */
@interface AvesTimer ()
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, assign) BOOL repeats;
@property(nonatomic, copy) AvesTimerCallback callback;
@end

@implementation AvesTimer

#pragma mark - Lifecycle

-(instancetype)initWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats andCallBack:(AvesTimerCallback)callback
{
    self = [super init];
    if (self) {
        self.repeats = repeats;
        self.callback = callback;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                      target:self
                                                    selector:@selector(timerFired:)
                                                    userInfo:nil
                                                     repeats:repeats];
    }
    return self;
}

/// Timer is cancelled automatically when it is deallocated.
-(void)dealloc
{
    [self cancel];
}

#pragma mark - Public

+(AvesTimer *)runAfterInterval:(NSTimeInterval)interval repeats:(BOOL)repeats callback:(AvesTimerCallback)callback
{
    return [[AvesTimer alloc] initWithInterval:interval repeats:repeats andCallBack:callback];
}

-(void)cancel
{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - Private

-(void)timerFired:(NSTimer *)timer
{
    if (self.callback) {
        self.callback(self);
    }
    if (!self.repeats) {
        [self cancel];
    }
}

@end
