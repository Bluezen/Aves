//
//  AvesStyle.h
//  Yapluka
//
//  Created by Adrien Long on 13/06/2015.
//  Copyright (c) 2015 Adrien Long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AvesAnimation.h"

@interface AvesStyle : NSObject

typedef NS_ENUM(NSInteger, AvesStylePreset)
{
    AvesStylePresetDefault = 0,
    AvesStylePresetError,
    AvesStylePresetInfo,
    AvesStylePresetWarning
};

@property(nonatomic, strong) UIColor *barBackgroundColor;
@property(nonatomic, assign) CGFloat barHeight;
@property(nonatomic, assign) CGFloat barTopMarginFromSuperview;
@property(nonatomic, strong) UIColor *textColor;
@property(nonatomic, strong) UIFont *textFont;
/// Supported mode: Top Bottom Center. Center by default or if unsupported mode is set.
@property(nonatomic, assign) UIViewContentMode textVerticalAlignment;
/// If set to 0, the bar won't hide after a delay. Default is 3 seconds.
@property(nonatomic, assign) NSTimeInterval hideAfterDelaySeconds;
@property(nonatomic, assign) BOOL repeats;
@property(nonatomic, assign) BOOL displayActivityIndicator;
@property(nonatomic, assign) UIActivityIndicatorViewStyle activityIndicatorStyle;

@property(nonatomic, strong) AvesAnimation *animationShow;
@property(nonatomic, strong) AvesAnimation *animationHide;
@property(nonatomic, assign) CGFloat animationShowDuration;
@property(nonatomic, assign) CGFloat animationHideDuration;
@property(nonatomic, copy) AvesAnimationCompletionBlock animationShowCompletedBlock;
@property(nonatomic, copy) AvesAnimationCompletionBlock animationHideAfterDelayCompletedBlock;

+(AvesStyle *)styleWithPreset:(AvesStylePreset)preset;

-(instancetype)initWithPreset:(AvesStylePreset)preset NS_DESIGNATED_INITIALIZER;
@end
