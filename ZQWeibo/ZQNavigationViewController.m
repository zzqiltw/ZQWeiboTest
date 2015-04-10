//
//  ZQNavigationViewController.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-9.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQNavigationViewController.h"

@interface ZQNavigationViewController ()

@end

@implementation ZQNavigationViewController

+ (void)initialize
{
    [self setupNavigationBarTheme];
    [self setupBarButtonItemTheme];
}

+ (void)setupNavigationBarTheme
{
    UINavigationBar *bar = [UINavigationBar appearance];
    
    if (!iOS7) {
        [bar setBackgroundImage:[UIImage imageWithName:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    }
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[UITextAttributeFont] = [UIFont boldSystemFontOfSize:19];
    attrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetMake(0, 0)];
    attrs[UITextAttributeTextColor] = [UIColor blackColor];
    [bar setTitleTextAttributes:attrs];
    

}

+ (void)setupBarButtonItemTheme
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    if (!iOS7) {
        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    }
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[UITextAttributeFont] = [UIFont systemFontOfSize:15];
    attrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetMake(0, 0)];
    attrs[UITextAttributeTextColor] = [UIColor orangeColor];

    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:attrs forState:UIControlStateHighlighted];
    
    NSMutableDictionary *disabledAttrs = [NSMutableDictionary dictionary];
    disabledAttrs[UITextAttributeTextColor] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:disabledAttrs forState:UIControlStateDisabled];
    
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
