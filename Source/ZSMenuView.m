//
//  ZSMenuView.m
//  ZSMenuView-master
//
//  Created by safiri on 2018/6/11.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import "ZSMenuView.h"
#import "ZSMenuCustomFlowLayout.h"
#import "ZSMenuCustomCell.h"

@interface ZSMenuView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,assign ,readwrite) NSInteger numberOfMenus;

@property (nonatomic ,strong) ZSMenuCustomFlowLayout *customFlowLayout;
@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) UIView *contentView;
@end

@implementation ZSMenuView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}
- (void)commonInit {
    //data
    _flowDirection = FlowDirectionVertical;
    _alwaysBounceHorizontal = NO;
    _alwaysBounceVertical = NO;
    _showsHorizontalScrollIndicator = NO;
    _showsVerticalScrollIndicator = NO;
    _separateLineColor = [UIColor whiteColor];
    
    //view
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.collectionView];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundView.frame = self.bounds;
    self.contentView.frame = self.bounds;
    self.collectionView.frame = self.contentView.bounds;
}
#pragma mark - Public func
- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier {
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
}
- (void)registerNib:(UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier {
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
}
- (UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}
- (void)reloadData {
    [self.collectionView reloadData];
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataSource == nil) {
        return 0;
    }
    if ([self.dataSource respondsToSelector:@selector(menuView:numberOfItemsInSection:)]) {
        self.numberOfMenus = [self.dataSource menuView:self numberOfItemsInSection:section];
    }
    if (self.numberOfMenus <= 0) {
        return 0;
    }
    return self.numberOfMenus;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZSMenuCustomCell *cell = [self.dataSource menuView:self cellForItemAtIndexPath:indexPath];
    if (self.separateStyle == SeparateStyleNormal && self.customFlowLayout.itemsPerline > 0) {
        //normal style
        [cell hideAllBorders];
        if (indexPath.item/self.customFlowLayout.itemsPerline < [self.customFlowLayout linesForSection:indexPath.section] - 1) {
            [cell addBorderWithBorderColor:self.separateLineColor borderWidth:self.separateLineWidth top:NO left:NO bottom:YES right:NO];
        }
        if ((indexPath.item+1)%self.customFlowLayout.itemsPerline != 0) {
            [cell addBorderWithBorderColor:self.separateLineColor borderWidth:self.separateLineWidth top:NO left:NO bottom:NO right:YES];
        }
    }
    else if (self.separateStyle == SeparateStyleNone) {
        [cell hideAllBorders];
    }
    
    
    return cell;
}
#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(menuView:didSelectItemAtIndexPath:)]) {
        [self.delegate menuView:self didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat paddingH = 0;
    CGFloat paddingV = 0;
    if (self.isAdjustContentVerticalCenter) {
        paddingV = [self.customFlowLayout calculateContentVerticalCenterEdgeForSectionAtIndex:section];
    }else if (self.isAdjustContentHorizontalCenter) {
        paddingH = [self.customFlowLayout calculateContentHorizontalCenterEdgeForSectionAtIndex:section];
    }
    return UIEdgeInsetsMake(paddingV, paddingH,paddingV, paddingH);
}

#pragma mark - getters and setters
- (ZSMenuCustomFlowLayout *)customFlowLayout {
    if (!_customFlowLayout) {
        _customFlowLayout = [[ZSMenuCustomFlowLayout alloc] init];
        _customFlowLayout.minimumLineSpacing = 0;
        _customFlowLayout.minimumInteritemSpacing = 0;
        //_customFlowLayout.itemSize = self.itemSize;
        //_customFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _customFlowLayout;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.customFlowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.alwaysBounceHorizontal = self.alwaysBounceHorizontal;
        _collectionView.alwaysBounceVertical = self.alwaysBounceVertical;
        _collectionView.showsHorizontalScrollIndicator = self.showsHorizontalScrollIndicator;
        _collectionView.showsVerticalScrollIndicator = self.showsVerticalScrollIndicator;
        [self.contentView addSubview:_collectionView];
    }
    return _collectionView;
}
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _contentView;
}

