//
//  AvesToolbar.m
//  Yapluka
//
//  Created by Adrien Long on 13/06/2015.
//  Copyright (c) 2015 Adrien Long. All rights reserved.
//

#import "AvesToolbar.h"
#import "AvesStyle.h"


static void * KVOAvesToolbarContext = &KVOAvesToolbarContext;

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

-(void)removeFromSuperview
{
    [self removeBarTopMarginObserver];
    
    [super removeFromSuperview];
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
    
    [self observeBarTopMarginChanges];
    
    [self createLabelWithMessage:message];
    [self createActivityView];
    
    [self setNeedsLayout];
    
    [self.style.animationShow show:self duration:self.style.animationShowDuration animateBlock:self.style.animationShowAnimateBlock withCompletedBlock:self.style.animationShowCompletedBlock];
}

-(void)hideWithCompletionBlock:(AvesAnimationCompletionBlock)block
{
    // Respond only to the first hide() call
    if (self.didCallHide) { return; }
    self.didCallHide = true;
    
    __weak typeof(self)weakSelf = self;
    [self.style.animationHide hide:self duration:self.style.animationHideDuration animateBlock:self.style.animationHideAnimateBlock withCompletedBlock:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf removeFromSuperview];
        if(block) {
            block();
        }
    }];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (KVOAvesToolbarContext == context
        && [keyPath isEqualToString:NSStringFromSelector(@selector(barTopMarginFromSuperview))]
        && [object isKindOfClass:AvesStyle.class]) {
        
        [self setNeedsLayout];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

-(void)observeBarTopMarginChanges
{
    [self.style addObserver:self forKeyPath:NSStringFromSelector(@selector(barTopMarginFromSuperview)) options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:KVOAvesToolbarContext];
}

-(void)removeBarTopMarginObserver
{
    @try {
        [self.style removeObserver:self forKeyPath:NSStringFromSelector(@selector(barTopMarginFromSuperview))];
    }
    @catch (NSException * __unused exception) {}
}


#pragma mark - Private

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
    self.label.textAlignment = self.style.textHorizontalAlignment;
    self.label.contentMode = self.style.textVerticalAlignment;
    self.label.numberOfLines = self.style.textNumberOfLines;
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
    static CGFloat const activity_indicator_width = 10.0f;
    
    CGRect frame = CGRectZero;
    {
        frame = CGRectZero;
        frame.origin.y = self.style.barTopMarginFromSuperview;
        frame.size.height = self.style.barHeight;
        frame.size.width = CGRectGetWidth(self.superview.bounds);
        self.frame = frame;
    }
    {
        CGFloat labelMaxWidth = CGRectGetWidth(self.bounds) -  (self.style.displayActivityIndicator ? activity_indicator_width + margin_between_activity_and_label : 0) - self.style.contentEdgeInsets.right - self.style.contentEdgeInsets.left;
        CGFloat labelMaxHeight = self.style.barHeight - self.style.contentEdgeInsets.top - self.style.contentEdgeInsets.bottom;
        
        CGSize labelSize = [self.label sizeThatFits:CGSizeMake(labelMaxWidth, labelMaxHeight)];
        frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
        
        if (self.style.shouldCenterContent) {
            frame.origin.x =  ((CGRectGetWidth(self.bounds) - frame.size.width - self.style.contentEdgeInsets.right - self.style.contentEdgeInsets.left) * 0.5f) + (self.style.displayActivityIndicator ? activity_indicator_width + margin_between_activity_and_label : 0.0f);
        } else {
            frame.origin.x = self.style.contentEdgeInsets.left + (self.style.displayActivityIndicator ? activity_indicator_width + margin_between_activity_and_label : 0.0f);
        }
        
        
        if (self.label.contentMode == UIViewContentModeTop) {
            frame.origin.y = self.style.contentEdgeInsets.top;
        }
        else if (self.label.contentMode == UIViewContentModeBottom) {
            frame.origin.y = CGRectGetHeight(self.bounds) - frame.size.height - self.style.contentEdgeInsets.bottom;
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
