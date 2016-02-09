//
//  TTBadgeView.m
//  weibo
//
//  Created by leo on 16/2/1.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTBadgeView.h"

#define TTBadgeViewFont [UIFont systemFontOfSize:11]

@implementation TTBadgeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = NO;
        
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        
        // 设置字体大小
        self.titleLabel.font = TTBadgeViewFont;
        
        [self sizeToFit];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue {
    _badgeValue = badgeValue;
    
    // 判断badgeValue是否有内容
    if (badgeValue.length == 0 || [badgeValue isEqualToString:@"0"]) {
        // 没有内容或者空字符串,等于0
        self.hidden = YES;
    } else {
        self.hidden = NO;
    }
    
    CGSize size = [badgeValue sizeWithFont:TTBadgeViewFont];
    
    if (size.width > self.width) {
        [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    } else {
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        [self setTitle:badgeValue forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    }
}

@end
