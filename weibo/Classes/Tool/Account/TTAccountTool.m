//
//  TTAccountTool.m
//  weibo
//
//  Created by leo on 16/2/9.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTAccountTool.h"
#import "TTAccount.h"
#import "AFNetworking.h"

#import "TTHttpTool.h"
#import "TTAccountParam.h"

#import "MJExtension.h"

#define TTAuthorizeBaseUrl @"https://api.weibo.com/oauth2/authorize"
#define TTClient_id @"3267544893"
#define TTClient_secret @"75cd35a1b0b9f57d4fe9837abd9d0028"
#define TTRedirect_uri @"https://www.baidu.com/"

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

+ (void)accountWithCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    // 创建参数模型
    TTAccountParam *param = [[TTAccountParam alloc] init];
    param.client_id = TTClient_id;
    param.client_secret = TTClient_secret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = TTRedirect_uri;
    
    [TTHttpTool POST:@"https://api.weibo.com/oauth2/access_token" parameters:param.keyValues success:^(id responseObject) {
        // 字典转模型
        TTAccount *account = [TTAccount accountWithDict:responseObject];
        
        // 保存账号信息
        // 数据存储一般我们开发中会搞一个业务类，专门数据的存储
        // 以后我不想归档，用数据库，直接改业务类
        [TTAccountTool saveAccount:account];
        
        // 这一步不能漏
        if (success) {
            success();
        }

    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

@end
