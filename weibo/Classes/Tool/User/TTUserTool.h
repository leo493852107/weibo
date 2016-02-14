//
//  TTUserTool.h
//  weibo
//
//  Created by leo on 16/2/11.
//  Copyright © 2016年 leo. All rights reserved.
//  处理用户业务

#import <Foundation/Foundation.h>

@class TTUserResult, TTUser;
@interface TTUserTool : NSObject


/**
 *  请求用户的未读数
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调 
 */
+ (void)unreadWithSuccess:(void(^)(TTUserResult *result))success failure:(void(^)(NSError *error))failure;


/**
 *  请求用户的信息
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)userInfoWithSuccess:(void(^)(TTUser *user))success failure:(void(^)(NSError *error))failure;


@end
