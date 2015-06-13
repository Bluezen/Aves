//
//  AvesTimer.h
//  Yapluka
//
//  Created by Adrien Long on 13/06/2015.
//  Copyright (c) 2015 Adrien Long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AvesTimer : NSObject

typedef void (^AvesTimerCallback) (AvesTimer*);

/**
 
 Runs the closure after specified time interval.
 
 :param: interval Time interval in milliseconds.
 :repeats: repeats When true, the code is run repeatedly.
 :returns: callback A closure to be run by the timer.
 
 */
+(AvesTimer *)runAfterInterval:(NSTimeInterval)interval repeats:(BOOL)repeats callback:(AvesTimerCallback)callback;

-(void)cancel;

@end
