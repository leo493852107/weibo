//
//  TTStatusTool.h
//  weibo
//
//  Created by leo on 16/2/11.
//  Copyright © 2016年 leo. All rights reserved.
//  处理微博数据

#import <Foundation/Foundation.h>

@interface TTStatusTool : NSObject


/**
 *  请求更新的微博数据
 *
 *  @param sinceId 返回比这个更大的微博数据
 *  @param success 请求成功的时候的回调(statuses(TTStatus模型))
 *  @param failure 请求失败的时候回调，错误传递给外界
 */
+ (void)newStatusWithSinceId:(NSString *)sinceId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *error))failure;


/**
 *  请求更多的微博数据
 *
 *  @param maxId   返回小于等于这个id的微博数据
 *  @param success 请求成功的时候回调
 *  @param failure 请求失败的时候回调
 */
+ (void)MoreStatusWithMaxId:(NSString *)maxId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *error))failure;

@end
