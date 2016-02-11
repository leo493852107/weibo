//
//  TTStatus.m
//  weibo
//
//  Created by leo on 16/2/9.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTStatus.h"

#import "TTPhoto.h"

@implementation TTStatus

/**
 *  实现这个方法，就会自动把数组中的字典转换成对应的模型
 *
 *  @return <#return value description#>
 */
+ (NSDictionary *)objectClassInArray {
    return @{@"pic_urls" : [TTPhoto class]};
}

@end
