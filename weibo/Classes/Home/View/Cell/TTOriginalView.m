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
#import "TTPhotosView.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface TTOriginalView ()

/**
 *  头像
 */
@property (nonatomic, weak) UIImageView *iconView;

/**
 *  昵称
 */
@property (nonatomic, weak) UILabel *nameLabel;

/**
 *  vip
 */
@property (nonatomic, weak) UIImageView *vipView;

/**
 *  时间
 */
@property (nonatomic, weak) UILabel *timeLabel;

/**
 *  来源
 */
@property (nonatomic, weak) UILabel *sourceLabel;

/**
 *  正文
 */
@property (nonatomic, weak) UILabel *textLabel;

/**
 *  配图
 */
@property (nonatomic, weak) TTPhotosView *photosView;

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
    sourceLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:sourceLabel];
    _sourceLabel = sourceLabel;
    
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
    
    // 配图
    _photosView.pic_urls = status.pic_urls;
    
    
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
    
    // 时间 每次有新的时间的时间都需要计算时间的frame
    TTStatus *status = _statusFrame.status;
    CGFloat timeX = _nameLabel.frame.origin.x;
    CGFloat timeY = CGRectGetMaxY(_nameLabel.frame) + TTStatusCellMargin * 0.5;
    CGSize timeSize = [status.created_at sizeWithFont:TTTimeFont];
    _timeLabel.frame = (CGRect){{timeX, timeY},timeSize};
    
    
    // 来源
    CGFloat sourceX = CGRectGetMaxX(_timeLabel.frame) + TTStatusCellMargin;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:TTSourceFont];
    _sourceLabel.frame = (CGRect){{sourceX,sourceY}, sourceSize};
    
    // 正文
    _textLabel.frame = _statusFrame.originalTextFrame;
    
    // 配图
    _photosView.frame = _statusFrame.originalPhotosFrame;
    
    
}

@end
