//
//  ExampleVC2.m
//  ZSMenuView-master
//
//  Created by safiri on 2018/7/6.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import "ExampleVC2.h"
#import "ZSMenuView.h"
#import "ZSMenuNormalStyleCell.h"

@interface ExampleVC2 ()<ZSMenuViewDataSource,ZSMenuViewDelegate>

@property (nonatomic ,weak) ZSMenuView *menuView;

@end

@implementation ExampleVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    CGFloat height = roundf(self.view.frame.size.width/5);
    ZSMenuView *menuView = [[ZSMenuView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, height)];
    menuView.dataSource = self;
    menuView.delegate = self;
    menuView.numberOfMenusPerline = 5;
    menuView.isAdjustContentVerticalCenter = YES;
    menuView.isAdjustContentHorizontalCenter = YES;
    menuView.flowDirection = FlowDirectionHorizontal;
    menuView.alwaysBounceHorizontal = NO;
    menuView.alwaysBounceVertical = NO;
    //menuView.pagingEnabled = YES;
    [menuView registerClass:[ZSMenuNormalStyleCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:menuView];
    self.menuView = menuView;
}

- (NSInteger)menuView:(ZSMenuView *)menuView numberOfItemsInSection:(NSInteger)section {
    return 3;
}
- (ZSMenuCustomCell *)menuView:(ZSMenuView *)menuView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZSMenuNormalStyleCell *cell = (ZSMenuNormalStyleCell *)[menuView dequeueReusableCellWithReuseIdentifier:@"cell" atIndexPath:indexPath];
    //normal
    cell.menuImageView.image = [UIImage imageNamed:@"main_menu1"];
    cell.labelWidthRadio = 1;
    cell.menuLabel.text = @"京东汽车";
    cell.menuLabel.adjustsFontSizeToFitWidth = YES;
    cell.menuLabel.numberOfLines = 1;
    cell.space = 0;
    cell.menuLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    cell.contentEdge = UIEdgeInsetsMake(8, 0, 5, 0);
    cell.menuLabel.textAlignment = NSTextAlignmentCenter;
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
