//
//  ZQRootVCTool.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-22.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQRootVCTool.h"
#import "ZQOAuthController.h"
#import "ZQNewFetureViewController.h"
#import "ZQTabBarController.h"
@implementation ZQRootVCTool

+ (void)selectRootVC
{
    NSString *key = @"CFBundleVersion";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    NSString *currentVersion = [[NSBundle mainBundle] infoDictionary][key];
    if ([lastVersion isEqualToString:currentVersion]) {
        if ([ZQAccountTool readAccount] == nil) {
            [UIApplication sharedApplication].keyWindow.rootViewController = [[ZQOAuthController alloc] init];
        } else {
            [UIApplication sharedApplication].keyWindow.rootViewController = [[ZQTabBarController alloc] init];
        }
    } else {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[ZQNewFetureViewController alloc] init];
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }
    
    
}

@end
