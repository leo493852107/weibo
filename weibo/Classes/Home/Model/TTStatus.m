//
//  TTStatus.m
//  weibo
//
//  Created by leo on 16/2/9.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTStatus.h"

#import "TTPhoto.h"
#import "NSDate+MJ.h"

@implementation TTStatus

/**
 *  实现这个方法，就会自动把数组中的字典转换成对应的模型
 *
 *  @return <#return value description#>
 */
+ (NSDictionary *)objectClassInArray {
    return @{@"pic_urls" : [TTPhoto class]};
}

- (NSString *)created_at {
    // Sun Feb 14 14:27:35 +0800 2016
    // 字符串转换NSDate
    
    // 日期格式字符串
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    NSDate *created_at = [fmt dateFromString:_created_at];
    
    if ([created_at isThisYear]) {
        // 是今年
        
        if ([created_at isToday]) {
            // 今天
            // 计算跟当前时间差距
            NSDateComponents *cmp = [created_at deltaWithNow];

            if (cmp.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时之前", cmp.hour];
            } else if (cmp.minute > 1) {
                return [NSString stringWithFormat:@"%ld分钟之前", cmp.minute];
            } else {
                return [NSString stringWithFormat:@"刚刚"];
            }
            
        } else if ([created_at isYesterday]) {
            // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:created_at];
        } else {
            // 前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:created_at];
        }
        
    } else {
        // 不是今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        
        return [fmt stringFromDate:created_at];
        
    }
    
    return _created_at;
}

- (void)setSource:(NSString *)source {
//    <a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>
    NSRange range = [source rangeOfString:@">"];
    source = [source substringFromIndex:range.location + range.length];
    range = [source rangeOfString:@"<"];
    source = [source substringToIndex:range.location];
    source = [NSString stringWithFormat:@"来自%@", source];
    _source = source;


}

- (void)setRetweeted_status:(TTStatus *)retweeted_status {
    _retweeted_status = retweeted_status;
    
    _retweetName = [NSString stringWithFormat:@"@%@", retweeted_status.user.name];
}

@end
