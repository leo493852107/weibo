//
//  TTStatusFrame.h
//  weibo
//
//  Created by leo on 16/2/12.
//  Copyright © 2016年 leo. All rights reserved.
//  模型 + 对应控件的frame

#import <Foundation/Foundation.h>

@class TTStatus;
@interface TTStatusFrame : NSObject

/**
 *  微博数据
 */
@property (nonatomic, strong) TTStatus *status;


/**
 *  ----------原创微博----------
 */
@property (nonatomic, assign) CGRect originalViewFrame;

/**
 *  **********原创微博子控件frame**********
 */
// 头像Frame
@property (nonatomic, assign) CGRect originalIconFrame;

// 昵称Frame
@property (nonatomic, assign) CGRect originalNameFrame;

// VipFrame
@property (nonatomic, assign) CGRect originalVipFrame;

// 时间Frame
@property (nonatomic, assign) CGRect originalTimeFrame;

// 来源Frame
@property (nonatomic, assign) CGRect originalSourceFrame;

// 正文Frame
@property (nonatomic, assign) CGRect originalTextFrame;

// 配图frame
@property (nonatomic, assign) CGRect originalPhotosFrame;




/**
 *  ----------转发微博frame----------
 */
@property (nonatomic, assign) CGRect retweetViewFrame;

/**
 *  **********转发微博子控件frame**********
 */
// 昵称Frame
@property (nonatomic, assign) CGRect retweetNameFrame;

// 正文Frame
@property (nonatomic, assign) CGRect retweetTextFrame;

// 配图frame
@property (nonatomic, assign) CGRect retweetPhotosFrame;



/**
 *  ----------工具条----------
 */
@property (nonatomic, assign) CGRect toolBarFrame;




/**
 *  ----------cell的高度----------
 */
@property (nonatomic, assign) CGFloat cellHeight;







@end
