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
            TTLog(@"%ld--%ld--%ld", (long)cmp.hour, (long)cmp.minute, (long)cmp.second);
            
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
    
    TTLog(@"%@", _created_at);
    
    return _created_at;
}

@end
