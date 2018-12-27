# ZSMenuView

#### 项目介绍

菜单控件：

0.0.1：自定义菜单总数、菜单每行个数、菜单样式、菜单间隔、分隔线样式等功能

0.0.9: 增加Highlight、Select相关代理方法，高亮颜色和选择颜色代理方法

0.1.0: 解决一点bug；删除 `ZSMenuCustomCell`类，自定义cell只需要继承 `UICollectionViewCell`

0.1.1: 解决一点bug

#### 软件架构

基于UICollectionView实现


#### 安装教程

pod  'ZSMenuView'

#### 使用说明

```


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //init with frame 
    ZSMenuView *menuView = [[ZSMenuView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, 300)];
    //or autoLayout

    menuView.dataSource = self;
    menuView.delegate = self;

    //自定义菜单每行个数
    menuView.numberOfMenusPerline = 0;

    //菜单内容是否居中
	menuView.isAdjustContentVerticalCenter = YES;
  	menuView.isAdjustContentHorizontalCenter = YES;

  	//菜单内容排列方向：垂直或居中。需优化
    menuView.flowDirection = FlowDirectionVertical;
    
    //分隔线配置
    menuView.separateStyle = SeparateStyleNormal;
    menuView.separateLineWidth = 0.5;
    menuView.separateLineColor = [UIColor blueColor];
    
    //是否翻页
    menuView.pagingEnabled = YES;

    //注册自定义菜单
    [menuView registerClass:[ZSMenuNormalStyleCell class] forCellWithReuseIdentifier:@"cell"];

    [self.view addSubview:menuView];
    self.menuView = menuView;
}

//MARK: - ZSMenuViewDataSource,ZSMenuViewDelegate
- (NSInteger)menuView:(ZSMenuView *)menuView numberOfItemsInSection:(NSInteger)section {
    return self.menuItems; //菜单个数
}

- (ZSMenuCustomCell *)menuView:(ZSMenuView *)menuView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	//获取自定义菜单
    ZSMenuNormalStyleCell *cell = (ZSMenuNormalStyleCell *)[menuView dequeueReusableCellWithReuseIdentifier:@"cell" atIndexPath:indexPath];

    //normal
    //    cell.menuImageView.image = [UIImage imageNamed:@"main_menu1"];
    //    cell.menuLabel.text = @"title";
    
    //test
    cell.backgroundColor = [UIColor redColor];
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:101];
    if (!label) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        label.tag = 101;
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
    }
    label.center = cell.contentView.center;
    label.text = [NSString stringWithFormat:@"%ld",(long)indexPath.item];

    return cell;
}

- (void)menuView:(ZSMenuView *)menuView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	//菜单被点击
    NSLog(@"indexpath %ld - %ld",(long)indexPath.section,(long)indexPath.item);
}

```

![example](https://github.com/safiriGitHub/ZSMenuView/blob/master/gif/example2.gif)
![example](https://github.com/safiriGitHub/ZSMenuView/blob/master/gif/example3.gif)
![更改菜单总数及每行个数](https://github.com/safiriGitHub/ZSMenuView/blob/master/gif/example4.gif)

#### 参与贡献

1. Fork 本项目
2. 新建 Feat_xxx 分支
3. 提交代码
4. 新建 Pull Request
