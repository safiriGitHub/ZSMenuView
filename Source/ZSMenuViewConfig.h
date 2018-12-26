//
//  ZSMenuViewConfig.h
//  ZSMenuView-master
//
//  Created by safiri on 2018/6/11.
//  Copyright © 2018年 safiri. All rights reserved.
//

#ifndef ZSMenuViewConfig_h
#define ZSMenuViewConfig_h

@class ZSMenuView,ZSMenuCustomCell;

typedef NS_ENUM(NSUInteger, ZSMenuViewFlowDirection) {
    FlowDirectionVertical,
    FlowDirectionHorizontal
};

typedef NS_ENUM(NSUInteger, ZSMenuViewSeparateStyle) {
    SeparateStyleNone, //Custom
    SeparateStyleNormal
};

@protocol ZSMenuViewDataSource <NSObject>

@required;
/// 通过数据源代理获取项目数量
- (NSInteger)menuView:(ZSMenuView *)menuView numberOfItemsInSection:(NSInteger)section;

/// 根据指定index传入相应的自定义cell，即自定制菜单View
- (ZSMenuCustomCell *)menuView:(ZSMenuView *)menuView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol ZSMenuViewDelegate <NSObject>

// Methods for notification of selection/deselection and highlight/unhighlight events.
// The sequence of calls leading to selection from a user touch is:
//
// (when the touch begins)
// 1. -collectionView:shouldHighlightItemAtIndexPath:
// 2. -collectionView:didHighlightItemAtIndexPath:
//
// (when the touch lifts)
// 3. -collectionView:shouldSelectItemAtIndexPath: or -collectionView:shouldDeselectItemAtIndexPath:
// 4. -collectionView:didSelectItemAtIndexPath: or -collectionView:didDeselectItemAtIndexPath:
// 5. -collectionView:didUnhighlightItemAtIndexPath:
- (BOOL)menuView:(ZSMenuView *)menuView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)menuView:(ZSMenuView *)menuView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)menuView:(ZSMenuView *)menuView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)menuView:(ZSMenuView *)menuView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)menuView:(ZSMenuView *)menuView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath; // called when the user taps on an already-selected item in multi-select mode
- (void)menuView:(ZSMenuView *)menuView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)menuView:(ZSMenuView *)menuView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath;

// MARK: - set cell
//设置点击高亮和非高亮颜色
- (UIColor *)menuView:(ZSMenuView *)menuView highlightColorAtIndexPath:(NSIndexPath *)indexPath;
- (UIColor *)menuView:(ZSMenuView *)menuView unhighlightColorAtIndexPath:(NSIndexPath *)indexPath;
- (UIColor *)menuView:(ZSMenuView *)menuView selectColorAtIndexPath:(NSIndexPath *)indexPath;
- (UIColor *)menuView:(ZSMenuView *)menuView deselectColorAtIndexPath:(NSIndexPath *)indexPath;

@end


#endif /* ZSMenuViewConfig_h */
