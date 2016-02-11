//
//  TTStatusTool.m
//  weibo
//
//  Created by leo on 16/2/11.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTStatusTool.h"

#import "TTHttpTool.h"
#import "TTStatus.h"
#import "TTAccountTool.h"
#import "TTAccount.h"

#import "TTStatusParam.h"
#import "TTStatusResult.h"

#import "MJExtension.h"

@implementation TTStatusTool

+ (void)newStatusWithSinceId:(NSString *)sinceId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    
    // 创建参数模型
    TTStatusParam *param = [[TTStatusParam alloc] init];
    param.access_token= [TTAccountTool account].access_token;
    
    if (sinceId) {
        param.since_id = sinceId;
    }

    [TTHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) {
       
        TTStatusResult *result = [TTStatusResult objectWithKeyValues:responseObject];
        
        // 获取到微博数据
        // 获取字典数组
//        NSArray *dictArr = responseObject[@"statuses"];
//        // 把字典数组转换成模型数组
//        NSArray *statuses = [TTStatus objectArrayWithKeyValuesArray:dictArr];
        
        if (success) {
            success(result.statuses);
        }
       
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


+ (void)MoreStatusWithMaxId:(NSString *)maxId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    
    // 创建参数模型
    TTStatusParam *param = [[TTStatusParam alloc] init];
    param.access_token = [TTAccountTool account].access_token;
    if (maxId) {
        param.max_id = maxId;
    }
    
    [TTHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) {
        
        // 把结果字典转换结果模型
        TTStatusResult *result = [TTStatusResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result.statuses);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

@end
