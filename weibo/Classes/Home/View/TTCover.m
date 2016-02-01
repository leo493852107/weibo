//
//  TTCover.m
//  weibo
//
//  Created by leo on 16/2/1.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTCover.h"

@implementation TTCover

// 设置浅灰色蒙板
- (void)setDimBackground:(BOOL)dimBackground {
    _dimBackground = dimBackground;
    
    if (dimBackground) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;
    } else {
        self.alpha = 1;
        self.backgroundColor = [UIColor clearColor];
    }
}

// 显示蒙板
+ (instancetype)show {
    TTCover *cover = [[TTCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
    cover.backgroundColor = [UIColor clearColor];
    
    [TTKeyWindow addSubview:cover];
    
    return cover;
}

// 点击蒙板的时候做事情
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 移除蒙板
    [self removeFromSuperview];
    
    // 通知代理移除菜单
    if ([_delegate respondsToSelector:@selector(coverDidClickCover:)]) {
        
        [_delegate coverDidClickCover:self];
        
    }
}

@end
