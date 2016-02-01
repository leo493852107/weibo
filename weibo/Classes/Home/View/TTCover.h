//
//  TTCover.h
//  weibo
//
//  Created by leo on 16/2/1.
//  Copyright © 2016年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
// 代理什么时候用，一般自定义控件的时候都用代理
// 为什么？因为一个控件以后可能要扩充新的功能，为了程序的扩展性，一般用代理

@class TTCover;
@protocol TTCoverDelegate <NSObject>

@optional
// 点击蒙板的时候调用
- (void)coverDidClickCover:(TTCover *)cover;

@end

@interface TTCover : UIView

/**
 *  显示蒙板
 *
 *  @return <#return value description#>
 */
+ (instancetype)show;

// 设置浅灰色蒙板
@property (nonatomic, assign) BOOL dimBackground;

@property (nonatomic, weak) id<TTCoverDelegate> delegate;

@end
