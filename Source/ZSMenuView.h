//
//  ZSMenuView.h
//  ZSMenuView-master
//
//  Created by safiri on 2018/6/11.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSMenuViewConfig.h"

@interface ZSMenuView : UIView

@property (nonatomic ,weak ,nullable) id <ZSMenuViewDataSource>dataSource;
@property (nonatomic ,weak ,nullable) id <ZSMenuViewDelegate>delegate;

// MARK: - set FlowLayout
/// 菜单个数
@property (nonatomic ,assign ,readonly) NSInteger numberOfMenus;
/// 菜单Size numberOfMenusPerline为0才生效
@property (nonatomic ,assign) CGSize menuSize;
/// 每行菜单个数 若为0，则以menuSize为主
@property (nonatomic ,assign) NSInteger numberOfMenusPerline;
/// 横向间距 
@property (nonatomic ,assign) CGFloat horizontalSpacing;
/// 竖向间距
@property (nonatomic ,assign) CGFloat verticalSpacing;
/// 排列方向
@property (nonatomic ,assign) ZSMenuViewFlowDirection flowDirection;
/** 是否根据collectionView的宽度和内容宽度调整内容为水平方向居中
 通过调整sectionInset实现，默认NO
 */
@property (nonatomic ,assign) BOOL isAdjustContentHorizontalCenter;
/** 是否根据collectionView的高度和内容高度调整内容为竖直方向居中
    通过调整sectionInset实现，默认NO
 */
@property (nonatomic ,assign) BOOL isAdjustContentVerticalCenter;

// MARK: - set CollectionView
@property (nonatomic ,assign) BOOL alwaysBounceHorizontal;//Default:No
@property (nonatomic ,assign) BOOL alwaysBounceVertical;//Default:No
@property (nonatomic ,assign) BOOL showsVerticalScrollIndicator;//Default:No
@property (nonatomic ,assign) BOOL showsHorizontalScrollIndicator;//Default:No
@property (nonatomic ,assign) BOOL pagingEnabled;//Default:No

// MARK: - set View
/// 可设置背景图View
@property (nonatomic ,strong, nullable) UIView *backgroundView;

/// 分隔线样式，默认SeparateStyleNone for numberOfMenusPerline>0
@property (nonatomic ,assign) ZSMenuViewSeparateStyle separateStyle;
/// 分隔线颜色 默认whiteColor for numberOfMenusPerline>0
@property (nonatomic ,strong, nullable) UIColor *separateLineColor;
/// 分隔线宽度 默认0 for numberOfMenusPerline>0
@property (nonatomic ,assign) CGFloat separateLineWidth;


// MARK: - public func

- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;
- (void)registerNib:(UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier;
- (UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier atIndexPath:(NSIndexPath *)indexPath;
- (void)reloadData;
@end
