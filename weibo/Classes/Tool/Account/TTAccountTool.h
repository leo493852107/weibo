//
//  TTAccountTool.h
//  weibo
//
//  Created by leo on 16/2/9.
//  Copyright © 2016年 leo. All rights reserved.
//  专门处理账号的业务（账号的存储和读取）

#import <Foundation/Foundation.h>

@class TTAccount;
@interface TTAccountTool : NSObject

+ (void)saveAccount:(TTAccount *)account;

+ (TTAccount *)account;

@end
