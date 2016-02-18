//
//  TTComposePhotosView.m
//  weibo
//
//  Created by leo on 16/2/18.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTComposePhotosView.h"

@implementation TTComposePhotosView

- (void)setImage:(UIImage *)image {
    _image = image;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    
    [self addSubview:imageView];
}

// 每添加一个子控件的时候也会调用
// !特殊：如果在 viewDidLoad 添加子控件就不会调用 layoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger cols = 3;
    CGFloat margin = 4;
    CGFloat wh = (self.width - (cols - 1) * margin) / cols;
    
    CGFloat x = 0;
    CGFloat y = 0;
    NSInteger col = 0;
    NSInteger row = 0;
    
    for (int i = 0; i < self.subviews.count; i++) {
        UIImageView *imageView = self.subviews[i];
        col = i % cols;
        row = i / cols;
        x = col * (margin + wh);
        y = row * (margin + wh);
        imageView.frame = CGRectMake(x, y, wh, wh);
    }
}

@end
