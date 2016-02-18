//
//  TTPhotosView.h
//  weibo
//
//  Created by leo on 16/2/16.
//  Copyright © 2016年 leo. All rights reserved.
//  相册View包含所有的配图

#import <UIKit/UIKit.h>

@interface TTPhotosView : UIView


/**
 *  TTPhoto,每一个模型对应一个小配图
 */
@property (nonatomic, strong) NSArray *pic_urls;

@end
