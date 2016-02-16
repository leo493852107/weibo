//
//  TTStatusToolBar.m
//  weibo
//
//  Created by leo on 16/2/12.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTStatusToolBar.h"
#import "TTStatus.h"

@interface TTStatusToolBar ()

@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *divideViews;

@property (nonatomic, weak) UIButton *retweet;
@property (nonatomic, weak) UIButton *comment;
@property (nonatomic, weak) UIButton *unlike;

@end

@implementation TTStatusToolBar

- (NSMutableArray *)btns {
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)divideViews {
    if (_divideViews == nil) {
        _divideViews = [NSMutableArray array];
    }
    return _divideViews;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有子控件的方法
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:@"timeline_card_bottom_background"];
        
    }
    return self;
}


// 添加所有子控件的方法
- (void)setUpAllChildView {
    
    // 转发
    UIButton *retweet = [self setUpOneButtonWithTitle:@"转发" image:[UIImage imageNamed:@"timeline_icon_retweet"]];
    _retweet = retweet;
    
    // 评论
    UIButton *comment = [self setUpOneButtonWithTitle:@"评论" image:[UIImage imageNamed:@"timeline_icon_comment"]];
    _comment = comment;
    
    // 赞
    UIButton *unlike = [self setUpOneButtonWithTitle:@"赞" image:[UIImage imageNamed:@"timeline_icon_unlike"]];
    _unlike = unlike;
    
    for (int i = 0; i < self.btns.count - 1; i++) {
        UIImageView *divideV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        [self addSubview:divideV];
        [self.divideViews addObject:divideV];
    }
    
}

- (UIButton *)setUpOneButtonWithTitle:(NSString *)title image:(UIImage *)image {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置按钮的frame
    NSUInteger count = self.btns.count;
    CGFloat w = TTScreenW / count;
    CGFloat h = self.height;
    CGFloat x = 0;
    CGFloat y = 0;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.btns[i];
        x = i * w;
        btn.frame = CGRectMake(x, y, w, h);
    }
    
    int i = 1;
    for (UIImageView *divide in self.divideViews) {
        UIButton *btn = self.btns[i];
        divide.x = btn.x;
        i++;
    }
    
}

- (void)setStatus:(TTStatus *)status {
    _status = status;
  
    // 设置转发的标题
    [self setBtn:_retweet Title:status.reposts_count];
    
    // 设置评论的标题
    [self setBtn:_comment Title:status.comments_count];
    
    // 设置赞
    [self setBtn:_unlike Title:status.attitudes_count];
    
}

// 设置按钮标题
- (void)setBtn:(UIButton *)btn Title:(int)count {
    
    //    status.reposts_count = 12000;
    // > 10000  1.2w
    NSString *title = nil;
    if (count) {
        if (count > 10000) {
            CGFloat floatCount = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1fW", floatCount];
            // 替换 .0
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        } else {
            // < 10000
            title = [NSString stringWithFormat:@"%d", count];
        }
        
        // 设置转发数
        [_retweet setTitle:title forState:UIControlStateNormal];
    }
}

@end
