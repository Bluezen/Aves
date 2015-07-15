//
//  ViewController.m
//  Yapluka
//
//  Created by Adrien Long on 13/06/2015.
//  Copyright (c) 2015 Adrien Long. All rights reserved.
//

#import "ViewController.h"
#import "UIView+AlertBar.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.navigationBar.translucent = NO;
    
    UIButton *hideButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 150, 200, 44.0f)];
    [hideButton setTitle:@"Hide" forState:UIControlStateNormal];
    [hideButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [hideButton addTarget:self action:@selector(hideButtonPushed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hideButton];
    
    UIButton *showButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 200, 200, 44.0f)];
    [showButton setTitle:@"Show" forState:UIControlStateNormal];
    [showButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [showButton addTarget:self action:@selector(showButtonPushed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showButton];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self show];
}

-(void)hideButtonPushed:(id)sender
{
    [self hide];
}

-(void)showButtonPushed:(id)sender
{
    [self show];
}

-(void)hide
{
    [self.view.aves hideWithCompletionBlock:nil];
}

-(void)show
{
    [self.view.aves showWithMessage:@"Ceci est un message de test"
                andStyleConfigBlock:^(AvesStyle *style)
     {
         style.barTopMarginFromSuperview = 64.0f;
         style.hideAfterDelaySeconds = 0;
         style.displayActivityIndicator = YES;
         style.barHeight = 40.0f;
     }];
}

@end