- (void)setMenuSize:(CGSize)menuSize {
    if (self.numberOfMenusPerline == 0) {
        self.customFlowLayout.itemSize = menuSize;
    }
}
- (CGSize)menuSize {
    return self.customFlowLayout.itemSize;
}
- (void)setNumberOfMenusPerline:(NSInteger)numberOfMenusPerline {
    if (numberOfMenusPerline < 0) numberOfMenusPerline = 0;
    _numberOfMenusPerline = numberOfMenusPerline;
    self.customFlowLayout.itemsPerline = numberOfMenusPerline;
    [self.customFlowLayout reloadLayout];
    if (self.separateStyle != SeparateStyleNone) {
        [self reloadData];
    }
}

- (void)setBackgroundView:(UIView *)backgroundView {
    if (backgroundView) {
        if (_backgroundView && _backgroundView.superview) {
            [_backgroundView removeFromSuperview];
        }
        _backgroundView = backgroundView;
        [self insertSubview:_backgroundView atIndex:0];
        [self setNeedsLayout];
    }
}
- (void)setSeparateStyle:(ZSMenuViewSeparateStyle)separateStyle {
    _separateStyle = separateStyle;
    [self reloadData];
}
- (void)setSeparateLineColor:(UIColor *)separateLineColor {
    _separateLineColor = separateLineColor;
    [self reloadData];
}
- (void)setSeparateLineWidth:(CGFloat)separateLineWidth {
    _separateLineWidth = separateLineWidth;
    [self reloadData];
}

- (void)setHorizontalSpacing:(CGFloat)horizontalSpacing {
    _horizontalSpacing = horizontalSpacing;
    self.customFlowLayout.minimumLineSpacing = horizontalSpacing;
    [self.customFlowLayout reloadLayout];
}
- (void)setVerticalSpacing:(CGFloat)verticalSpacing {
    _verticalSpacing = verticalSpacing;
    self.customFlowLayout.minimumInteritemSpacing = verticalSpacing;
    [self.customFlowLayout reloadLayout];
    if (self.separateStyle != SeparateStyleNone) {
        [self reloadData];
    }
}
- (void)setIsAdjustContentVerticalCenter:(BOOL)isAdjustContentVerticalCenter {
    _isAdjustContentVerticalCenter = isAdjustContentVerticalCenter;
    [self.customFlowLayout reloadLayout];
}
- (void)setFlowDirection:(ZSMenuViewFlowDirection)flowDirection {
    _flowDirection = flowDirection;
    if (flowDirection == FlowDirectionVertical) {
        self.customFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }else if (flowDirection == FlowDirectionHorizontal){
        self.customFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    [self.customFlowLayout reloadLayout];
}
// MARK: set CollectionView
- (void)setAlwaysBounceVertical:(BOOL)alwaysBounceVertical {
    _alwaysBounceVertical = alwaysBounceVertical;
    self.collectionView.alwaysBounceVertical = alwaysBounceVertical;
}
- (void)setAlwaysBounceHorizontal:(BOOL)alwaysBounceHorizontal {
    _alwaysBounceHorizontal = alwaysBounceHorizontal;
    self.collectionView.alwaysBounceHorizontal = alwaysBounceHorizontal;
}
- (void)setShowsVerticalScrollIndicator:(BOOL)showsVerticalScrollIndicator {
    _showsVerticalScrollIndicator = showsVerticalScrollIndicator;
    self.collectionView.showsVerticalScrollIndicator = showsVerticalScrollIndicator;
}
- (void)setShowsHorizontalScrollIndicator:(BOOL)showsHorizontalScrollIndicator {
    _showsHorizontalScrollIndicator = showsHorizontalScrollIndicator;
    self.collectionView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator;
}
- (void)setPagingEnabled:(BOOL)pagingEnabled {
    _pagingEnabled = pagingEnabled;
    self.collectionView.pagingEnabled = pagingEnabled;
}
@end
