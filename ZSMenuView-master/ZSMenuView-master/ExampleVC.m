//
//  ExampleVC.m
//  ZSMenuView-master
//
//  Created by safiri on 2018/7/5.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import "ExampleVC.h"
#import "ZSMenuView.h"
#import "ZSMenuNormalStyleCell.h"

@interface ExampleVC ()<ZSMenuViewDataSource,ZSMenuViewDelegate>

@property (nonatomic ,weak) ZSMenuView *menuView;

@end

@implementation ExampleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    ZSMenuView *menuView = [[ZSMenuView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 160)];
    menuView.dataSource = self;
    menuView.delegate = self;
//    menuView.numberOfMenusPerline = 3;
    menuView.menuSize = CGSizeMake(self.view.frame.size.width/3, 156);
    menuView.backgroundColor = [UIColor yellowColor];
    //    menuView.isAdjustContentVerticalCenter = YES;
    //    menuView.isAdjustContentHorizontalCenter = YES;
    menuView.flowDirection = FlowDirectionHorizontal;
    menuView.alwaysBounceHorizontal = NO;
//    menuView.separateStyle = SeparateStyleNone;
//    menuView.separateLineWidth = 0.5;
//    menuView.separateLineColor = [UIColor blueColor];
    
//    menuView.pagingEnabled = YES;
    [menuView registerClass:[ZSMenuNormalStyleCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:menuView];
    self.menuView = menuView;
}
- (NSInteger)menuView:(ZSMenuView *)menuView numberOfItemsInSection:(NSInteger)section {
    return 4;
}
- (UICollectionViewCell *)menuView:(ZSMenuView *)menuView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZSMenuNormalStyleCell *cell = (ZSMenuNormalStyleCell *)[menuView dequeueReusableCellWithReuseIdentifier:@"cell" atIndexPath:indexPath];
    //normal
    cell.menuImageView.image = [UIImage imageNamed:@"commodity1"];
    cell.menuLabel.text = @"京东汽车设备热卖来袭全网低价汽车设备汽车超出了显示范围";
    //cell.menuLabel.backgroundColor = [UIColor redColor];
    cell.menuLabel.numberOfLines = 2;
    cell.menuLabel.font = [UIFont systemFontOfSize:14];
    cell.menuLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    cell.menuLabel.textAlignment = NSTextAlignmentLeft;
    return cell;
}

- (void)menuView:(ZSMenuView *)menuView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexpath %ld - %ld",(long)indexPath.section,(long)indexPath.item);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
