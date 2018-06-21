//
//  UIView+ZSMenuExtension.h
//  ZSMenuView-master
//
//  Created by safiri on 2018/6/20.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZSMenuExtension)

- (void)addBorderWithBorderColor:(UIColor *)color borderWidth:(CGFloat)width top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right;
- (void)addBottomBorderWithColor:(UIColor *) color andWidth:(CGFloat)borderWidth;
- (void)addLeftBorderWithColor:(UIColor *) color andWidth:(CGFloat)borderWidth;
- (void)addRightBorderWithColor:(UIColor *) color andWidth:(CGFloat)borderWidth;
- (void)addTopBorderWithColor:(UIColor *) color andWidth:(CGFloat)borderWidth;
- (void)hideAllBorders;

@end
