//
//  TTDiscoverViewController.m
//  weibo
//
//  Created by leo on 16/1/31.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTDiscoverViewController.h"
#import "TTSearchBar.h"

@implementation TTDiscoverViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    // 创建搜索框
    TTSearchBar *searchBar = [[TTSearchBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 35)];
    searchBar.placeholder = @"大家都在搜";
    
    // 设置titleView为搜索框
    self.navigationItem.titleView = searchBar;
}


@end
