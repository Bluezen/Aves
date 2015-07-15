# Aves
Quick and dirty little cute alert bar.

## Installation

### Source files

1. Download the [latest code version](https://github.com/Bluezen/Aves/archive/master.zip) or add the repository as a git submodule to your git-tracked project.
2. Drag and drop the **Aves** directory from the archive in your project navigator. Make sure to select *Copy items* when asked if you extracted the code archive outside of your project.
3. Include UIView+AlertBar wherever you need it with `#import <Aves/UIView+AlertBar.h>`.

## Usage

Check out [ViewController.m](https://github.com/Bluezen/Aves/blob/master/Yapluka/ViewController.m) to see how you can use the component.

```objc
-(void)hide
{
    [self.view.aves hideWithCompletionBlock:nil];
}

-(void)show
{
    [self.view.aves showWithMessage:@"Loading message"
                andStyleConfigBlock:^(AvesStyle *style)
     {
         // Override default style properties
         style.displayActivityIndicator = YES;
         style.hideAfterDelaySeconds = 0; // Do not hide automatically
     }];
}
```

### Show

```objc
-(void)showWithMessage:(NSString *)message;

-(void)showWithMessage:(NSString *)message andPresetStyle:(AvesStylePreset)presetStyle;

-(void)showWithMessage:(NSString *)message andStyleConfigBlock:(AvesStyleConfigBlock)styleBlock;

-(void)showWithMessage:(NSString *)message presetStyle:(AvesStylePreset)presetStyle andStyleConfigBlock:(AvesStyleConfigBlock)styleBlock;
```

### Hide
```objc
-(void)hideWithCompletionBlock:(AvesAnimationCompletionBlock)block;
```

## Customization

**AvesStyle.h**

```objc
@property(nonatomic, strong) UIColor *barBackgroundColor;
@property(nonatomic, assign) CGFloat barHeight;
@property(nonatomic, assign) CGFloat barTopMarginFromSuperview;
@property(nonatomic, strong) UIColor *textColor;
@property(nonatomic, strong) UIFont *textFont;
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
```
