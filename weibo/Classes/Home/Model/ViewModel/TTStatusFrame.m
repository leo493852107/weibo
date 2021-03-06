//
//  TTStatusFrame.m
//  weibo
//
//  Created by leo on 16/2/12.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTStatusFrame.h"
#import "TTStatus.h"
#import "TTUser.h"


@implementation TTStatusFrame

- (void)setStatus:(TTStatus *)status {
    _status = status;
    
    // 计算原创微博
    [self setUpOriginalViewFrame];
    
    CGFloat toolBarY = CGRectGetMaxY(_originalViewFrame);
    
    if (status.retweeted_status) {
        
        // 计算转发微博
        [self setUpRetweetViewFrame];

        toolBarY = CGRectGetMaxY(_retweetViewFrame);
    }
    
    // 计算工具条
    CGFloat toolBarX = 0;
    CGFloat toolBarW = TTScreenW;
    CGFloat toolBarH = 35;
    _toolBarFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    // 计算cell高度
    _cellHeight = CGRectGetMaxY(_toolBarFrame);
    
}

#pragma mark - 计算原创微博
- (void)setUpOriginalViewFrame {
    // 头像
    CGFloat imageX = TTStatusCellMargin;
    CGFloat imageY = imageX;
    CGFloat imageWH = 35;
    _originalIconFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    // 昵称
    CGFloat nameX = CGRectGetMaxX(_originalIconFrame) + TTStatusCellMargin;
    CGFloat nameY = imageY;
    CGSize nameSize = [_status.user.name sizeWithFont:TTNameFont];
    _originalNameFrame = (CGRect){{nameX, nameY},nameSize};
    
    // Vip
    if (_status.user.vip) {
        CGFloat vipX = CGRectGetMaxX(_originalNameFrame) + TTStatusCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipWH = 14;
        _originalVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
    }
    
    
    // 正文
    CGFloat textX = imageX;
    CGFloat textY = CGRectGetMaxY(_originalIconFrame) + TTStatusCellMargin;
    CGFloat textW = TTScreenW - 2 * TTStatusCellMargin;
    CGSize textSize = [_status.text sizeWithFont:TTTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _originalTextFrame = (CGRect){{textX, textY}, textSize};
    
    CGFloat originH = CGRectGetMaxY(_originalTextFrame) + TTStatusCellMargin;
    
    // 配图
    if (_status.pic_urls.count) {
        CGFloat photosX = TTStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_originalTextFrame) + TTStatusCellMargin;
        CGSize photosSize = [self photoSizeWithCount:_status.pic_urls.count];
        
        _originalPhotosFrame = (CGRect){{photosX, photosY}, photosSize};
        originH = CGRectGetMaxY(_originalPhotosFrame) + TTStatusCellMargin;
    }
    
    
    // 原创微博的frame
    CGFloat originX = 0;
    CGFloat originY = 10;
    CGFloat originW = TTScreenW;

    _originalViewFrame = CGRectMake(originX, originY, originW, originH);
    
    
    
}

#pragma mark - 计算配图的尺寸
- (CGSize)photoSizeWithCount:(int)count {
    // 获取总列数
    int cols = count == 4 ? 2 : 3;
    // 获取总行数
    int rols = (count - 1) / cols + 1;
    CGFloat photoWH = 70;
    CGFloat w = cols * photoWH + (cols - 1) * TTStatusCellMargin;
    CGFloat h = rols * photoWH + (cols - 1) * TTStatusCellMargin;
    
    return CGSizeMake(w, h);
    
}

#pragma mark - 计算转发微博
- (void)setUpRetweetViewFrame {
    // 昵称
    CGFloat nameX = TTStatusCellMargin;
    CGFloat nameY = nameX;
    // 注意：一定要是转发微博的用户昵称
    CGSize nameSize = [_status.retweetName sizeWithFont:TTNameFont];
    _retweetNameFrame= (CGRect){{nameX, nameY},nameSize};
    
    // 正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(_retweetNameFrame) + TTStatusCellMargin;
    
    CGFloat textW = TTScreenW - 2 * TTStatusCellMargin;
    // 注意：一定要是转发微博的用户正文
    CGSize textSize = [_status.retweeted_status.text sizeWithFont:TTTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _retweetTextFrame = (CGRect){{textX, textY}, textSize};
    
    CGFloat retweetH = CGRectGetMaxY(_retweetTextFrame) + TTStatusCellMargin;
    
    // 配图
    int count = _status.retweeted_status.pic_urls.count;
    if (count) {
        CGFloat photosX = TTStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_retweetTextFrame) + TTStatusCellMargin;
        CGSize photosSize = [self photoSizeWithCount:count];
        
        _retweetPhotosFrame = (CGRect){{photosX, photosY}, photosSize};
        retweetH = CGRectGetMaxY(_retweetPhotosFrame) + TTStatusCellMargin;
    }
    
    // 转发微博的frame
    CGFloat retweetX = 0;
    CGFloat retweetY = CGRectGetMaxY(_originalViewFrame);
    CGFloat retweetW = TTScreenW;
    
    _retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
    
    
    
}



@end
