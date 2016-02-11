//
//  TTUserResult.m
//  weibo
//
//  Created by leo on 16/2/11.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTUserResult.h"

@implementation TTUserResult

- (int)messageCount {
    return _cmt + _dm + _mention_cmt + _mention_status;
}

- (int)totalCount {
    return self.messageCount + _status + _follower;
}

@end
