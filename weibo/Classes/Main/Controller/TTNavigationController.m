//
//  TTNavigationController.m
//  weibo
//
//  Created by leo on 16/2/1.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTNavigationController.h"
#import "UIBarButtonItem+Item.h"

@interface TTNavigationController () <UINavigationControllerDelegate>

@property (nonatomic, strong) id popDelegate;

@end

@implementation TTNavigationController

+ (void)initialize {
    // 获取当前类下面的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    
    // 设置导航条按钮的文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    
    self.delegate = self;
    
}

// 导航控制器即将显示新的控制器的时候调用
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    // 获取主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    // 获取tabBarVC
    UITabBarController *tabBarVC = (UITabBarController *)keyWindow.rootViewController;
    
    // 移除系统的tabBarButton
    for (UIView *tabBarButton in tabBarVC.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
    }
    
}

// 导航控制器跳转完成的时候调用
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    TTLog(@"%@", self.viewControllers[0]);
    
    if (viewController == self.viewControllers[0]) {
        // 还原滑动手势的代理
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
        
    } else {
        // 不是显示根控制器
        // 实现滑动返回的功能
        // 清空滑动返回手势的代理，就能实现滑动返回
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    

    // 设置非根控制器导航条的内容
    if (self.viewControllers.count != 0) {
        // 非根控制器
        // 设置导航条左边和右边
        // 如果把导航控制器上的返回按钮覆盖，滑动返回的功能就没有了
        // 左边
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWidthImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(backToPre) forControlEvents:UIControlEventTouchUpInside];
        // 右边
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWidthImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(backToRoot) forControlEvents:UIControlEventTouchUpInside];
        
    }
    TTLog(@"%s", __func__);
    
    [super pushViewController:viewController animated:animated];
}

- (void)backToPre {
    [self popViewControllerAnimated:YES];
}

- (void)backToRoot {
    [self popToRootViewControllerAnimated:YES];
}


@end
