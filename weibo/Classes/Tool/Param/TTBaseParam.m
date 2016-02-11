//
//  TTBaseParam.m
//  weibo
//
//  Created by leo on 16/2/11.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTBaseParam.h"

#import "TTAccountTool.h"
#import "TTAccount.h"

@implementation TTBaseParam

+ (instancetype)param {
    TTBaseParam *param = [[self alloc] init];
    
    param.access_token = [TTAccountTool account].access_token;
    
    return param;
}

@end
