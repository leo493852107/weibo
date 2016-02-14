//
//  TTOriginalView.m
//  weibo
//
//  Created by leo on 16/2/12.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTOriginalView.h"
#import "TTStatusFrame.h"
#import "TTStatus.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface TTOriginalView ()

@property (nonatomic, weak) UIImageView *iconView;

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) UIImageView *vipView;

@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, weak) UILabel *sourceLabel;

@property (nonatomic, weak) UILabel *textLabel;

@end

@implementation TTOriginalView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有子控件的方法
        [self setUpAllChildView];
        // 允许交互
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:@"timeline_card_top_background"];
    }
    return self;
}


// 添加所有子控件的方法
- (void)setUpAllChildView {
    
    // 头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    
    // 昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = TTNameFont;
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    // vip
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    _vipView = vipView;
    
    // 时间
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = TTTimeFont;
    timeLabel.textColor = [UIColor orangeColor];
    [self addSubview:timeLabel];
    _timeLabel = timeLabel;
    
    // 来源
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = TTSourceFont;
    [self addSubview:sourceLabel];
    _sourceLabel = sourceLabel;
    
    // 正文
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.font = TTTextFont;
    textLabel.numberOfLines = 0;
    [self addSubview:textLabel];
    _textLabel = textLabel;
    
    
}


- (void)setStatusFrame:(TTStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    
    // 设置frame
    [self setUpFrame];
    
    // 设置data
    [self setUpData];
}


- (void)setUpData {
    TTStatus *status = _statusFrame.status;
    // 头像
    [_iconView sd_setImageWithURL:status.user.profile_image_url  placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    // 昵称
    if (status.user.vip) {
        _nameLabel.textColor = [UIColor redColor];
    } else {
        _nameLabel.textColor = [UIColor blackColor];
    }
    _nameLabel.text = status.user.name;
    
    // vip
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d", status.user.mbrank];
    _vipView.image = [UIImage imageNamed:imageName];
    
    // 时间
    _timeLabel.text = status.created_at;
    
    // 来源
    _sourceLabel.text = status.source;
    
    // 正文
    _textLabel.text = status.text;
    
}

- (void)setUpFrame {
    // 设置头像
    _iconView.frame = _statusFrame.originalIconFrame;
    
    // 昵称
    _nameLabel.frame = _statusFrame.originalNameFrame;
    
    // VIP
    if (_statusFrame.status.user.vip) {
        // 是vip
        _vipView.hidden = NO;
        _vipView.frame = _statusFrame.originalVipFrame;
    } else {
        _vipView.hidden = YES;
    }
    
    // 时间
    _timeLabel.frame = _statusFrame.originalTimeFrame;
    
    // 来源
    _sourceLabel.frame = _statusFrame.originalSourceFrame;
    
    // 正文
    _textLabel.frame = _statusFrame.originalTextFrame;
    
    
}

@end
