//
//  TTPhotoView.m
//  weibo
//
//  Created by leo on 16/2/16.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTPhotoView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "TTPhoto.h"

@interface TTPhotoView ()

@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation TTPhotoView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        // 裁剪超出控件的部分
        self.clipsToBounds = YES;
        
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifView];
        _gifView = gifView;

    }
    return self;
}

- (void)setPhoto:(TTPhoto *)photo {
    _photo = photo;
    
    // 赋值
    [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    // 判断下是否显示gif
    NSString *urlStr = photo.thumbnail_pic.absoluteString;
    if ([urlStr hasSuffix:@".gif"]) {
        // 显示gif
        self.gifView.hidden = NO;
    } else {
        // 隐藏gif
        self.gifView.hidden = YES;
    }
}


// .gif
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
    
}

@end
