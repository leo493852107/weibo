//
//  TTStatusResult.h
//  weibo
//
//  Created by leo on 16/2/11.
//  Copyright © 2016年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface TTStatusResult : NSObject <MJKeyValue>

/**
 *  用户的微博数组（TTStatus）
 */
@property (nonatomic, strong) NSArray *statuses;

/**
 *  用户最近微博总数
 */
@property (nonatomic, assign) int total_number;

@end
