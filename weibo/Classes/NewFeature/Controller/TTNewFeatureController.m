//
//  TTNewFeatureController.m
//  weibo
//
//  Created by leo on 16/2/6.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTNewFeatureController.h"
#import "TTNewFeatureCell.h"

@interface TTNewFeatureController ()

@end

@implementation TTNewFeatureController

static NSString *ID = @"cell";

- (instancetype)init {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置cell尺寸
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    // 清空行距
    layout.minimumLineSpacing = 0;
    // 设置滚动方向为水平
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:layout];
}

//  self.collectionView != self.view
//  注意: self.collectionView 是 self.view 的子控件

// 使用UICollectionViewController
// 1.初始化的时候设置布局参数
// 2.collection必须要注册cell
// 3.自定义cell
- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.view.backgroundColor = [UIColor redColor];
    self.collectionView.backgroundColor = [UIColor grayColor];
    
    // 注册cell，默认就会创建这个类型的cell
    [self.collectionView registerClass:[TTNewFeatureCell class] forCellWithReuseIdentifier:ID];
    
    // 分页
    self.collectionView.pagingEnabled = YES;
    // 没有弹性
    self.collectionView.bounces = NO;
    // 去掉下面那个条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
}


/**
 *  返回有多少组
 *
 *  @param collectionView <#collectionView description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

/**
 *  返回第section组有多少个cell
 *
 *  @param collectionView <#collectionView description#>
 *  @param section        组
 *
 *  @return <#return value description#>
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 4;
}

/**
 *  返回cell长什么样子
 *
 *  @param collectionView <#collectionView description#>
 *  @param indexPath      <#indexPath description#>
 *
 *  @return <#return value description#>
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // dequeueReusableCellWithReuseIdentifier
    // 1.首先从缓存池里取cell
    // 2.看下当前是否有注册cell，如果注册了cell，就会帮你创建cell，
    // 3.没有注册，报错
    TTNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    // 给cell传值
    
    // 拼接图片名称
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld", indexPath.row + 1];
    cell.image = [UIImage imageNamed:imageName];
    
    return cell;
    
}

@end
