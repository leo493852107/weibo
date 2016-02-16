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

#import "TTUserTool.h"
#import "TTUserResult.h"

#import "TTComposeViewController.h"

@interface TTTabBarController () <TTTabBarDelegate>

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, weak) TTHomeViewController *home;

@property (nonatomic, weak) TTMessageViewController *message;

@property (nonatomic, weak) TTProfileViewController *profile;

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
    
    // 每隔一段时间(2s)请求未读数
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(requestUnread) userInfo:nil repeats:YES];
    
}

- (void)requestUnread {
    
    // 请求微博的未读数
    [TTUserTool unreadWithSuccess:^(TTUserResult *result) {
        
        // 设置首页未读数
        _home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        
        // 设置消息未读数
        _message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
        
        // 设置我的未读数
        _profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
        
        // 设置应用程序所有的未读数
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;
        
    } failure:^(NSError *error) {
        
    }];

}

#pragma mark - 设置tabBar
- (void)setUpTabBar {
    // 自定义tabBar
    TTTabBar *tabBar = [[TTTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabBar.backgroundColor = [UIColor whiteColor];
    
    // 设置代理
    tabBar.delegate = self;
    
    // 给tabBar传递tabBarItem模型
    tabBar.items = self.items;
    
    // 添加自定义tabBar
    [self.tabBar addSubview:tabBar];
    
}

#pragma mark - 当点击tabBar上的按钮调用
- (void)tabBar:(TTTabBar *)tabBar didClickButton:(NSInteger)index {
    
    // 点击首页，刷新(注： 从 首页->消息->首页 首页不刷新 self.selectedIndex)
    if (index == 0 && self.selectedIndex == index) {
        [_home refresh];
    }
    self.selectedIndex = index;
}

// 点击加号按钮的时候调用
- (void)tabBarDidClickPlusButton:(TTTabBar *)tabBar {
    // 创建发送微博控制器
    TTComposeViewController *composeVC = [[TTComposeViewController alloc] init];
    TTNavigationController *nav = [[TTNavigationController alloc] initWithRootViewController:composeVC];
    [self presentViewController:nav animated:YES completion:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 移除系统的tabBarButton
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
    }

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
    _message = message;

    // 发现
    TTDiscoverViewController *discover = [[TTDiscoverViewController alloc] init];
    [self setUpOneChildViewController:discover image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];
    
    // 我
    TTProfileViewController *profile = [[TTProfileViewController alloc] init];
    [self setUpOneChildViewController:profile image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我"];
    _profile = profile;

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
    
    // initWithRootViewController底层就会调用导航控制器的push方法，把根控制器压入栈
    TTNavigationController *nav = [[TTNavigationController alloc] initWithRootViewController:vc];

    [self addChildViewController:nav];
    
}

@end
