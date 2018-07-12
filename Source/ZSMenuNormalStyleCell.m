//
//  ZSMenuNormalStyleCell.m
//  ZSMenuView-master
//
//  Created by safiri on 2018/6/13.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import "ZSMenuNormalStyleCell.h"

@interface ZSMenuNormalStyleCell ()

@property (nonatomic ,strong) UIView *menuContainerView;


@end

@implementation ZSMenuNormalStyleCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _space = 5;
    _labelWidthRadio = 0;
    _menuImageSize = CGSizeZero;
    
    [self.contentView addSubview:self.menuContainerView];
    [self.menuContainerView addSubview:self.menuImageView];
    [self.menuContainerView addSubview:self.menuLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.contentView.bounds.size.width;
    CGFloat height = self.contentView.bounds.size.height;
    CGFloat edgeTop = self.contentEdge.top;
    CGFloat edgeBottom = self.contentEdge.bottom;
    CGFloat edgeLeft = self.contentEdge.left;
    CGFloat edgeRight = self.contentEdge.right;
    
    //menuImageView
    CGFloat imageHeight = width;
    CGFloat imageWidth = height;
    if (CGSizeEqualToSize(self.menuImageSize, CGSizeZero)) {
        imageHeight = self.menuImageView.image.size.height;
        imageWidth = self.menuImageView.image.size.width;
    }else {
        imageHeight = self.menuImageSize.height;
        imageWidth = self.menuImageSize.width;
    }
    
    //menuLabel
    CGFloat labelWidth = (width-edgeLeft-edgeRight) * self.labelWidthRadio;
    if (self.labelWidthRadio == 0) {
        labelWidth = imageWidth;
    }
    CGRect labelDrawRect = [self.menuLabel.text boundingRectWithSize:CGSizeMake(labelWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:nil context:nil];
    CGFloat labelHeight = labelDrawRect.size.height;
    
    //menuContainerView
    CGFloat containerWidth = labelWidth > imageWidth ? labelWidth : imageWidth;
    CGFloat containerHeight = imageHeight + self.space + labelHeight;
    CGFloat containerX = (width - containerWidth - edgeLeft - edgeRight)/2;
    CGFloat containerY = (height - containerHeight - edgeTop - edgeBottom)/2;
    
    //setFrame
    self.menuContainerView.frame = CGRectMake(containerX, containerY, containerWidth, containerHeight);
    self.menuImageView.frame = CGRectMake((containerWidth - imageWidth)/2, 0, imageWidth, imageHeight);
    self.menuLabel.frame = CGRectMake((containerWidth - labelWidth)/2, imageHeight + self.space, labelWidth, labelHeight);
}

- (UIView *)menuContainerView {
    if (!_menuContainerView) {
        _menuContainerView = [[UIView alloc] init];
    }
    return _menuContainerView;
}

- (UIImageView *)menuImageView {
    if (!_menuImageView) {
        _menuImageView = [[UIImageView alloc] init];
    }
    return _menuImageView;
}
- (UILabel *)menuLabel {
    if (!_menuLabel) {
        _menuLabel = [[UILabel alloc] init];
        _menuLabel.numberOfLines = 0;
        _menuLabel.font = [UIFont systemFontOfSize:14];
        _menuLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _menuLabel;
}

@end
