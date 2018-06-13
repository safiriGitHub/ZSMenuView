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
    //CGFloat side = (self.collectionView.bounds.size.width - self.minimumLineSpacing*(self.itemsPerline-1))/self.itemsPerline;
    CGFloat side = self.collectionView.bounds.size.width/self.itemsPerline;
    self.itemSize = CGSizeMake(side, side);
    //居中调整
    //self.sectionInset = UIEdgeInsetsMake(<#CGFloat top#>, 0, <#CGFloat bottom#>, 0)
    
}
//- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
//    //解决bug:分隔线宽度会出现不一致
//    NSArray *answer = [super layoutAttributesForElementsInRect:rect];
//    for(int i = 1; i < [answer count]; ++i) {
//        //1.竖向间距调整成一样：不成功
//        UICollectionViewLayoutAttributes *currentLayoutAttributes = answer[i];
//        UICollectionViewLayoutAttributes *prevLayoutAttributes = answer[i - 1];
//        NSInteger maximumSpacing = 0.5;
//        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
//        
//        CGRect frame = currentLayoutAttributes.frame;
//        frame.origin.x = origin + maximumSpacing;
//        currentLayoutAttributes.frame = frame;
//       
//        //2.横向间距调整成一样：未完成
//    }
//    return answer;
//}
//MARK: Public func
- (void)reloadLayout {
    [self invalidateLayout];
}

- (CGFloat)calculateContentVerticalCenterEdgeForSectionAtIndex:(NSInteger)section {
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
    NSInteger lines = [self calculateLinesWithTotalItems:numberOfItems andPerLineItems:self.itemsPerline];
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
