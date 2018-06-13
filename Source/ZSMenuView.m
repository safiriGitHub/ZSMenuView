//
//  ZSMenuView.m
//  ZSMenuView-master
//
//  Created by safiri on 2018/6/11.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import "ZSMenuView.h"
#import "ZSMenuCustomFlowLayout.h"

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
//    _horizontalSpacing = 0.5;
//    _verticalSpacing = 0.5;
    _flowDirection = FlowDirectionVertical;
    _alwaysBounceHorizontal = NO;
    _alwaysBounceVertical = NO;
    _showsHorizontalScrollIndicator = NO;
    _showsVerticalScrollIndicator = NO;
    
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
//    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    cell.layer.borderWidth = 4;
//    if ([cell isKindOfClass:ZSPagerViewCell.class]) {
//        return (ZSPagerViewCell *)cell;
//    }else {
//        //fatalError("Cell class must be subclass of FSPagerViewCell");
//        return nil;
//    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataSource == nil) {
        return 0;
    }
    if ([self.dataSource respondsToSelector:@selector(numberOfItemsInMenuView:)]) {
        self.numberOfMenus = [self.dataSource numberOfItemsInMenuView:self];
    }
    if (self.numberOfMenus <= 0) {
        return 0;
    }
    return self.numberOfMenus;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self.dataSource menuView:self cellForItemAtIndexPath:indexPath];
//    cell.layer.borderWidth = self.separateLineWidth;
//    if (self.separateLineColor) {
//        cell.layer.borderColor = self.separateLineColor.CGColor;
//    }
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
        //_contentView.backgroundColor = self.separateLineColor;
    }
    return _contentView;
}
- (CGSize)menuSize {
    return self.customFlowLayout.itemSize;
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
//- (void)setSeparateLineColor:(UIColor *)separateLineColor {
//    _separateLineColor = separateLineColor;
//    self.contentView.backgroundColor = separateLineColor;
//}
- (void)setNumberOfMenusPerline:(NSInteger)numberOfMenusPerline {
    if (numberOfMenusPerline <= 0) {
        return;
    }
    _numberOfMenusPerline = numberOfMenusPerline;
    self.customFlowLayout.itemsPerline = numberOfMenusPerline;
    [self.customFlowLayout reloadLayout];
}
//- (void)setHorizontalSpacing:(CGFloat)horizontalSpacing {
//    _horizontalSpacing = horizontalSpacing;
//    self.customFlowLayout.minimumLineSpacing = horizontalSpacing;
//    [self.customFlowLayout reloadLayout];
//}
//- (void)setVerticalSpacing:(CGFloat)verticalSpacing {
//    _verticalSpacing = verticalSpacing;
//    self.customFlowLayout.minimumInteritemSpacing = verticalSpacing;
//    [self.customFlowLayout reloadLayout];
//}
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
