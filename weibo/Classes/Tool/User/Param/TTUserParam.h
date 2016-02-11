//
//  TTUserParam.h
//  weibo
//
//  Created by leo on 16/2/11.
//  Copyright © 2016年 leo. All rights reserved.
//  用户未读数请求的参数模型


#import <Foundation/Foundation.h>
#import "TTBaseParam.h"

@interface TTUserParam : TTBaseParam

/**
 *  当前用户的唯一标识符
 */
@property (nonatomic, copy) NSString *uid;



@end
