//
//  TTStatusToolBar.m
//  weibo
//
//  Created by leo on 16/2/12.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTStatusToolBar.h"

@implementation TTStatusToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有子控件的方法
        [self setUpAllChildView];
        
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}


// 添加所有子控件的方法
- (void)setUpAllChildView {
    
}

@end
