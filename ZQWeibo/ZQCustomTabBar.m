//
//  ZQCustomTabBar.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-6.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQCustomTabBar.h"
#import "ZQTabButton.h"

@interface ZQCustomTabBar ()

@property (nonatomic, strong) ZQTabButton *selectedButton;
@property (nonatomic, weak) UIButton *plus;
@property (nonatomic, strong) NSMutableArray *tabBarButtons;

@end

@implementation ZQCustomTabBar

- (NSMutableArray *)tabBarButtons
{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [[NSMutableArray alloc] init];
    }
    
    return _tabBarButtons;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        if (!iOS7) {
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
        }
        
        UIButton *plus = [[UIButton alloc] init];
        [plus setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plus setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateSelected];
        [plus setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plus setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateSelected];
        [plus addTarget:self action:@selector(clickPlus) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:plus];
        self.plus = plus;
    }
    return self;
}

- (void)addButtonWithTabBarItem:(UITabBarItem *)item
{
    ZQTabButton *button = [ZQTabButton buttonWithType:UIButtonTypeCustom];
    button.item = item;
    [self addSubview:button];
    [self.tabBarButtons addObject:button];
    
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchDown];
    if (self.tabBarButtons.count == 1) {
        [self clickButton:button];
    }
    button.tag = self.tabBarButtons.count - 1;
}

- (void)clickButton:(ZQTabButton *)button
{
    if ([self.delegate respondsToSelector:@selector(tabBar:didClickButtonFrom:to:)]) {
        [self.delegate tabBar:self didClickButtonFrom:self.selectedButton.tag to:button.tag];
    }
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

- (void)clickPlus
{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.plus.bounds = CGRectMake(0, 0, self.plus.currentBackgroundImage.size.width, self.plus.currentBackgroundImage.size.height);
    self.plus.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonY = 0;
    
    for (int i = 0; i < self.tabBarButtons.count; ++i) {
        CGFloat buttonX = i * buttonW;
        
        if (i > 1) {
            buttonX += buttonW;
        }
        UIButton *button = self.tabBarButtons[i];
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}

@end
