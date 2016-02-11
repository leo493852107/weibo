//
//  TTStatus.h
//  weibo
//
//  Created by leo on 16/2/9.
//  Copyright © 2016年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TTUser.h"
#import "MJExtension.h"

@interface TTStatus : NSObject <MJKeyValue>

/**
 *  转发的微博
 */
@property (nonatomic, strong) TTStatus *retweeted_status;

/**
 *  用户
 */
@property (nonatomic, strong) TTUser *user;

/**
 *  微博创建时间
 */
@property (nonatomic, copy) NSString *created_at;

/**
 *  字符串型的微博ID
 */
@property (nonatomic, copy) NSString *idstr;

/**
 *  微博信息内容
 */
@property (nonatomic, copy) NSString *text;

/**
 *  微博作者的用户信息字段
 */
@property (nonatomic, copy) NSString *source;

/**
 *  转发数
 */
@property (nonatomic, assign) int reposts_count;

/**
 *  评论数
 */
@property (nonatomic, assign) int comments_count;

/**
 *  表态数
 */
@property (nonatomic, assign) int attitudes_count;

/**
 *  配图数组(TTPhoto)
 */
@property (nonatomic, strong) NSArray *pic_urls;

@end
