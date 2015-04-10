//
//  UIBarButtonItem+ZQ.h
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-11.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZQ)

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlightedIcon target:(id)target action:(SEL)action;

@end
