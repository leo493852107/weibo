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

@interface TTRetweetView ()

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) UILabel *textLabel;

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
    nameLabel.font = TTNameFont;
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    
    // 正文
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.font = TTTextFont;
    textLabel.numberOfLines = 0;
    [self addSubview:textLabel];
    _textLabel = textLabel;
    
    
}


- (void)setStatusFrame:(TTStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    
    TTStatus *status = statusFrame.status;
    
    // 昵称
    _nameLabel.frame = statusFrame.retweetNameFrame;
    _nameLabel.text = status.retweeted_status.user.name;
    
    // 正文
    _textLabel.frame = statusFrame.retweetTextFrame;
    _textLabel.text = status.retweeted_status.text;
    
}

@end
