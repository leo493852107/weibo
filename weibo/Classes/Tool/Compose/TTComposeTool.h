//
//  TTComposeTool.h
//  weibo
//
//  Created by leo on 16/2/18.
//  Copyright © 2016年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTComposeTool : NSObject

/**
 *  发送文字
 *
 *  @param status  发送的微博文字内容
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
+ (void)composeWithStatus:(NSString *)status success:(void(^)())success failure:(void(^)(NSError *error))failure;


/**
 *  发送图片
 *
 *  @param status  发送的微博文字内容
 *  @param image   发送的微博图片内容
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
+ (void)composeWithStatus:(NSString *)status image:(UIImage *)image success:(void(^)())success failure:(void(^)(NSError *error))failure;

@end
