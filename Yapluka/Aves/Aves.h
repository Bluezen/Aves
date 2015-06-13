//
//  Aves.h
//  Yapluka
//
//  Created by Adrien Long on 13/06/2015.
//  Copyright (c) 2015 Adrien Long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AvesStyle.h"

typedef void(^AvesStyleConfigBlock)(AvesStyle *style);

@interface Aves : NSObject

-(instancetype)initWithSuperview:(UIView *)superview NS_DESIGNATED_INITIALIZER;

-(void)showWithMessage:(NSString *)message;

-(void)showWithMessage:(NSString *)message andPresetStyle:(AvesStylePreset)presetStyle;

-(void)showWithMessage:(NSString *)message andStyleConfigBlock:(AvesStyleConfigBlock)styleBlock;

-(void)showWithMessage:(NSString *)message presetStyle:(AvesStylePreset)presetStyle andStyleConfigBlock:(AvesStyleConfigBlock)styleBlock;

-(void)hideWithCompletionBlock:(AvesAnimationCompletionBlock)block;

@end
