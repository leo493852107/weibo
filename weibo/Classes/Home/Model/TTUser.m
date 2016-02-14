//
//  TTUser.m
//  weibo
//
//  Created by leo on 16/2/9.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTUser.h"

@implementation TTUser

- (void)setMbtype:(int)mbtype {
    _mbtype = mbtype;
    _vip = mbtype > 2;
}

@end
