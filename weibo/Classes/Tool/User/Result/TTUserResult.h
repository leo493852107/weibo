//
//  TTUserResult.h
//  weibo
//
//  Created by leo on 16/2/11.
//  Copyright © 2016年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTUserResult : NSObject

/**
 *  新微博未读数
 */
@property (nonatomic, assign) int status;

/**
 *  新粉丝数
 */
@property (nonatomic, assign) int follower;

/**
 *  新评论数
 */
@property (nonatomic, assign) int cmt;

/**
 *  新私信数
 */
@property (nonatomic, assign) int dm;

/**
 *  新提及我的微博数
 */
@property (nonatomic, assign) int mention_status;

/**
 *  新提及我的评论数
 */
@property (nonatomic, assign) int mention_cmt;


/**
 *  消息的总和
 *
 */
- (int)messageCount;


/**
 *  未读数总和
 *
 */
- (int)totalCount;

@end
