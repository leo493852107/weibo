//
//  AppDelegate.m
//  weibo
//
//  Created by leo on 16/1/30.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "AppDelegate.h"

#import "TTOneViewController.h"

#import "TTOAuthViewController.h"

#import "TTAccountTool.h"
#import "TTRootTool.h"

#import <AVFoundation/AVFoundation.h>

#import <SDWebImage/UIImageView+WebCache.h>

// 偏好设置的好处
// 1.不需要关心文件名
// 2.快速进行键值对存储

@interface AppDelegate ()

@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 注册通知
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:setting];
    
    // 在真机上后台播放，设置音频会话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    // 设置会话类型(后台播放)
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    // 激活
    [session setActive:YES error:nil];
    
    
    // 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 选择根控制器
    // 判断下有没有授权
    if ([TTAccountTool account]) {
        // 已经授权
        // 选择根控制器
        [TTRootTool chooseRootViewController:self.window];
        
    } else {
        // 没有授权，进行授权
        TTOAuthViewController *oauthVC = [[TTOAuthViewController alloc] init];
        
        // 设置窗口的根控制器
        self.window.rootViewController = oauthVC;
    }
    
    // 显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}


// 接收到内存警告的时候调用
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    // 停止所有的下载
    [[SDWebImageManager sharedManager] cancelAll];
    // 删除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}


// 失去焦点
- (void)applicationWillResignActive:(UIApplication *)application {
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"silence.mp3" withExtension:nil];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [player prepareToPlay];
    // 无限播放
    player.numberOfLoops = -1;
    
    [player play];
    
    _player = player;
    
}

// 程序进入后台的时候调用
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // 开启一个后台任务，时间不确定，优先级比较低，例如系统要关闭应用，首先就考虑
    UIBackgroundTaskIdentifier ID = [application beginBackgroundTaskWithExpirationHandler:^{
       
        // 当后台任务结束的时候调用
        [application endBackgroundTask:ID];
    }];
    
    // 如何提高后台任务的优先级，欺骗苹果，我们是后台播放程序
    
    // 但是苹果会检测你的程序，当时有没有播放音乐，如果没有，就干掉你
    
    // 微博：在程序即将失去焦点的时候播放 静音 音乐
    
    
    
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
