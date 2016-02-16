//
//  TTTabBar.m
//  weibo
//
//  Created by leo on 16/1/31.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTTabBar.h"
#import "TTTabBarButton.h"

@interface TTTabBar()

@property (nonatomic, weak) UIButton *plusButton;

@property (nonatomic, strong) NSMutableArray *buttons;

@property (nonatomic, weak) UIButton *selectedButton;

@end

@implementation TTTabBar

- (NSMutableArray *)buttons {
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)setItems:(NSArray *)items {
    _items = items;
    
    // 遍历模型数组，创建对应tabBarButton
    for (UITabBarItem *item in _items) {
        TTTabBarButton *btn = [TTTabBarButton buttonWithType:UIButtonTypeCustom];
        
        // 给按钮赋值模型，按钮的内容由模型对应决定
        btn.item = item;
        btn.tag = self.buttons.count;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        // 选中第0个
        if (btn.tag == 0) {
            [self btnClick:btn];
        }
        
        [self addSubview:btn];
        
        // 把按钮添加到按钮数组
        [self.buttons addObject:btn];
    }
}

// 点击tabBarButton调用
- (void)btnClick:(UIButton *)button {
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    
    // 新内容
     // 通知tabBarVc切换控制器，
    if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [_delegate tabBar:self didClickButton:button.tag];
    }
}

- (UIButton *)plusButton {
    if (_plusButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        // 默认按钮的尺寸和背景图片一样大
        // sizeToFit：默认会根据按钮的背景图片或者image和文字计算按钮的最合适的尺寸
        [btn sizeToFit];
        
        // 监听按钮的点击
        [btn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        
        _plusButton = btn;
        
        [self addSubview:_plusButton];
    }
    
    return _plusButton;
}


// 点击加号的时候调用
- (void)plusClick {
    // modal出控制器
    if ([_delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [_delegate tabBarDidClickPlusButton:self];
    }
}

/**
 *  调整子控件的位置
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = w / (self.items.count + 1);
    CGFloat btnH = h;
    
    int i = 0;
    // 调整系统自带的tabBar上的按钮位置
    for (UIView *tabBarButton in self.buttons) {
        
        if (i == 2) {
            i = 3;
        }
        btnX = i * btnW;
        tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        i++;

    }
    
    // 设置添加按钮的位置
    self.plusButton.center = CGPointMake(w * 0.5, h * 0.5);
}

@end
