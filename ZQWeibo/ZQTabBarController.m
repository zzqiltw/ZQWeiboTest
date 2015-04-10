//
//  ZQTabBarController.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-6.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQTabBarController.h"
#import "ZQMessageViewController.h"
#import "ZQHomeViewController.h"
#import "ZQDiscoverViewController.h"
#import "ZQMeViewController.h"
#import "ZQNavigationViewController.h"
#import "ZQSendStatusController.h"

#import "ZQCustomTabBar.h"

#import "UIImage+ZQ.h"

@interface ZQTabBarController () <ZQCustomTabBarDelegate>

@property (nonatomic, weak) ZQCustomTabBar *customTabBar;

@end

@implementation ZQTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTabBar];
    [self setupChildViewControllers];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //移走原先的tabbar里的button
    for (UIView *childView in self.tabBar.subviews) {
        if ([childView isKindOfClass:[UIControl class]]) {
            [childView removeFromSuperview];
        }
    }
}

- (void)setupTabBar
{
    ZQCustomTabBar *customTabBar = [[ZQCustomTabBar alloc] init];
    //注意是bounds
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}

- (void)setupChildViewControllers
{
    ZQHomeViewController *homeVC = [[ZQHomeViewController alloc] init];
    homeVC.tabBarItem.badgeValue = @"new";
    [self setupChildViewControllerWithController:homeVC title:@"首页" normalImageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    
    ZQMessageViewController *messageVC = [[ZQMessageViewController alloc] init];
    messageVC.tabBarItem.badgeValue = @"9";
    [self setupChildViewControllerWithController:messageVC title:@"消息" normalImageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    
    ZQDiscoverViewController *discoverVC = [[ZQDiscoverViewController alloc] init];
    discoverVC.tabBarItem.badgeValue = @"100";
    [self setupChildViewControllerWithController:discoverVC title:@"广场" normalImageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    ZQMeViewController *meVC = [[ZQMeViewController alloc] init];
    [self setupChildViewControllerWithController:meVC title:@"我" normalImageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    
}

- (void)setupChildViewControllerWithController:(UIViewController *)childVC title:(NSString *)title normalImageName:(NSString *)norImgName selectedImageName:(NSString *)selImgName
{
    childVC.title = title;
    childVC.tabBarItem.image = [UIImage imageWithName:norImgName];
    childVC.tabBarItem.selectedImage = [UIImage imageOriginalWithName:selImgName];
    
    ZQNavigationViewController *nav = [[ZQNavigationViewController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
        
    [self.customTabBar addButtonWithTabBarItem:childVC.tabBarItem];
}

- (void)tabBar:(ZQCustomTabBar *)tabBar didClickButtonFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
}

- (void)tabBarDidClickPlusButton:(ZQCustomTabBar *)tabBar
{
    ZQNavigationViewController *nav = [[ZQNavigationViewController alloc] initWithRootViewController:[[ZQSendStatusController alloc] init]];
    [self presentViewController:nav animated:YES completion:nil];
}
 
@end
