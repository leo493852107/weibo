//
//  TTAccount.h
//  weibo
//
//  Created by leo on 16/2/9.
//  Copyright © 2016年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 "access_token" = "2.00MmQXOEzgRIZD7b43d6e8ccuK1m9C";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 3879329348;
 */
@interface TTAccount : NSObject <NSCoding>

/**
 *  获取数据的访问命令牌
 */
@property (nonatomic, copy) NSString *access_token;

/**
 *  账号有效期
 */
@property (nonatomic, copy) NSString *expires_in;

/**
 *  账号有效期
 */
@property (nonatomic, copy) NSString *remind_in;

/**
 *  用户的唯一标识符
 */
@property (nonatomic, copy) NSString *uid;

/**
 *  过期的时间 = 当前保存时间 + 有效期
 */
@property (nonatomic, strong) NSDate *expires_date;


+ (instancetype)accountWithDict:(NSDictionary *)dict;


@end
