//
//  ZSMenuCustomFlowLayout.h
//  ZSMenuView-master
//
//  Created by safiri on 2018/6/12.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZSMenuCustomFlowLayout : UICollectionViewFlowLayout

@property (nonatomic ,assign) NSInteger itemsPerline;

/// 刷新布局 equal to [self invalidateLayout]
- (void)reloadLayout;

/// 计算使内容水平居中需要调整的UIEdgeInsets.left/right为多少
- (CGFloat)calculateContentHorizontalCenterEdgeForSectionAtIndex:(NSInteger)section;
/// 计算使内容竖直居中需要调整的UIEdgeInsets.top/bottom为多少
- (CGFloat)calculateContentVerticalCenterEdgeForSectionAtIndex:(NSInteger)section;
/// 计算行数：根据总item数和每行个数计算行数
- (NSInteger)calculateLinesWithTotalItems:(NSInteger)totalItems andPerLineItems:(NSInteger)perLineItems;
@end
