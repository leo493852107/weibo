//
//  TTMessageViewController.m
//  weibo
//
//  Created by leo on 16/2/1.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTMessageViewController.h"

@implementation TTMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *chat = [[UIBarButtonItem alloc] initWithTitle:@"发起聊天" style:UIBarButtonItemStylePlain target:self action:@selector(chat)];
    
    self.navigationItem.rightBarButtonItem = chat;
}

- (void)chat {
    TTLog(@"%s", __func__);
}

@end
