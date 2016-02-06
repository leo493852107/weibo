//
//  AppDelegate.m
//  weibo
//
//  Created by leo on 16/1/30.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "AppDelegate.h"

#import "TTOneViewController.h"
#import "TTTabBarController.h"
#import "TTNewFeatureController.h"

#define TTVersionKey @"version"
// 偏好设置的好处
// 1.不需要关心文件名
// 2.快速进行键值对存储

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 1.获取当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    // 2.获取上一次的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:TTVersionKey];
    
    // v1.0
    // 判断当前是否有新的代码
    if ([currentVersion isEqualToString:lastVersion]) {
        // 没有最新的版本号
        // 创建tabBarVC
        TTTabBarController *tabBarVC = [[TTTabBarController alloc] init];
        
        // 设置窗口的根控制器
        self.window.rootViewController = tabBarVC;
        
    } else {
        // 有最新的版本号
        // 进入新特性界面
        // 如果有新特性，进入新特性界面
        TTNewFeatureController *newFeatureVC = [[TTNewFeatureController alloc] init];
        
        self.window.rootViewController = newFeatureVC;
        
        // 保存当前的版本，用偏好设置
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:TTVersionKey];
    }
    
    // 显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
