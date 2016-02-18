//
//  TTRetweetView.m
//  weibo
//
//  Created by leo on 16/2/12.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTRetweetView.h"

#import "TTStatus.h"
#import "TTStatusFrame.h"
#import "TTPhotosView.h"

@interface TTRetweetView ()

/**
 *  昵称
 */
@property (nonatomic, weak) UILabel *nameLabel;

/**
 *  正文
 */
@property (nonatomic, weak) UILabel *textLabel;

/**
 *  配图
 */
@property (nonatomic, weak) TTPhotosView *photosView;

@end

@implementation TTRetweetView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有子控件的方法
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:@"timeline_retweet_background"];
    }
    return self;
}


// 添加所有子控件的方法
- (void)setUpAllChildView {
    
    
    // 昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = [UIColor blueColor];
    nameLabel.font = TTNameFont;
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    
    // 正文
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.font = TTTextFont;
    textLabel.numberOfLines = 0;
    [self addSubview:textLabel];
    _textLabel = textLabel;
    
    // 配图
    TTPhotosView *photosView = [[TTPhotosView alloc] init];
    [self addSubview:photosView];
    _photosView = photosView;
    
}


- (void)setStatusFrame:(TTStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    
    TTStatus *status = statusFrame.status;
    
    // 昵称
    _nameLabel.frame = statusFrame.retweetNameFrame;
    _nameLabel.text = status.retweetName;
    
    // 正文
    _textLabel.frame = statusFrame.retweetTextFrame;
    _textLabel.text = status.retweeted_status.text;
    
    // 配图
    _photosView.frame = statusFrame.retweetPhotosFrame;
    
    // 注意：这里一定要转让转发微博的配图数
    _photosView.pic_urls = status.retweeted_status.pic_urls;
    
}

@end
