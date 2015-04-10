//
//  ZQMessageViewController.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-6.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQMessageViewController.h"

@interface ZQMessageViewController ()

@end

@implementation ZQMessageViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"写私信" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 30, 200, 40)];
    UIImage *image = [UIImage imageWithName:@"RedButton"];
    [button setBackgroundImage:[image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5] forState:UIControlStateNormal];
    [self.view addSubview:button];
}

@end
