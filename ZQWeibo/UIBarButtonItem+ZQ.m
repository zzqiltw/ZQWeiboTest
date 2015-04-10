//
//  UIBarButtonItem+ZQ.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-11.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "UIBarButtonItem+ZQ.h"

@implementation UIBarButtonItem (ZQ)

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlightedIcon target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:highlightedIcon] forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, button.currentBackgroundImage.size.width, button.currentBackgroundImage.size.height);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}

@end
