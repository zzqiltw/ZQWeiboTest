//
//  ZQDiscoverViewController.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-6.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQDiscoverViewController.h"
#import "ZQCustomSearchBar.h"

@interface ZQDiscoverViewController ()

@end

@implementation ZQDiscoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ZQCustomSearchBar *searchBar = [ZQCustomSearchBar searchBar];
    searchBar.frame = CGRectMake(0, 0, 300, 30);
    self.navigationItem.titleView = searchBar;
}
@end
