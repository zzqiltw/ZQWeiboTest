//
//  ZQCustomTabBar.h
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-6.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZQCustomTabBarDelegate;

@interface ZQCustomTabBar : UIView

@property (nonatomic, weak) id<ZQCustomTabBarDelegate> delegate;
- (void)addButtonWithTabBarItem:(UITabBarItem *)item;
@end

@protocol ZQCustomTabBarDelegate <NSObject>

@optional
- (void)tabBar:(ZQCustomTabBar *)tabBar didClickButtonFrom:(int)from to:(int)to;
- (void)tabBarDidClickPlusButton:(ZQCustomTabBar *)tabBar;
@end
