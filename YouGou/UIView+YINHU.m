//
//  UIView (YINHU)
//  ArtCMP
//
//  Created by jin on 15/6/23.
//  Copyright (c) 2015年 Art. All rights reserved.
//
#import "UIView+YINHU.h"
#import "MBProgressHUD.h"
#define kTagWaitView 10099

@implementation UIView (YINHU)
- (void)removeAllSubviews
{
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
}


- (void)addSubviews:(NSArray *)sb
{
    if ([sb count] == 0) {
        return;
    }
    
    [sb enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self addSubview:obj];
    }];
}


- (void)addAlwaysFitSubview:(UIView *)subview
{
    subview.frame = self.bounds;
    if (NSClassFromString(@"NSLayoutConstraint")) {
        [subview setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:subview];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:subview
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeft
                                                        multiplier:1.0f
                                                          constant:0.0f]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:subview
                                                         attribute:NSLayoutAttributeRight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeRight
                                                        multiplier:1.0f
                                                          constant:0.0f]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:subview
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1.0f
                                                          constant:0.0f]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:subview
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0f
                                                          constant:0.0f]];
    }
    else {
        subview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:subview];
    }
}


- (CGFloat)height
{
    return self.frame.size.height;
}


- (CGFloat)width
{
    return self.frame.size.width;
}


- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


- (void)setHeight:(CGFloat)height
{
    if (height< 0.0f) {
        height = 0.f;
        //        NSLog(@"errrrrrrrrrrrrrrrrrrr");
    }
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)showWait
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.userInteractionEnabled = NO;
    hud.yOffset = -40.0f;
    //    hud.removeFromSuperViewOnHide = YES;
    hud.tag = kTagWaitView;
    hud.mode = MBProgressHUDModeIndeterminate;
    [self addSubview:hud];
    [self bringSubviewToFront:hud];
    [hud show:YES];
}


- (void)hideWait
{
    [[self viewWithTag:kTagWaitView] removeFromSuperview];
    [MBProgressHUD hideHUDForView:self animated:NO];
}

- (void)alert:(NSString *)message
{
    [self alert:message completion:nil];
}

- (void)alert:(NSString *)message completion:(dispatch_block_t)completion
{
    for(UIView* view in self.subviews){
        if([view isKindOfClass:[MBProgressHUD class]]){
            return ;
        }
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.userInteractionEnabled = NO;
    hud.detailsLabelFont = [UIFont systemFontOfSize:12.0f];
    hud.detailsLabelText = message;
    hud.yOffset = -40.0f;
    hud.removeFromSuperViewOnHide = YES;
    
    hud.mode = MBProgressHUDModeCustomView;
    [self addSubview:hud];
    [hud show:YES];
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [hud hide:YES];
        if (completion) {
            completion();
        }
    });
}

- (void)autoDelayAlert:(NSString *)message
{
    for(UIView* view in self.subviews){
        if([view isKindOfClass:[MBProgressHUD class]]){
            return ;
        }
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.userInteractionEnabled = NO;
    hud.detailsLabelFont = [UIFont systemFontOfSize:12.0f];
    hud.detailsLabelText = message;
    hud.yOffset = -40.0f;
    hud.removeFromSuperViewOnHide = YES;
    
    hud.mode = MBProgressHUDModeCustomView;
    [self addSubview:hud];
    [hud show:YES];
    double delayInSeconds = 0;
    if (message.length > 10) {
        delayInSeconds = 3.0;
    } else {
        delayInSeconds = 2.0;
    }
   
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [hud hide:YES];
    });
}

-(void)shortTimeAlert:(NSString *)message
{
    for(UIView* view in self.subviews){
        if([view isKindOfClass:[MBProgressHUD class]]){
            return ;
        }
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.userInteractionEnabled = NO;
    hud.detailsLabelFont = [UIFont systemFontOfSize:12.0f];
    hud.detailsLabelText = message;
    hud.yOffset = -40.0f;
    hud.removeFromSuperViewOnHide = YES;
    
    hud.mode = MBProgressHUDModeCustomView;
    [self addSubview:hud];
    [hud show:YES];
    double delayInSeconds = 0;
    if (message.length > 10) {
        delayInSeconds = 3.0;
    } else {
        delayInSeconds = 0.8;
    }
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [hud hide:YES];
    });

}

@end
