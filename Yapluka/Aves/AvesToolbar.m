//
//  AvesToolbar.m
//  Yapluka
//
//  Created by Adrien Long on 13/06/2015.
//  Copyright (c) 2015 Adrien Long. All rights reserved.
//

#import "AvesToolbar.h"
#import "AvesStyle.h"

@interface AvesToolbar ()
@property(nonatomic, strong) AvesStyle *style;
@property(nonatomic, strong) UILabel *label;
@property(nonatomic, strong) UIActivityIndicatorView *activityView;
@property(nonatomic, assign) BOOL didCallHide;
@end

@implementation AvesToolbar

#pragma mark - Lifecycle

-(instancetype)initWithStyle:(AvesStyle *)style
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.style = style;
        self.didCallHide = NO;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithStyle:[AvesStyle styleWithPreset:AvesStylePresetDefault]];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [self initWithStyle:[AvesStyle styleWithPreset:AvesStylePresetDefault]];
}

#pragma mark - Public

-(void)showInSuperview:(UIView *)parentView withMessage:(NSString *)message
{
    if (self.superview != nil) {
        // already being shown
        return;
    }
    [parentView addSubview:self];
    [self applyStyle];
    
    [self createLabelWithMessage:message];
    [self createActivityView];
    
    [self setNeedsLayout];
    
    [self.style.animationShow show:self duration:self.style.animationShowDuration withCompletedBlock:self.style.animationShowCompletedBlock];
}

-(void)hideWithCompletionBlock:(AvesAnimationCompletionBlock)block
{
    // Respond only to the first hide() call
    if (self.didCallHide) { return; }
    self.didCallHide = true;
    
    __weak typeof(self)weakSelf = self;
    [self.style.animationHide hide:self duration:self.style.animationHideDuration withCompletedBlock:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf removeFromSuperview];
        if(block) {
            block();
        }
    }];
}

-(void)applyStyle
{
    self.backgroundColor = self.style.barBackgroundColor;
    self.layer.masksToBounds = YES;
}

-(void)createLabelWithMessage:(NSString *)message
{
    self.label = [UILabel new];
    self.label.font = self.style.textFont;
    self.label.textColor = self.style.textColor;
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.contentMode = self.style.textVerticalAlignment;
    self.label.numberOfLines = 1;
    self.label.text = message;
    
    [self addSubview:self.label];
}

-(void)createActivityView
{
    if (!self.style.displayActivityIndicator) {
        return;
    }
    
    if (self.style.activityIndicatorStyle) {
        self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.style.activityIndicatorStyle];
    } else {
        self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    self.activityView.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
    [self addSubview:self.activityView];
    
    [self.activityView startAnimating];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self adjustSubviews];
}

-(void)adjustSubviews
{
    static CGFloat const margin_between_activity_and_label = 6.0f;
    static CGFloat const min_margin_contentMode = 4.0f;
    CGRect frame = CGRectZero;
    {
        frame = CGRectZero;
        frame.origin.y = self.style.barTopMarginFromSuperview;
        frame.size.height = self.style.barHeight;
        frame.size.width = CGRectGetWidth(self.superview.bounds);
        self.frame = frame;
    }
    {
        [self.label sizeToFit];
        frame = self.label.bounds;
        frame.origin.x = ((CGRectGetWidth(self.bounds) - frame.size.width) * 0.5f) + (self.activityView ? 10.0f + margin_between_activity_and_label : 0.0f);
        
        if (self.label.contentMode == UIViewContentModeTop) {
            frame.origin.y = min_margin_contentMode;
        }
        else if (self.label.contentMode == UIViewContentModeBottom) {
            frame.origin.y = CGRectGetHeight(self.bounds) - frame.size.height - min_margin_contentMode;
        }
        else {
            frame.origin.y = (CGRectGetHeight(self.bounds) - frame.size.height) * 0.5f;
        }
        
        self.label.frame = frame;
    }
    {
        // https://stackoverflow.com/questions/2638120/can-i-change-the-size-of-uiactivityindicator
        self.activityView.center = self.label.center;
        frame = self.activityView.frame;
        frame.origin.x = CGRectGetMinX(self.label.frame) - frame.size.width - margin_between_activity_and_label;
        self.activityView.frame = frame;
        
    }
}

@end
