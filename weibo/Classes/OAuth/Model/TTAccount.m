//
//  TTAccount.m
//  weibo
//
//  Created by leo on 16/2/9.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTAccount.h"

#define TTAccountTokenKey @"token"
#define TTUidKey @"uid"
#define TTExpires_inKey @"expires_in"
#define TTExpires_dateKey @"date"
#define TTNameKey @"name"

#import "MJExtension.h"


@implementation TTAccount

// 底层遍历当前类的所有属性，一个一个归档和解档
MJCodingImplementation

+ (instancetype)accountWithDict:(NSDictionary *)dict {
    TTAccount *account = [[self alloc] init];
    
    [account setValuesForKeysWithDictionary:dict];
    
    return account;
}

- (void)setExpires_in:(NSString *)expires_in {
    _expires_in = expires_in;
    
    // 计算过期的时间 = 当前时间 + 有效期
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
}

/**
 *  归档的时候调用，告诉系统哪个属性需要归档，如何归档
 *
 *  @param aCoder <#aCoder description#>
 */
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [aCoder encodeObject:_access_token forKey:TTAccountTokenKey];
//    [aCoder encodeObject:_expires_in forKey:TTExpires_inKey];
//    [aCoder encodeObject:_uid forKey:TTUidKey];
//    [aCoder encodeObject:_expires_date forKey:TTExpires_dateKey];
//    [aCoder encodeObject:_name forKey:TTNameKey];
//}

/**
 *  解档的时候调用，告诉系统哪个属性需要解档，如何解档
 *
 *  @param aDecoder <#aDecoder description#>
 *
 *  @return <#return value description#>
 */
//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    if (self = [super init]) {
//        // 一定要记得赋值
//        _access_token = [aDecoder decodeObjectForKey:TTAccountTokenKey];
//        _expires_in = [aDecoder decodeObjectForKey:TTExpires_inKey];
//        _uid = [aDecoder decodeObjectForKey:TTUidKey];
//        _expires_date = [aDecoder decodeObjectForKey:TTExpires_dateKey];
//        _name = [aDecoder decodeObjectForKey:TTNameKey];
//    }
//    
//    return self;
//}

/**
 *  KVC底层实现：遍历字典里的所有key(uid)
 一个一个获取key，会去模型里查找setKey: setUid:,直接调用这个方法，赋值 setUid:obj
 寻找有没有带下划线_key,_uid ,直接拿到属性赋值
 寻找有没有key的属性，如果有，直接赋值
 在模型里面找不到对应的Key,就会报错.
 */

@end
