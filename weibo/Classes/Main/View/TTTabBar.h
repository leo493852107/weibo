//
//  TTTabBar.h
//  weibo
//
//  Created by leo on 16/1/31.
//  Copyright © 2016年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTTabBar;

@protocol TTTabBarDelegate <NSObject>

@optional
- (void)tabBar:(TTTabBar *)tabBar didClickButton:(NSInteger)index;

@end

@interface TTTabBar : UIView

// items:保存每一个按钮对应tabBarItem模型
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, weak) id<TTTabBarDelegate> delegate;

@end
