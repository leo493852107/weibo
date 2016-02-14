//
//  TTStatusCell.m
//  weibo
//
//  Created by leo on 16/2/12.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTStatusCell.h"

#import "TTOriginalView.h"
#import "TTRetweetView.h"
#import "TTStatusToolBar.h"

#import "TTStatusFrame.h"

@interface TTStatusCell ()

@property (nonatomic, weak) TTOriginalView *originalView;
@property (nonatomic, weak) TTRetweetView *retweetView;
@property (nonatomic, weak) TTStatusToolBar *toolBar;

@end

@implementation TTStatusCell

/**
 *  注意：cell是用 initWithStyle 初始化
 *
 *  @param style           style description
 *  @param reuseIdentifier reuseIdentifier description
 *
 *  @return return value description
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        // 添加所有子控件的方法
        [self setUpAllChildView];
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}


// 添加所有子控件的方法
- (void)setUpAllChildView {
    // 原创微博
    TTOriginalView *originalView = [[TTOriginalView alloc] init];
    
    [self addSubview:originalView];
    _originalView = originalView;
    
    // 转发微博
    TTRetweetView *retweetView = [[TTRetweetView alloc] init];
    [self addSubview:retweetView];
    _retweetView = retweetView;
    
    // 工具条
    TTStatusToolBar *toolBar = [[TTStatusToolBar alloc] init];
    [self addSubview:toolBar];
    _toolBar = toolBar;
    
}


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }

    return cell;
}

/*
 
    问题：1,cell的高度应该提前计算出来
        2.cell的高度必须要先计算出每个子控件的frame，才能确定
        3.如果在cell的 setStatus 方法计算子控件的位置，会比较耗性能
 
    解决:MVVM思想
    M:模型
    V:视图
    VM: 视图模型（模型包装视图模型，模型 + 模型对应视图的frame）
 
 */

- (void)setStatusFrame:(TTStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    
    // 设置原创微博的frame
    _originalView.frame = statusFrame.originalViewFrame;
    _originalView.statusFrame = statusFrame;
    
    // 设置转发微博的frame
    _retweetView.frame = statusFrame.retweetViewFrame;
    _retweetView.statusFrame = statusFrame;
    
    // 设置工具条的frame
    _toolBar.frame = statusFrame.toolBarFrame;
    
}



@end
