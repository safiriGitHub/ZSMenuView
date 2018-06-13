//
//  ViewController.m
//  ZSMenuView-master
//
//  Created by safiri on 2018/6/11.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import "ViewController.h"
#import "ZSMenuView.h"
#import "ZSMenuNormalStyleCell.h"

@interface ViewController ()<ZSMenuViewDataSource,ZSMenuViewDelegate>

@property (nonatomic ,weak) ZSMenuView *menuView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZSMenuView *menuView = [[ZSMenuView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, 300)];
    menuView.dataSource = self;
    menuView.delegate = self;
    menuView.numberOfMenusPerline = 5;
    menuView.backgroundColor = [UIColor yellowColor];
    menuView.isAdjustContentVerticalCenter = YES;
    menuView.isAdjustContentHorizontalCenter = YES;
    menuView.flowDirection = FlowDirectionVertical;
    menuView.pagingEnabled = YES;
    [menuView registerClass:[ZSMenuNormalStyleCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:menuView];
    self.menuView = menuView;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.menuView.numberOfMenusPerline = 6;
//        self.menuView.horizontalSpacing = 5;
//        self.menuView.verticalSpacing = 5;
//        self.menuView.isAdjustContentVerticalCenter = NO;
//        self.menuView.numberOfMenusPerline = 3;
    });
}
- (NSInteger)numberOfItemsInMenuView:(ZSMenuView *)menuView {
    return 10;
}

- (UICollectionViewCell *)menuView:(ZSMenuView *)menuView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZSMenuNormalStyleCell *cell = (ZSMenuNormalStyleCell *)[menuView dequeueReusableCellWithReuseIdentifier:@"cell" atIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
//    UILabel *label = (UILabel *)[cell.contentView viewWithTag:101];
//    if (!label) {
//        label = [[UILabel alloc] initWithFrame:cell.bounds];
//        label.tag = 101;
//        label.textAlignment = NSTextAlignmentCenter;
//        [cell.contentView addSubview:label];
//    }
//    label.text = [NSString stringWithFormat:@"%zd",indexPath.item];
    cell.menuImageView.image = [UIImage imageNamed:@"main_menu1"];
    cell.menuLabel.text = @"title";
    
    return cell;
}

- (void)menuView:(ZSMenuView *)menuView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexpath %zd - %zd",indexPath.section,indexPath.item);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
