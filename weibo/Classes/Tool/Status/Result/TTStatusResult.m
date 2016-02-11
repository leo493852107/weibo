//
//  TTStatusResult.m
//  weibo
//
//  Created by leo on 16/2/11.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTStatusResult.h"

#import "TTStatus.h"

@implementation TTStatusResult

+ (NSDictionary *)objectClassInArray {
    return @{@"statuses" : [TTStatus class]};
}

@end
