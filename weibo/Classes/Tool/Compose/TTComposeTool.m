//
//  TTComposeTool.m
//  weibo
//
//  Created by leo on 16/2/18.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTComposeTool.h"
#import "TTHttpTool.h"
#import "TTComposeParam.h"
#import "MJExtension.h"

#import "TTUploadParam.h"
#import <AFNetworking.h>

@implementation TTComposeTool

+ (void)composeWithStatus:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    TTComposeParam *param = [TTComposeParam param];
    param.status = status;
    
    [TTHttpTool POST:@"https://api.weibo.com/2/statuses/update.json" parameters:param.keyValues success:^(id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)composeWithStatus:(NSString *)status image:(UIImage *)image success:(void (^)())success failure:(void (^)(NSError *))failure {
    // 创建参数模型
    TTComposeParam *param = [TTComposeParam param];
    param.status = status;
    
    // 创建上传的模型
    TTUploadParam *uploadP = [[TTUploadParam alloc] init];
    uploadP.data = UIImagePNGRepresentation(image);
    uploadP.name = @"pic";
    uploadP.fileName = @"image.png";
    uploadP.mimeType = @"image/png";
    
    // 注意：以后如果一个方法要传很多参数，就把参数包装成一个模型
    [TTHttpTool Upload:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:param.keyValues uploadParam:uploadP success:^(id responseObject) {
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
