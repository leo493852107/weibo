//
//  TTTabBarController.m
//  weibo
//
//  Created by leo on 16/1/30.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTTabBarController.h"
#import "UIImage+Image.h"
#import "TTTabBar.h"

#import "TTHomeViewController.h"
#import "TTMessageViewController.h"
#import "TTDiscoverViewController.h"
#import "TTProfileViewController.h"

#import "TTNavigationController.h"

@interface TTTabBarController () <TTTabBarDelegate>

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, weak) TTHomeViewController *home;

@end

@implementation TTTabBarController

- (NSMutableArray *)items {
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加所有子控制器
    [self setUpAllChildViewController];
    
    // 自定义tabBar
    [self setUpTabBar];
    
}

#pragma mark - 设置tabBar
- (void)setUpTabBar {
    // 自定义tabBar
    TTTabBar *tabBar = [[TTTabBar alloc] initWithFrame:self.tabBar.frame];
    tabBar.backgroundColor = [UIColor whiteColor];
    
    // 设置代理
    tabBar.delegate = self;
    
    // 给tabBar传递tabBarItem模型
    tabBar.items = self.items;
    
    // 添加自定义tabBar
    [self.view addSubview:tabBar];
    
    // 移除系统的tabBar
    [self.tabBar removeFromSuperview];
}

#pragma mark - 当点击tabBar上的按钮调用
- (void)tabBar:(TTTabBar *)tabBar didClickButton:(NSInteger)index {
    self.selectedIndex = index;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


#pragma mark - 添加所有的子控制器
- (void)setUpAllChildViewController {
    // 首页
    TTHomeViewController *home = [[TTHomeViewController alloc] init];
    [self setUpOneChildViewController:home image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"首页"];
    _home = home;
    
    // 消息
    TTMessageViewController *message = [[TTMessageViewController alloc] init];
    [self setUpOneChildViewController:message image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] title:@"消息"];


    
    // 发现
    TTDiscoverViewController *discover = [[TTDiscoverViewController alloc] init];
    [self setUpOneChildViewController:discover image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];
    
    // 我
    TTProfileViewController *profile = [[TTProfileViewController alloc] init];
    [self setUpOneChildViewController:profile image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我"];

}

// navigationItem决定导航条上的内容
// 导航条上的内容由栈顶控制器的navigationItem决定


/**
 *  添加一个子控制器
 *
 *  @param vc            vc
 *  @param image         image
 *  @param selectedImage selectedImage
 *  @param title         title
 */
- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title {
    vc.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    
    // 保存tabBarItem模型到数组
    [self.items addObject:vc.tabBarItem];
    
    TTNavigationController *nav = [[TTNavigationController alloc] initWithRootViewController:vc];

    [self addChildViewController:nav];
    
}

@end
