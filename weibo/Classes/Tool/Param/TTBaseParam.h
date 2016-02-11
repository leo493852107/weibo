//
//  TTBaseParam.h
//  weibo
//
//  Created by leo on 16/2/11.
//  Copyright © 2016年 leo. All rights reserved.
//  基本的参数模型

#import <Foundation/Foundation.h>

@interface TTBaseParam : NSObject

/**
 *  采用OAuth授权方式为必填参数，OAuth授权后获得。
 */
@property (nonatomic, copy) NSString *access_token;

+ (instancetype)param;

@end
