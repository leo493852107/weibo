//
//  TTComposeToolBar.h
//  weibo
//
//  Created by leo on 16/2/18.
//  Copyright © 2016年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTComposeToolBar;
@protocol TTComposeToolBarDelegate <NSObject>

@optional
- (void)composeToolBar:(TTComposeToolBar *)toolBar didClickBtn:(NSInteger)indexPath;

@end

@interface TTComposeToolBar : UIView

@property (nonatomic, weak) id<TTComposeToolBarDelegate> delegate;

@end
