//
//  TTRootTool.m
//  weibo
//
//  Created by leo on 16/2/9.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTRootTool.h"
#define TTVersionKey @"version"
#import "TTTabBarController.h"
#import "TTNewFeatureController.h"

@implementation TTRootTool

// 选择根控制器
+ (void)chooseRootViewController:(UIWindow *)window {
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
        window.rootViewController = tabBarVC;
        
    } else {
        // 有最新的版本号
        // 进入新特性界面
        // 如果有新特性，进入新特性界面
        TTNewFeatureController *newFeatureVC = [[TTNewFeatureController alloc] init];
        
        window.rootViewController = newFeatureVC;
        
        // 保存当前的版本，用偏好设置
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:TTVersionKey];
    }
}

@end
