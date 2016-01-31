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

@implementation TTTabBarController

/**
 *  什么时候调用:程序一启动就会把所有的类加载进内存
 *  作用：加载类的时候调用
 */
//+ (void)load {
//
//}

/**
 *  什么时候调用：当第一次使用这个类或者子类的时候调用
 *  作用：初始化类
 
 *  appearance只要一个类遵守UIAppearance，就能获取全局的外观，UIView
 */
+ (void)initialize {
    // 获取所有的tabBarItem外观标识
//    UITabBarItem *item = [UITabBarItem appearance];
    
    // self -> TTTabBarController
    // 获取当前这个类下面的所有的tabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor orangeColor];
    //    [attributes setObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName]; // 等同上面
    
    [item setTitleTextAttributes:attributes forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    
    // 添加所有子控制器
    [self setUpAllChildViewController];
    
    // 自定义tabBar
    TTTabBar *tabBar = [[TTTabBar alloc] initWithFrame:self.tabBar.frame];
    NSLog(@"%@----", self.tabBar);

    // 利用KVC把readonly的属性值改了
    [self setValue:tabBar forKey:@"tabBar"];
    
    NSLog(@"%@", self.tabBar);
//    self.tabBar = tabBar;
    // 修改系统tabBar上面的按钮的位置
//    NSLog(@"%@",self.tabBar.subviews);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    NSLog(@"%@",self.tabBar.subviews);
}


#pragma mark - 添加所有的子控制器
- (void)setUpAllChildViewController {
    // 首页
    UIViewController *home = [[UIViewController alloc] init];
    home.view.backgroundColor = [UIColor greenColor];
    [self setUpOneChildViewController:home image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"首页"];

    
    // 消息
    UIViewController *message = [[UIViewController alloc] init];
    message.view.backgroundColor = [UIColor redColor];
    [self setUpOneChildViewController:message image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] title:@"消息"];


    
    // 发现
    UIViewController *discover = [[UIViewController alloc] init];
    discover.view.backgroundColor = [UIColor purpleColor];
    [self setUpOneChildViewController:discover image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];
    
    // 我
    UIViewController *profile = [[UIViewController alloc] init];
    profile.view.backgroundColor = [UIColor grayColor];
    [self setUpOneChildViewController:profile image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我"];

}

/**
 *  添加一个自控制器
 *
 *  @param vc            vc
 *  @param image         image
 *  @param selectedImage selectedImage
 *  @param title         title
 */
- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title {
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = image;
    
    vc.tabBarItem.selectedImage = selectedImage;
    vc.tabBarItem.badgeValue = @"10";

    [self addChildViewController:vc];
}

@end
