//
//  AvesStyle.m
//  Yapluka
//
//  Created by Adrien Long on 13/06/2015.
//  Copyright (c) 2015 Adrien Long. All rights reserved.
//

#import "AvesStyle.h"


@implementation AvesStyle

-(instancetype)initWithPreset:(AvesStylePreset)preset
{
    self = [super init];
    if (self)
    {
        // AvesStylePresetDefault
        self.barBackgroundColor = [UIColor colorWithRed:85.0f/255.0f green:208.0f/255.0f blue:229.0f/255.0f alpha:1.0f];
        self.barHeight = 20.0f;
        self.barTopMarginFromSuperview = 0.0f;
        self.textColor = [UIColor whiteColor];
        self.textFont = [UIFont fontWithName:@"Avenir-Light" size:13.0f];
        self.textVerticalAlignment = UIViewContentModeCenter;
        self.hideAfterDelaySeconds = 3;
        self.repeats = NO;
        self.displayActivityIndicator = NO;
        self.activityIndicatorStyle = UIActivityIndicatorViewStyleWhite;
        self.animationShow = [AvesAnimation animationOfType:AvesAnimationTypeSlideVertically];
        self.animationHide = [AvesAnimation animationOfType:AvesAnimationTypeSlideVertically];
        self.animationShowDuration = 0.5f;
        self.animationHideDuration = 0.5f;
        self.animationShowCompletedBlock = nil;
        self.animationHideAfterDelayCompletedBlock = nil;
        
        switch (preset) {
            case AvesStylePresetInfo:
                self.barBackgroundColor = [UIColor colorWithRed:0.0f/255.0f green:183.0f/255.0f blue:183.0f/255.0f alpha:1.0f];
                break;
            case AvesStylePresetWarning:
                self.barBackgroundColor = [UIColor colorWithRed:255.0f/255.0f green:143.0f/255.0f blue:67.0f/255.0f alpha:1.0f];
                self.displayActivityIndicator = YES;
                self.hideAfterDelaySeconds = 0;
                break;
            case AvesStylePresetError:
                self.barBackgroundColor = [UIColor colorWithRed:229.0f/255.0f green:72.0f/255.0f blue:113.0f/255.0f alpha:1.0f];
                self.hideAfterDelaySeconds = 0;
                break;
            default:
                break;
        }
        
    }
    return self;
}

+(AvesStyle *)styleWithPreset:(AvesStylePreset)preset
{
    return [[AvesStyle alloc] initWithPreset:preset];
}

@end
