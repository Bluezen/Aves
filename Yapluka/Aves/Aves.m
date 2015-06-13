//
//  Aves.m
//  Yapluka
//
//  Created by Adrien Long on 13/06/2015.
//  Copyright (c) 2015 Adrien Long. All rights reserved.
//

#import "Aves.h"
#import "AvesTimer.h"
#import "AvesToolbar.h"


@interface Aves ()
@property(nonatomic, weak) UIView *superview;
@property(nonatomic, strong) AvesTimer *hideTimer;
@end

@implementation Aves

-(instancetype)initWithSuperview:(UIView *)superview
{
    self = [super init];
    if (self) {
        self.superview = superview;
    }
    return self;
}

#pragma mark - Public 

-(void)showWithMessage:(NSString *)message
{
    [self showWithMessage:message presetStyle:AvesStylePresetDefault andStyleConfigBlock:nil];
}

-(void)showWithMessage:(NSString *)message andStyleConfigBlock:(AvesStyleConfigBlock)styleBlock
{
    [self showWithMessage:message presetStyle:AvesStylePresetDefault andStyleConfigBlock:styleBlock];
}

-(void)showWithMessage:(NSString *)message andPresetStyle:(AvesStylePreset)presetStyle
{
    [self showWithMessage:message presetStyle:presetStyle andStyleConfigBlock:nil];
}

-(void)showWithMessage:(NSString *)message presetStyle:(AvesStylePreset)presetStyle andStyleConfigBlock:(AvesStyleConfigBlock)styleBlock
{
    AvesStyle *style = [AvesStyle styleWithPreset:presetStyle];
    if (styleBlock) {
        styleBlock(style);
    }
    [self showWithMessage:message andStyle:style];
}

#pragma mark - Private


-(void)showWithMessage:(NSString *)message andStyle:(AvesStyle *)style
{
    [self removeExistingBars];
    [self setupHideTimerWithHideAfterDelaySeconds:style.hideAfterDelaySeconds repeats:style.repeats completionBlock:style.animationHideAfterDelayCompletedBlock];
    
    AvesToolbar *toolbar = [[AvesToolbar alloc] initWithStyle:style];
    
    [toolbar showInSuperview:self.superview withMessage:message];
}

/// Hide the message bar if it's currently open.
-(void)hideWithCompletionBlock:(AvesAnimationCompletionBlock)block
{
    [self.hideTimer cancel];
    
    [[self toolbar] hideWithCompletionBlock:block];
}

-(AvesToolbar *)toolbar
{
    for (UIView *view in self.superview.subviews) {
        if ([view isKindOfClass:[AvesToolbar class]]) {
            return (AvesToolbar *)view;
        }
    }
    return nil;
}

-(void)removeExistingBars
{
    for (UIView *view in self.superview.subviews) {
        if ([view isKindOfClass:[AvesToolbar class]]) {
            [view removeFromSuperview];
        }
    }
}

-(void)setupHideTimerWithHideAfterDelaySeconds:(NSTimeInterval)nbSeconds repeats:(BOOL)repeats completionBlock:(AvesAnimationCompletionBlock)block
{
    [self.hideTimer cancel];
    
    if (nbSeconds > 0.0f) {
        __weak typeof(self) weakSelf = self;
        self.hideTimer = [AvesTimer runAfterInterval:nbSeconds repeats:repeats callback:^(AvesTimer *timer) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf hideWithCompletionBlock:block];
            });
        }];
    }
}

@end
