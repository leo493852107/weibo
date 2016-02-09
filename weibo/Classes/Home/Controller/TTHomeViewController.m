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


@interface TTHomeViewController ()<TTCoverDelegate>

@property (nonatomic, weak) TTTitleButton *titleButton;
@property (nonatomic, strong) TTOneViewController *one;

@property (nonatomic, strong) NSMutableArray *statuses;

@end

@implementation TTHomeViewController

- (NSMutableArray *)statuses {
    if (_statuses == nil) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
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

    
}

#pragma mark - 请求更多数据
- (void)loadMoreStatus {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 创建一个参数字典
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.statuses.count) {
        // 有微博数据，才需要下拉刷新
        long long max_id = [[[self.statuses lastObject] idstr] longLongValue] - 1;
        params[@"max_id"] = [NSString stringWithFormat:@"%lld", max_id];
        
    }
    params[@"access_token"] = [TTAccountTool account].access_token;
    
    // 发送GET请求
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 结束上拉刷新
        [self.tableView footerEndRefreshing];
        
        // 获取到微博数据
        // 获取字典数组
        NSArray *dictArr = responseObject[@"statuses"];
        // 把字典数组转换成模型数组
        NSArray *statues = [TTStatus objectArrayWithKeyValuesArray:dictArr];
        
        // 把数组中的元素添加进去，注： 不是 addObject 把数组添加进去
        [self.statuses addObjectsFromArray:statues];
        
        // 刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 请求最新的微博数据
- (void)loadNewStatus {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 创建一个参数字典
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.statuses.count) {
        // 有微博数据，才需要下拉刷新
        params[@"since_id"] = [self.statuses[0] idstr];

    }
    params[@"access_token"] = [TTAccountTool account].access_token;
    
    // 发送GET请求
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 结束下拉刷新
        [self.tableView headerEndRefreshing];
        
        // 获取到微博数据
        // 获取字典数组
        NSArray *dictArr = responseObject[@"statuses"];
        // 把字典数组转换成模型数组
        NSArray *statues = [TTStatus objectArrayWithKeyValuesArray:dictArr];
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statues.count)];
        // 把最新的微博数插入到最前面
        [self.statuses insertObjects:statues atIndexes:indexSet];

        // 刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
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
    
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
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
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    // 获取status模型
    TTStatus *status = self.statuses[indexPath.row];
    
    // 用户昵称
    cell.textLabel.text = status.user.name;
    [cell.imageView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    cell.detailTextLabel.text = status.text;
    
    return cell;
    
}

@end
