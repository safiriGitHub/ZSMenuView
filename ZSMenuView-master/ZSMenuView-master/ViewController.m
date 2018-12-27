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

@interface ViewController ()<ZSMenuViewDataSource,ZSMenuViewDelegate ,UITextFieldDelegate>

@property (nonatomic ,assign) NSInteger menuItems;
@property (nonatomic ,weak) ZSMenuView *menuView;

@property (weak, nonatomic) IBOutlet UITextField *numberOfMenusPerlineTF;
@property (weak, nonatomic) IBOutlet UITextField *menuSizeWidthTF;
@property (weak, nonatomic) IBOutlet UITextField *menuSizeHeightTF;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZSMenuView *menuView = [[ZSMenuView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, 300)];
    menuView.dataSource = self;
    menuView.delegate = self;
    menuView.numberOfMenusPerline = 0;
    menuView.backgroundColor = [UIColor yellowColor];
//    menuView.isAdjustContentVerticalCenter = YES;
//    menuView.isAdjustContentHorizontalCenter = YES;
    menuView.flowDirection = FlowDirectionVertical;
    
    menuView.separateStyle = SeparateStyleNone;
    menuView.separateLineWidth = 0.5;
    menuView.separateLineColor = [UIColor blueColor];
    
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

- (NSInteger)menuView:(ZSMenuView *)menuView numberOfItemsInSection:(NSInteger)section {
    return self.menuItems;
}

- (UICollectionViewCell *)menuView:(ZSMenuView *)menuView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZSMenuNormalStyleCell *cell = (ZSMenuNormalStyleCell *)[menuView dequeueReusableCellWithReuseIdentifier:@"cell" atIndexPath:indexPath];
    //normal
    //    cell.menuImageView.image = [UIImage imageNamed:@"main_menu1"];
    //    cell.menuLabel.text = @"title";
    
    //test
    cell.backgroundColor = [UIColor redColor];
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:101];
    if (!label) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 15)];
        label.tag = 101;
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
    }
    label.center = cell.contentView.center;
    label.text = [NSString stringWithFormat:@"%ld",(long)indexPath.item];

    return cell;
}

- (void)menuView:(ZSMenuView *)menuView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexpath %ld - %ld",(long)indexPath.section,(long)indexPath.item);
}

- (BOOL)menuView:(ZSMenuView *)menuView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (UIColor *)menuView:(ZSMenuView *)menuView highlightColorAtIndexPath:(NSIndexPath *)indexPath {
    return [UIColor lightGrayColor];
}
- (UIColor *)menuView:(ZSMenuView *)menuView unhighlightColorAtIndexPath:(NSIndexPath *)indexPath {
    return [UIColor whiteColor];
}
- (UIColor *)menuView:(ZSMenuView *)menuView selectColorAtIndexPath:(NSIndexPath *)indexPath {
    return [UIColor blueColor];
}
- (UIColor *)menuView:(ZSMenuView *)menuView deselectColorAtIndexPath:(NSIndexPath *)indexPath {
    return [UIColor brownColor];
}
// MARK: settings
- (IBAction)addItemClick:(id)sender {
    self.menuItems++;
    [self.menuView reloadData];
}
- (IBAction)reduceItemClick:(id)sender {
    self.menuItems--;
    [self.menuView reloadData];
}
- (IBAction)verticalSpacingSlideChange:(id)sender {
    UISlider *slider = (UISlider *)sender;
    self.menuView.verticalSpacing = slider.value;
}
- (IBAction)horizontalSpacingSlideChange:(id)sender {
    UISlider *slider = (UISlider *)sender;
    self.menuView.horizontalSpacing = slider.value;
}
- (IBAction)SeparateStyleSegmentChange:(id)sender {
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    if (segment.selectedSegmentIndex == 0) {
        self.menuView.separateStyle = SeparateStyleNormal;
    }else if (segment.selectedSegmentIndex == 1) {
        self.menuView.separateStyle = SeparateStyleNone;
    }
    
}


- (IBAction)perlineConfirmButtonClick:(id)sender {
    NSString *numberString = self.numberOfMenusPerlineTF.text;
    if (numberString.length == 0) {
        NSLog(@"输入行数");return;
    }
    NSInteger line = numberString.integerValue;
    self.menuView.numberOfMenusPerline = line;
}

- (IBAction)menuSizeConfirmButtonClick:(id)sender {
    CGFloat width = self.menuSizeWidthTF.text.floatValue;
    CGFloat height = self.menuSizeHeightTF.text.floatValue;
    if (width <=0 || height <= 0) {
        NSLog(@"menuSize不能为0"); return;
    }
    self.menuView.menuSize = CGSizeMake(width, height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
