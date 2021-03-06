//
//  ZSMenuNormalStyleCell.h
//  ZSMenuView-master
//
//  Created by safiri on 2018/6/13.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZSMenuNormalStyleCell : UICollectionViewCell

/// 菜单内容edge
@property (nonatomic ,assign) UIEdgeInsets contentEdge;

/// 菜单图片
@property (nonatomic ,strong) UIImageView *menuImageView;

/// 菜单图片大小，默认为Zero，这时大小由设置的图片确定。
@property (nonatomic ,assign) CGSize menuImageSize;

/// 菜单标题, 很多属性直接自定义
@property (nonatomic ,strong) UILabel *menuLabel;

/// 图片与标题间距离
@property (nonatomic ,assign) CGFloat space;

/// 控制标题宽度; 默认为0，标题宽度和图片宽度相同
@property (nonatomic ,assign) CGFloat labelWidthRadio;

@end
