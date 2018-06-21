//
//  ZSMenuCustomCell.m
//  ZSMenuView-master
//
//  Created by safiri on 2018/6/13.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import "ZSMenuCustomCell.h"

@interface ZSMenuCustomCell ()

@property (nonatomic ,strong) UIView *selectedForegroundView;

@end

@implementation ZSMenuCustomCell

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.selectionColor) {
        self.selectedForegroundView.frame = self.contentView.bounds;
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    super.highlighted = highlighted;
    if (self.selectionColor) {
        if (highlighted) {
            self.selectedForegroundView.layer.backgroundColor = self.selectionColor.CGColor;
        }else if (![super isSelected]) {
            self.selectedForegroundView.layer.backgroundColor = UIColor.clearColor.CGColor;
        }
    }
}
- (void)setSelected:(BOOL)selected {
    super.selected = selected;
    if (self.selectionColor) {
        self.selectedForegroundView.layer.backgroundColor = selected ? self.selectionColor.CGColor : [UIColor clearColor].CGColor;
    }
}

- (UIView *)selectedForegroundView {
    if (!_selectedForegroundView) {
        UIView *view = [[UIView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:view];
        _selectedForegroundView = view;
    }
    return _selectedForegroundView;
}

@end
