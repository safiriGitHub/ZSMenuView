//
//  ZSMenuCustomFlowLayout.m
//  ZSMenuView-master
//
//  Created by safiri on 2018/6/12.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import "ZSMenuCustomFlowLayout.h"

@implementation ZSMenuCustomFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        _itemsPerline = 1;
    }
    return self;
}

//MARK: override
- (void)prepareLayout {
    [super prepareLayout];
    [self setupLayout]; //初始化布局
}

- (void)setupLayout {
    if (self.itemsPerline > 0) {
        CGFloat side = (self.collectionView.bounds.size.width - self.minimumInteritemSpacing*(self.itemsPerline-1))/self.itemsPerline;
        side = floorf(side);
        self.itemSize = CGSizeMake(side, side);
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *answer = [super layoutAttributesForElementsInRect:rect];
    
    //解决bug: 确定每行菜单数目后，计算出菜单size会出现小数，导致菜单出现间隔
    if (self.itemsPerline > 0) {
        CGFloat overflowWidth = self.collectionView.bounds.size.width - self.itemSize.width*self.itemsPerline;
        if (overflowWidth > 0) {
            for(int i = 1; i < [answer count]; ++i) {
    
                UICollectionViewLayoutAttributes *currentLayoutAttributes = answer[i];
                UICollectionViewLayoutAttributes *prevLayoutAttributes = answer[i - 1];
                if (prevLayoutAttributes.frame.origin.y == currentLayoutAttributes.frame.origin.y) {//只对同一行操作
                    
                    NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
                    CGRect frame = currentLayoutAttributes.frame;
                    frame.origin.x = origin;//消除缝隙
                    if ((i + 1)%self.itemsPerline == 0) {
                        frame.size.width += overflowWidth;//每行最后一个菜单增宽
                    }
                    currentLayoutAttributes.frame = frame;
                }
            }
        }
    }
    
    return answer;
}


//MARK: Public func
- (void)reloadLayout {
    [self invalidateLayout];
}
- (NSInteger)linesForSection:(NSInteger)section {
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
    NSInteger lines = [self calculateLinesWithTotalItems:numberOfItems andPerLineItems:self.itemsPerline];
    return lines;
}

- (CGFloat)calculateContentVerticalCenterEdgeForSectionAtIndex:(NSInteger)section {
    NSInteger lines = [self linesForSection:section];
    CGFloat combinedItemHeight = (lines * self.itemSize.height) + ((lines - 1)*self.minimumLineSpacing);
    CGFloat paddingV = (self.collectionView.frame.size.height - combinedItemHeight)/2;
    paddingV = paddingV>0 ? paddingV:0;
    return paddingV;
}
- (CGFloat)calculateContentHorizontalCenterEdgeForSectionAtIndex:(NSInteger)section {
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
    CGFloat combinedItemWidth = (numberOfItems * self.itemSize.width) + ((numberOfItems - 1)*self.minimumInteritemSpacing);
    CGFloat paddingH = (self.collectionView.frame.size.width - combinedItemWidth)/2;
    paddingH = paddingH>0 ? paddingH:0;
    return paddingH;
}
- (NSInteger)calculateLinesWithTotalItems:(NSInteger)totalItems andPerLineItems:(NSInteger)perLineItems {
    CGFloat lines = 0;
    NSInteger a = totalItems % perLineItems;
    NSInteger b = totalItems / perLineItems;
    //总数 % 行的个数 = 余数  是否等于0判断是否换段
    if (a == 0) {
        lines = b;
    }else {
        lines = b + 1;
    }
    return lines;
}
@end
