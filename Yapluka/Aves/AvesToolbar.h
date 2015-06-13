//
//  AvesToolbar.h
//  Yapluka
//
//  Created by Adrien Long on 13/06/2015.
//  Copyright (c) 2015 Adrien Long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AvesAnimation.h"

@class AvesStyle;

@interface AvesToolbar : UIView

-(instancetype)initWithStyle:(AvesStyle *)style NS_DESIGNATED_INITIALIZER;

-(void)showInSuperview:(UIView *)superview withMessage:(NSString *)message;

-(void)hideWithCompletionBlock:(AvesAnimationCompletionBlock)block;

@end
