
//
//  TTUserTool.m
//  weibo
//
//  Created by leo on 16/2/11.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTUserTool.h"

#import "TTUserParam.h"
#import "TTUserResult.h"
#import "TTHttpTool.h"

#import "TTAccount.h"
#import "TTAccountTool.h"

#import "MJExtension.h"

#import "TTUser.h"

@implementation TTUserTool

+ (void)unreadWithSuccess:(void (^)(TTUserResult *))success failure:(void (^)(NSError *))failure {
    
    // 创建参数模型
    TTUserParam *param = [TTUserParam param];
    param.uid = [TTAccountTool account].uid;
    
    
    [TTHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.keyValues success:^(id responseObject) {
        
        // 字典转模型
        TTUserResult *result = [TTUserResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)userInfoWithSuccess:(void (^)(TTUser *))success failure:(void (^)(NSError *))failure {
    
    // 创建参数模型
    TTUserParam *param = [TTUserParam param];
    param.uid = [TTAccountTool account].uid;
    
    [TTHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:param.keyValues success:^(id responseObject) {
        
        // 用户字典转模型
        TTUser *user = [TTUser objectWithKeyValues:responseObject];
        if (success) {
            success(user);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
