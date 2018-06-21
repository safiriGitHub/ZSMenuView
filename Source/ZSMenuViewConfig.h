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

- (void)menuView:(ZSMenuView *)menuView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end


#endif /* ZSMenuViewConfig_h */
