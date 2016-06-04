//
//  AvesAnimation.h
//  Yapluka
//
//  Created by Adrien Long on 13/06/2015.
//  Copyright (c) 2015 Adrien Long. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AvesAnimationType)
{
    AvesAnimationTypeNoAnimation = 0,
    AvesAnimationTypeSlideVertically,
    AvesAnimationTypeFade
};

typedef void(^AvesAnimationCompletionBlock)(void);

typedef void(^AvesAnimationBlock)(void);

@interface AvesAnimation : NSObject

@property(nonatomic, readonly) AvesAnimationType type;

+(instancetype)animationOfType:(AvesAnimationType)type;

-(instancetype)initWithType:(AvesAnimationType)type NS_DESIGNATED_INITIALIZER;

-(void)show:(UIView *)view duration:(NSTimeInterval)duration animateBlock:(AvesAnimationBlock)animationBlock withCompletedBlock:(AvesAnimationCompletionBlock)completedBlock;

-(void)hide:(UIView *)view duration:(NSTimeInterval)duration animateBlock:(AvesAnimationBlock)animationBlock withCompletedBlock:(AvesAnimationCompletionBlock)completedBlock;

@end
