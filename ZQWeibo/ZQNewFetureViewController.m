//
//  ZQNewFetureViewController.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-13.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQNewFetureViewController.h"
#import "ZQCheckBoxButton.h"
#import "ZQTabBarController.h"
#import "ZQOAuthController.h"
#define ZQNewFetureCount 3

@interface ZQNewFetureViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation ZQNewFetureViewController

- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    CGFloat singleW = scrollView.frame.size.width;
    CGFloat singleH = scrollView.frame.size.height;
    for (int i = 0; i < ZQNewFetureCount; ++i) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(singleW * i, 0, singleW, singleH);
        imageView.image = [UIImage imageWithName:[NSString stringWithFormat:@"new_feature_%d", i + 1]];
        [scrollView addSubview:imageView];
        
        if (i == ZQNewFetureCount - 1) {
            imageView.userInteractionEnabled = YES;
            [self setupLastImageView:imageView];
        }
    }
    
    
    scrollView.contentSize = CGSizeMake(singleW * ZQNewFetureCount, singleH);
    
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
}

- (void)setupPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.center = CGPointMake(self.view.center.x, self.view.frame.size.height - 30);
    pageControl.bounds = CGRectMake(0, 0, 300, 30);
    pageControl.numberOfPages = ZQNewFetureCount;
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor blueColor];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

- (void)setupLastImageView:(UIImageView *)imageView
{
    UIButton *startButton = [[UIButton alloc] init];
    startButton.center = CGPointMake(self.view.center.x, self.view.center.y + 20);
    startButton.bounds = CGRectMake(0, 0, 200, 40);
    [startButton setTitle:@"开始" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage resizableImage:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage resizableImage:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startButton addTarget:self action:@selector(clickStartButton:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
    
    ZQCheckBoxButton *checkButton = [ZQCheckBoxButton button];
    checkButton.selected = YES;
    [checkButton setTitle:@"haha开始" forState:UIControlStateNormal];
    checkButton.center = CGPointMake(startButton.center.x, startButton.center.y - 40);
    checkButton.bounds = CGRectMake(0, 0, 200, 20);
    [checkButton addTarget:self action:@selector(clickCheckBox:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:checkButton];
}

- (void)clickStartButton:(UIButton *)startButton
{
    if ([ZQAccountTool readAccount] != nil) {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[ZQTabBarController alloc] init];
    } else {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[ZQOAuthController alloc] init];
    }
}

- (void)clickCheckBox:(ZQCheckBoxButton *)checkBoxButton
{
    checkBoxButton.selected = !checkBoxButton.selected;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupScrollView];
    
    [self setupPageControl];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int currentPage = (scrollView.contentOffset.x + scrollView.frame.size.width * 0.5) / scrollView.frame.size.width;
    self.pageControl.currentPage = currentPage;
}

@end
