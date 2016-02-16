//
//  TTComposeViewController.m
//  weibo
//
//  Created by leo on 16/2/16.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTComposeViewController.h"

@interface TTComposeViewController ()

@end

@implementation TTComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpNavigationBar];
    
}

- (void)setUpNavigationBar {
    self.title = @"发微博";

    // left
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:0 target:self action:@selector(dismiss)];
    
    // right
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [btn sizeToFit];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = rightItem;

}

// 发送微博
- (void)compose {
    
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
