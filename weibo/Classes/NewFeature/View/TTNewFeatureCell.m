//
//  TTNewFeatureCell.m
//  weibo
//
//  Created by leo on 16/2/6.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTNewFeatureCell.h"

@interface TTNewFeatureCell ()

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation TTNewFeatureCell

- (UIImageView *)imageView {
    if (_imageView == nil) {
        UIImageView *imageV = [[UIImageView alloc] init];
        _imageView = imageV;
        
        // 注意：一定要加到contentView
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

// 布局子控件的frame
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    
    self.imageView.image = image;
}

@end
