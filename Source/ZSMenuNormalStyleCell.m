//
//  ZSMenuNormalStyleCell.m
//  ZSMenuView-master
//
//  Created by safiri on 2018/6/13.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import "ZSMenuNormalStyleCell.h"

@interface ZSMenuNormalStyleCell ()

@property (nonatomic ,weak) UIStackView *stackView;

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
    _heightRadio = 0.8;
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionEqualSpacing;
    stackView.alignment = UIStackViewAlignmentCenter;
    [stackView addSubview:self.menuImageView];
    [stackView addSubview:self.menuLabel];
    [stackView addArrangedSubview:self.menuImageView];
    [stackView addArrangedSubview:self.menuLabel];
    [self.contentView addSubview:stackView];
    self.stackView = stackView;
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.stackView.frame = CGRectMake(0, self.contentView.bounds.size.height*(1-self.heightRadio)/2, self.contentView.bounds.size.width, self.contentView.bounds.size.height*self.heightRadio);
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
    }
    return _menuLabel;
}

- (void)setHeightRadio:(CGFloat)heightRadio {
    _heightRadio = heightRadio;
    CGFloat width = self.contentView.bounds.size.width;
    CGFloat height = self.contentView.bounds.size.height;
    self.stackView.frame = CGRectMake(0, height*(1-self.heightRadio)/2, width, height*self.heightRadio);
}
@end
