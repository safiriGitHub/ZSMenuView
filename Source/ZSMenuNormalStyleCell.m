//
//  ZSMenuNormalStyleCell.m
//  ZSMenuView-master
//
//  Created by safiri on 2018/6/13.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import "ZSMenuNormalStyleCell.h"

@interface ZSMenuNormalStyleCell ()

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
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.menuImageView];
    [self.contentView addSubview:self.menuLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.contentView.bounds.size.width;
    CGFloat height = self.contentView.bounds.size.height;
    CGFloat imageHeight = width;
    CGFloat imageWidth = height;
    if (CGSizeEqualToSize(self.menuImageSize, CGSizeZero)) {
        imageHeight = self.menuImageView.image.size.height;
        imageWidth = self.menuImageView.image.size.width;
    }else {
        imageHeight = self.menuImageSize.height;
        imageWidth = self.menuImageSize.width;
    }
    
    
    CGFloat labelWidth = width * self.labelWidthRadio;
    if (self.labelWidthRadio == 0) {
        labelWidth = imageWidth;
    }
    CGFloat labelHeight = (height - imageHeight - self.space);//总高度-图片高度-间隔
    CGFloat imageY = (height - imageHeight - self.space - labelHeight)/2;
    if (imageY < 0) {
        imageY = 0;
    }
    CGFloat labelY = imageY + imageHeight + self.space;
    
    self.menuImageView.frame = CGRectMake((width-imageWidth)/2, imageY, imageWidth, imageHeight);
    self.menuLabel.frame = CGRectMake((width-labelWidth)/2, labelY, labelWidth, labelHeight);
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
