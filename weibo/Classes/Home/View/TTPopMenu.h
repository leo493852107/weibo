//
//  TTPopMenu.h
//  weibo
//
//  Created by leo on 16/2/1.
//  Copyright © 2016年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTPopMenu : UIImageView

/**
 *  显示弹出菜单
 *
 *  @param rect <#rect description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)showInRect:(CGRect)rect;


/**
 *  隐藏弹出菜单
 */
+ (void)hide;

@property (nonatomic, weak) UIView *contentView;

@end
