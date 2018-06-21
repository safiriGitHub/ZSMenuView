//
//  UIView+ZSMenuExtension.m
//  ZSMenuView-master
//
//  Created by safiri on 2018/6/20.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import "UIView+ZSMenuExtension.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic, readonly) CALayer *topBorder;
@property (nonatomic, readonly) CALayer *bottomBorder;
@property (nonatomic, readonly) CALayer *leftBorder;
@property (nonatomic, readonly) CALayer *rightBorder;

@end

@implementation UIView (ZSMenuExtension)

NSString *const _topBorder = @"_topBorder";
- (CALayer *)topBorder {
    CALayer *border = objc_getAssociatedObject(self, (__bridge const void *)(_topBorder));
    if (!border) {
        border = [CALayer layer];
        objc_setAssociatedObject(self, (__bridge const void *)(_topBorder), border, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return border;
}
NSString *const _bottomBorder = @"_bottomBorder";
- (CALayer *)bottomBorder {
    CALayer *border = objc_getAssociatedObject(self, (__bridge const void *)(_bottomBorder));
    if (!border) {
        border = [CALayer layer];
        objc_setAssociatedObject(self, (__bridge const void *)(_bottomBorder), border, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return border;
}
NSString *const _leftBorder = @"_leftBorder";
- (CALayer *)leftBorder {
    CALayer *border = objc_getAssociatedObject(self, (__bridge const void *)(_leftBorder));
    if (!border) {
        border = [CALayer layer];
        objc_setAssociatedObject(self, (__bridge const void *)(_leftBorder), border, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return border;
}
NSString *const _rightBorder = @"_rightBorder";
- (CALayer *)rightBorder {
    CALayer *border = objc_getAssociatedObject(self, (__bridge const void *)(_rightBorder));
    if (!border) {
        border = [CALayer layer];
        objc_setAssociatedObject(self, (__bridge const void *)(_rightBorder), border, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return border;
}
- (void)addBorderWithBorderColor:(UIColor *)color borderWidth:(CGFloat)width top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right {
    if (top) [self addTopBorderWithColor:color andWidth:width];
    if (bottom) [self addBottomBorderWithColor:color andWidth:width];
    if (left) [self addLeftBorderWithColor:color andWidth:width];
    if (right) [self addRightBorderWithColor:color andWidth:width];
}
- (void)addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *border = [self topBorder];
    border.hidden = NO;
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(0, 0, self.frame.size.width, borderWidth);
    [self.layer addSublayer:border];
}
- (void)addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *border = [self bottomBorder];
    border.hidden = NO;
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth);
    [self.layer addSublayer:border];
}
- (void)addLeftBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *border = [self leftBorder];
    border.hidden = NO;
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(0, 0, borderWidth, self.frame.size.height);
    [self.layer addSublayer:border];
}
- (void)addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *border = [self rightBorder];
    border.hidden = NO;
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(self.frame.size.width - borderWidth, 0, borderWidth, self.frame.size.height);
    [self.layer addSublayer:border];
}
- (void)hideAllBorders {
    self.topBorder.hidden = YES;
    self.bottomBorder.hidden = YES;
    self.leftBorder.hidden = YES;
    self.rightBorder.hidden = YES;
    [self.topBorder removeFromSuperlayer];
    [self.bottomBorder removeFromSuperlayer];
    [self.leftBorder removeFromSuperlayer];
    [self.rightBorder removeFromSuperlayer];
}


@end
