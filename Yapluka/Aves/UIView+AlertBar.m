//
//  UIView+AlertBar.m
//  Yapluka
//
//  Created by Adrien Long on 13/06/2015.
//  Copyright (c) 2015 Adrien Long. All rights reserved.
//

#import "UIView+AlertBar.h"
#import <objc/runtime.h>
#import "Aves.h"

@implementation UIView (AlertBar)

-(void)setAves:(Aves *)newAves
{
    objc_setAssociatedObject(self, @selector(aves), newAves, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(Aves *)aves
{
    id object = objc_getAssociatedObject(self, @selector(aves));
    if (object && [object isKindOfClass:[Aves class]]) {
        return object;
    } else {
        Aves *myAves = [[Aves alloc] initWithSuperview:self];
        [self setAves:myAves];
        return myAves;
    }
}

-(BOOL)isAvesBarVisible
{
    id object = objc_getAssociatedObject(self, @selector(aves));
    if (object && [object isKindOfClass:[Aves class]]) {
        return [((Aves *)object) isAvesBarVisible];
    } else {
        return NO;
    }
}

@end
