//
//  AvesAnimation.m
//  Yapluka
//
//  Created by Adrien Long on 13/06/2015.
//  Copyright (c) 2015 Adrien Long. All rights reserved.
//

#import "AvesAnimation.h"

@interface AvesAnimation ()
@property(nonatomic, assign) AvesAnimationType type;
@end

@implementation AvesAnimation

#pragma mark - Lifecycle

+(instancetype)animationOfType:(AvesAnimationType)type
{
    return [[AvesAnimation alloc] initWithType:type];
}

-(instancetype)initWithType:(AvesAnimationType)type
{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

-(instancetype)init
{
    return [self initWithType:AvesAnimationTypeNoAnimation];
}

#pragma mark - Public

-(void)show:(UIView *)view duration:(NSTimeInterval)duration withCompletedBlock:(AvesAnimationCompletionBlock)completedBlock
{
    switch (self.type) {
        case AvesAnimationTypeNoAnimation:
            [AvesAnimation noAnimation:view duration:duration withCompletedBlock:completedBlock];
            break;
        case AvesAnimationTypeSlideVertically:
            [AvesAnimation slideVertically:duration showView:YES locationTop:YES view:view completed:completedBlock];
            break;
        case AvesAnimationTypeFade:
            [AvesAnimation fade:duration showView:YES view:view completed:completedBlock];
            break;
        default:
            break;
    }
}

-(void)hide:(UIView *)view duration:(NSTimeInterval)duration withCompletedBlock:(AvesAnimationCompletionBlock)completedBlock
{
    switch (self.type) {
        case AvesAnimationTypeNoAnimation:
            [AvesAnimation noAnimation:view duration:duration withCompletedBlock:completedBlock];
            break;
        case AvesAnimationTypeSlideVertically:
            [AvesAnimation slideVertically:duration showView:NO locationTop:YES view:view completed:completedBlock];
            break;
        case AvesAnimationTypeFade:
            [AvesAnimation fade:duration showView:NO view:view completed:completedBlock];
            break;
        default:
            break;
    }
}

#pragma mark - Private

+(void)noAnimation:(UIView *)view duration:(NSTimeInterval)duration withCompletedBlock:(AvesAnimationCompletionBlock)completedBlock
{
    if (completedBlock) {
        completedBlock();
    }
}

+(void)slideVertically:(NSTimeInterval)duration showView:(BOOL)showView locationTop:(BOOL)locationTop view:( UIView *)view completed:(AvesAnimationCompletionBlock)completedBlock
{
    CGFloat actualDuration = duration > 0 ? duration : 0.5;
    [view layoutIfNeeded];
    
    CGFloat distance = 0.0f;
    
    if (locationTop) {
        distance = CGRectGetMaxY(view.frame);
    } else {
        distance = [[UIScreen mainScreen] bounds].size.height - view.frame.origin.y;
    }
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, locationTop ? -distance : distance);
    
    CGAffineTransform start = showView ? transform : CGAffineTransformIdentity;
    CGAffineTransform end = showView ? CGAffineTransformIdentity : transform;
    
    view.transform = start;
    
    [UIView animateWithDuration:actualDuration
                          delay:0
         usingSpringWithDamping:1
          initialSpringVelocity:1
                        options:UIViewAnimationOptionTransitionNone
                     animations:^
    {
        view.transform = end;
    }
                     completion:^(BOOL finished)
    {
        if (completedBlock) {
            completedBlock();
        }
    }];
}

+(void)fade:(NSTimeInterval)duration showView:(BOOL)showView view:( UIView *)view completed:(AvesAnimationCompletionBlock)completedBlock
{
    CGFloat actualDuration = duration > 0 ? duration : 0.5;
    CGFloat startAlpha = showView ? 0 : 1;
    CGFloat endAlpha = showView ? 1 : 0;
    
    view.alpha = startAlpha;
    
    [UIView animateWithDuration:actualDuration animations:^{
        view.alpha = endAlpha;
    } completion:^(BOOL finished) {
        if(completedBlock) {
            completedBlock();
        }
    }];
}

@end
