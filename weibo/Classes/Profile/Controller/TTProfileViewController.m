//
//  TTProfileViewController.m
//  weibo
//
//  Created by leo on 16/2/1.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTProfileViewController.h"

@implementation TTProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *setting = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
    
    self.navigationItem.rightBarButtonItem = setting;
}

#pragma mark - 点击设置的时候调用
- (void)setting {
    
}

@end
