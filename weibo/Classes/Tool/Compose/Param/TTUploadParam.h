//
//  TTUploadParam.h
//  weibo
//
//  Created by leo on 16/2/18.
//  Copyright © 2016年 leo. All rights reserved.
//  图片上传的参数模型

#import <Foundation/Foundation.h>

@interface TTUploadParam : NSObject

/**
 *  上传文件的二进制数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  上传的参数名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  上传到服务器的文件名称
 */
@property (nonatomic, copy) NSString *fileName;

/**
 *  上传文件的类型
 */
@property (nonatomic, copy) NSString *mimeType;

@end
