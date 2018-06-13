//
//  ZSMenuViewConfig.h
//  ZSMenuView-master
//
//  Created by safiri on 2018/6/11.
//  Copyright © 2018年 safiri. All rights reserved.
//

#ifndef ZSMenuViewConfig_h
#define ZSMenuViewConfig_h

@class ZSMenuView,ZSMenuViewCell;

typedef NS_ENUM(NSUInteger, ZSMenuViewFlowDirection) {
    FlowDirectionVertical,
    FlowDirectionHorizontal
};

@protocol ZSMenuViewDataSource <NSObject>

@required;
/// 通过数据源代理获取项目数量
- (NSInteger)numberOfItemsInMenuView:(ZSMenuView *)menuView;

/// 根据指定index传入相应的自定义cell，即自定制菜单View
- (UICollectionViewCell *)menuView:(ZSMenuView *)menuView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol ZSMenuViewDelegate <NSObject>

- (void)menuView:(ZSMenuView *)menuView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end


#endif /* ZSMenuViewConfig_h */
