//
//  TTHomeViewController.m
//  weibo
//
//  Created by leo on 16/2/1.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTHomeViewController.h"

#import "UIBarButtonItem+Item.h"
#import "TTTitleButton.h"

#import "TTPopMenu.h"
#import "TTCover.h"
#import "TTOneViewController.h"

@interface TTHomeViewController ()<TTCoverDelegate>

@property (nonatomic, weak) TTTitleButton *titleButton;
@property (nonatomic, strong) TTOneViewController *one;

@end

@implementation TTHomeViewController

- (TTOneViewController *)one {
    if (_one == nil) {
        _one = [[TTOneViewController alloc] init];
    }
    return _one;
}

// UIBarButtonItem:决定导航条上按钮的内容
// UINavigationItem:决定导航条上内容
// UITabBarItem:决定tabBar上按钮的内容
// ios7之后，会把tabBar上和导航条上的按钮渲染
// 导航条上自定义按钮的位置是由系统决定，尺寸才需要自己设置。
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航条内容
    [self setUpNavigationBar];
}

#pragma mark - 设置导航条
- (void)setUpNavigationBar {
    
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWidthImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendsearch) forControlEvents:UIControlEventTouchUpInside];
    
    // 右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWidthImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    // titleView
    TTTitleButton *titleButton = [TTTitleButton buttonWithType:UIButtonTypeCustom];
    _titleButton = titleButton;
    
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    
    // 高亮的时候不需要调整图片
    titleButton.adjustsImageWhenHighlighted = NO;
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
    
}

// 以后只要显示在最前面的控件，一般都加在主窗口
// 点击标题按钮
-(void)titleClick:(UIButton *)button {
    button.selected = !button.selected;
    
    // 弹出蒙板
    TTCover *cover = [TTCover show];
    cover.delegate = self;
    
    // 弹出pop菜单
    CGFloat popW = 200;
    CGFloat popX = (self.view.width - 200) * 0.5;
    CGFloat popH = popW;
    CGFloat popY = 55;
    TTPopMenu *menu = [TTPopMenu showInRect:CGRectMake(popX, popY, popW, popH)];
    menu.contentView = self.one.view;
}

// 点击蒙板的时候调用
- (void)coverDidClickCover:(TTCover *)cover {
    // 隐藏pop菜单
    [TTPopMenu hide];
    
    _titleButton.selected = NO;
}

- (void)friendsearch {
    
}

- (void)pop {
    [_titleButton setImage:nil forState:UIControlStateNormal];
}

@end
