//
//  TTAccountTool.m
//  weibo
//
//  Created by leo on 16/2/9.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTAccountTool.h"
#import "TTAccount.h"

#define TTAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@implementation TTAccountTool

// 类方法一般用静态变量代替成员属性
static TTAccount *_account;

+ (void)saveAccount:(TTAccount *)account {
    [NSKeyedArchiver archiveRootObject:account toFile:TTAccountFileName];
}

+ (TTAccount *)account {
    if (_account == nil) {
            _account = [NSKeyedUnarchiver unarchiveObjectWithFile:TTAccountFileName];
        
        // 判断下账号是否过期，如果过期直接返回nil
        // NSOrderedAscending 递增
        // 取反
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) {
            // 过期
            return nil;
        }
        
    }
    
    return _account;
}

@end
