//
//  TTStatusCell.h
//  weibo
//
//  Created by leo on 16/2/12.
//  Copyright © 2016年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTStatusFrame;
@interface TTStatusCell : UITableViewCell

@property (nonatomic, strong) TTStatusFrame *statusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
