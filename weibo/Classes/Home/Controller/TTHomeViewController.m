//
//  TTHomeViewController.m
//  weibo
//
//  Created by leo on 16/2/1.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTHomeViewController.h"

#import "UIBarButtonItem+Item.h"
#import "TTTitleButton.h"

#import "TTPopMenu.h"
#import "TTCover.h"
#import "TTOneViewController.h"

#import "AFNetworking.h"
#import "TTAccountTool.h"
#import "TTAccount.h"

#import "TTStatus.h"
#import "TTUser.h"
#import "TTPhoto.h"

#import "MJExtension.h"
#import "MJRefresh.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "TTStatusTool.h"
#import "TTUserTool.h"
#import "TTAccount.h"
#import "TTAccountTool.h"

#import "TTStatusCell.h"

#import "TTStatusFrame.h"

@interface TTHomeViewController ()<TTCoverDelegate>

@property (nonatomic, weak) TTTitleButton *titleButton;
@property (nonatomic, strong) TTOneViewController *one;


/**
 *  ViewModel:TTStatusFrame
 */
@property (nonatomic, strong) NSMutableArray *statusFrames;

@end

@implementation TTHomeViewController

- (NSMutableArray *)statuses {
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (TTOneViewController *)one {
    if (_one == nil) {
        _one = [[TTOneViewController alloc] init];
    }
    return _one;
}

// UIBarButtonItem:决定导航条上按钮的内容
// UINavigationItem:决定导航条上内容
// UITabBarItem:决定tabBar上按钮的内容
// ios7之后，会把tabBar上和导航条上的按钮渲染
// 导航条上自定义按钮的位置是由系统决定，尺寸才需要自己设置。
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    // 取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 设置导航条内容
    [self setUpNavigationBar];
    
//    // 请求最新的微博数据
//    [self loadNewStatus];
    
    // 添加下拉刷新控件
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus)];
    
    // 自动下拉刷新
    [self.tableView headerBeginRefreshing];
    
    // 添加上拉刷新控件
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];

    // 一开始展示之前的微博名称，然后再发送用户信息的请求，直接赋值
    
    // 请求当前用户的昵称
    [TTUserTool userInfoWithSuccess:^(TTUser *user) {
        // 请求当前账号的用户信息
        // 设置导航条的标题
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        
        // 获取当前的账号
        TTAccount *account = [TTAccountTool account];
        account.name = user.name;

        // 保存用户的名称
        [TTAccountTool saveAccount:account];
        
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - 刷新最新的微博
- (void)refresh {
    
    // 自动下拉刷新
    [self.tableView headerBeginRefreshing];
    
}


#pragma mark - 请求更多数据
- (void)loadMoreStatus {
    
    NSString *maxIdStr = nil;
    if (self.statusFrames.count) {
        // 有微博数据，才需要下拉刷新
        TTStatus *status = [[self.statusFrames lastObject] status];
        long long maxId = [[status idstr] longLongValue] - 1;
        maxIdStr = [NSString stringWithFormat:@"%lld", maxId];
        
    }
    
    [TTStatusTool MoreStatusWithMaxId:maxIdStr success:^(NSArray *statuses) {
        // 结束上拉刷新
        [self.tableView footerEndRefreshing];
        
        // 模型转换视图模型 TTStatus -> TTStatusFrame
        NSMutableArray *statusFrameArr = [NSMutableArray array];
        for (TTStatus *status in statuses) {
            TTStatusFrame *statusFrame = [[TTStatusFrame alloc] init];
            statusFrame.status = status;
            [statusFrameArr addObject:statusFrame];
        }
        
        // 把数组中的元素添加进去，注： 不是 addObject 把数组添加进去
        [self.statuses addObjectsFromArray:statusFrameArr];
        
        // 刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
        
}

#pragma mark - 请求最新的微博数据
- (void)loadNewStatus {
    NSString *sinceId = nil;
    if (self.statusFrames.count) {
        // 有微博数据，才需要下拉刷新
        TTStatus *status = [self.statusFrames[0] status];
        sinceId = status.idstr;
    }
    [TTStatusTool newStatusWithSinceId:sinceId success:^(NSArray *statuses) {
        // 请求成功的block
        
        // 展示最新的微博数
        [self showNewStatusCount:statuses.count];
        
        // 结束下拉刷新
        [self.tableView headerEndRefreshing];
        
        // 模型转换视图模型 TTStatus -> TTStatusFrame
        NSMutableArray *statusesFrameArr = [NSMutableArray array];
        for (TTStatus *status in statuses) {
            TTStatusFrame *statusFrame = [[TTStatusFrame alloc] init];
            statusFrame.status = status;
            [statusesFrameArr addObject:statusFrame];
        }
        
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        // 把最新的微博数插入到最前面
        [self.statuses insertObjects:statusesFrameArr atIndexes:indexSet];
        
        // 刷新表格
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
    
}


#pragma mark - 展示最新的微博数
- (void)showNewStatusCount:(int)count {
    if (count == 0) {
        return;
    }
    
    // 展示最新的微博数
    // 高度设为35
    CGFloat h = 35;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - h;
    CGFloat x = 0;
    CGFloat w = self.view.width;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@"最新微博数%d条", count];
    label.textAlignment = NSTextAlignmentCenter;
    
    // 插入导航控制器下导航条下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    // 动画往下面平移
    [UIView animateWithDuration:0.25 animations:^{
        
        label.transform = CGAffineTransformMakeTranslation(0, h);
        
    } completion:^(BOOL finished) {
        
        // 往上面平移
        [UIView animateKeyframesWithDuration:0.25 delay:2 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            
            // 还原
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
        
    }];
    
}

#pragma mark - 设置导航条
- (void)setUpNavigationBar {
    
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWidthImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendsearch) forControlEvents:UIControlEventTouchUpInside];
    
    // 右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWidthImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    // titleView
    TTTitleButton *titleButton = [TTTitleButton buttonWithType:UIButtonTypeCustom];
    _titleButton = titleButton;
    
    
    NSString *title = [TTAccountTool account].name ? : @"首页";
    [titleButton setTitle:title forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    
    // 高亮的时候不需要调整图片
    titleButton.adjustsImageWhenHighlighted = NO;
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
    
}

// 以后只要显示在最前面的控件，一般都加在主窗口
// 点击标题按钮
-(void)titleClick:(UIButton *)button {
    button.selected = !button.selected;
    
    // 弹出蒙板
    TTCover *cover = [TTCover show];
    cover.delegate = self;
    
    // 弹出pop菜单
    CGFloat popW = 200;
    CGFloat popX = (self.view.width - 200) * 0.5;
    CGFloat popH = popW;
    CGFloat popY = 55;
    TTPopMenu *menu = [TTPopMenu showInRect:CGRectMake(popX, popY, popW, popH)];
    menu.contentView = self.one.view;
}

// 点击蒙板的时候调用
- (void)coverDidClickCover:(TTCover *)cover {
    // 隐藏pop菜单
    [TTPopMenu hide];
    
    _titleButton.selected = NO;
}

- (void)friendsearch {
    
}

- (void)pop {
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 创建cell
    TTStatusCell *cell = [TTStatusCell cellWithTableView:tableView];
    
    // 获取status模型
    TTStatusFrame *statusFrame = self.statuses[indexPath.row];
    
    // 给cell传递模型
    cell.statusFrame = statusFrame;
    
    // 用户昵称
//    cell.textLabel.text = status.user.name;
//    [cell.imageView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
//    cell.detailTextLabel.text = status.text;
    
    return cell;
    
}



// 返回cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 获取status模型
    TTStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    
    return statusFrame.cellHeight;
    
}

@end
