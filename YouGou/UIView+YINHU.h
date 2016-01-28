//
//  UIView (YINHU)
//  ArtCMP
//
//  Created by jin on 15/6/23.
//  Copyright (c) 2015年 Art. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface UIView (YINHU)

- (void)removeAllSubviews;
- (void)addSubviews:(NSArray *)sb;
- (void)addAlwaysFitSubview:(UIView *)subview;

- (CGFloat)height;
- (CGFloat)width;

- (void)setOrigin:(CGPoint)origin;
- (void)setSize:(CGSize)size;
- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)showWait;
- (void)hideWait;
- (void)alert:(NSString *)message;
- (void)alert:(NSString *)message completion:(dispatch_block_t)completion;
- (void)autoDelayAlert:(NSString *)message;
- (void)shortTimeAlert:(NSString *)message;
@end