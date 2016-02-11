//
//  TTHttpTool.h
//  weibo
//
//  Created by leo on 16/2/10.
//  Copyright © 2016年 leo. All rights reserved.
//  处理网络请求

#import <Foundation/Foundation.h>

@interface TTHttpTool : NSObject


/**
*  GET请求
*  不需要返回值: 1.网络的数据会延迟，并不会马上返回。
*
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
*/
+ (void)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;


/**
 *  发送POST请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)POST:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

@end
