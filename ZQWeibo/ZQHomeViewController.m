//
//  ZQHomeViewController.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-6.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQHomeViewController.h"
#import "ZQBadgeButton.h"
#import "UIBarButtonItem+ZQ.h"
#import "ZQTitleButton.h"
#import "ZQAccount.h"
#import "ZQStatus.h"
#import "ZQStatusFrame.h"
#import "MJExtension.h"
#import "ZQStatusCell.h"
#import <SVPullToRefresh.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "ZQHTTPTool.h"

@interface ZQHomeViewController ()

@property (nonatomic, strong) NSMutableArray *statusFrames;
@property (nonatomic, weak) ZQTitleButton *titleButton;

@end

@implementation ZQHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNav];
    [self setupTableView];
    [self getUserInfo];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newStatusCome:) name:ZQPostSuccessNotificationName object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)newStatusCome:(NSNotification *)notification
{
    [self.tableView triggerPullToRefresh];
}

- (void)getUserInfo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [ZQAccountTool readAccount].access_token;
    params[@"uid"] = @([ZQAccountTool readAccount].uid);
    
    [ZQHTTPTool getWithUrlStr:@"https://api.weibo.com/2/users/show.json" params:params success:^(id responseObject) {
        // 字典转模型
        ZQUser *user = [ZQUser objectWithKeyValues:responseObject];
        // 设置标题文字
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        // 保存昵称
        ZQAccount *account = [ZQAccountTool readAccount];
        account.name = user.name;
        [ZQAccountTool saveAccount:account];
    } failure:^(NSError *error) {
        
    }];
}

- (void)loadNewStatus
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"access_token"] = [[ZQAccountTool readAccount] access_token];
    if (self.statusFrames.count != 0) {
        ZQStatusFrame *statusFrame = self.statusFrames[0];
        dict[@"since_id"] = statusFrame.status.idstr;
    }
    
    __block __weak typeof(self) weakSelf = self;
    [ZQHTTPTool getWithUrlStr:@"https://api.weibo.com/2/statuses/home_timeline.json" params:dict success:^(id responseObject) {
        NSArray *statuses = [ZQStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSMutableArray *statusFramesTmpArray = [NSMutableArray array];
        for (ZQStatus *status in statuses) {
            ZQStatusFrame *statusFrame = [[ZQStatusFrame alloc] initWithStatus:status];
            [statusFramesTmpArray addObject:statusFrame];
        }
        NSInteger newStatusCount = statusFramesTmpArray.count;
        [statusFramesTmpArray addObjectsFromArray:weakSelf.statusFrames];
        weakSelf.statusFrames = statusFramesTmpArray;
        if (newStatusCount != 0) {
            [self.tableView reloadData];
        }
        
        [self.tableView.pullToRefreshView stopAnimating];
        [self showTopMessageOfCount:newStatusCount];
    } failure:^(NSError *error) {
        [self.tableView.pullToRefreshView stopAnimating];
    }];
}

- (void)loadMoreStatus
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"access_token"] = [[ZQAccountTool readAccount] access_token];
    ZQStatusFrame *statusFrame = self.statusFrames.lastObject;
    dict[@"max_id"] = @(statusFrame.status.idstr.longLongValue - 1);

    __block __weak typeof(self) weakSelf = self;
    
    [ZQHTTPTool getWithUrlStr:@"https://api.weibo.com/2/statuses/home_timeline.json" params:dict success:^(id responseObject) {
        NSArray *statuses = [ZQStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        for (ZQStatus *status in statuses) {
            ZQStatusFrame *statusFrame = [[ZQStatusFrame alloc] initWithStatus:status];
            [weakSelf.statusFrames addObject:statusFrame];
        }
        [self.tableView reloadData];
        [self.tableView.infiniteScrollingView stopAnimating];

    } failure:^(NSError *error) {
        [self.tableView.infiniteScrollingView stopAnimating];
    }];
}

- (void)setupTableView
{
    self.tableView.backgroundColor = ZQColor(226, 226, 226);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 2 * ZQCellBorder, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        UIEdgeInsets insets = self.tableView.contentInset;
        insets.top = self.navigationController.navigationBar.bounds.size.height +
        [UIApplication sharedApplication].statusBarFrame.size.height;
        insets.bottom += 50;
        self.tableView.contentInset = insets;
        self.tableView.scrollIndicatorInsets = insets;
    }
    
    __weak typeof(self) weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf loadNewStatus];
    }];
    [self.tableView.pullToRefreshView setTitle:@"加载..." forState:SVPullToRefreshStateAll];
    [self.tableView.pullToRefreshView setTitle:@"正在加载中..." forState:SVPullToRefreshStateLoading];
    [self.tableView.pullToRefreshView setTitle:@"释放刷新..." forState:SVPullToRefreshStateTriggered];
    
    [self.tableView triggerPullToRefresh];
    
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf loadMoreStatus];
    }];
}

- (void)setupNav
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highlightedIcon:@"navigationbar_pop_highlighted" target:self action:@selector(rightClick)];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highlightedIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(leftClick)];
    
    ZQTitleButton *titleButton = [[ZQTitleButton alloc] init];
    titleButton.frame = CGRectMake(0, 0, 120, 40);
    NSString *title = nil;
    if ([ZQAccountTool readAccount].name) {
        title = [ZQAccountTool readAccount].name;
    } else {
        title = @"首页";
    }
    
    [titleButton setTitle:title forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    self.titleButton = titleButton;
}



- (void)showTopMessageOfCount:(NSInteger)count;
{
    UIButton *messageButton = [[UIButton alloc] init];
    messageButton.userInteractionEnabled = NO;
    // 要添加在导航栏控制器的view上，如果添加到tableview上那么滚动的时候按钮也会滚动
    [self.navigationController.view insertSubview:messageButton belowSubview:self.navigationController.navigationBar];
    [messageButton setBackgroundImage:[UIImage resizableImage:@"timeline_new_status_background"] forState:UIControlStateNormal];
    NSString *title = @"没有新数据";
    if (count != 0) {
        title = [NSString stringWithFormat:@"%d条新微博", count];
    }
    [messageButton setTitle:title forState:UIControlStateNormal];
    [messageButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    messageButton.titleLabel.font = [UIFont systemFontOfSize:12];
    messageButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    messageButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    CGFloat messageBtnX = 0;
    CGFloat messageBtnH = 40;
    CGFloat messageBtnW = self.view.frame.size.width;
    CGFloat messageBtnY = self.navigationController.navigationBar.bounds.size.height + 21 - messageBtnH;
    messageButton.frame = CGRectMake(messageBtnX, messageBtnY, messageBtnW, messageBtnH);
    
    [UIView animateWithDuration:0.5f animations:^{
        messageButton.transform = CGAffineTransformMakeTranslation(0, messageBtnH);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5f delay:0.8f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            // 设置为单位矩阵则表示恢复原状态
            messageButton.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            // 结束后移除
            [messageButton removeFromSuperview];
        }];
    }];
}

- (void)titleClick:(ZQTitleButton *)titleButton
{
    [UIView animateWithDuration:0.3F animations:^{
        titleButton.imageView.transform = CGAffineTransformRotate(titleButton.imageView.transform, M_PI);
    }];
}

- (void)rightClick
{
    NSLog(@"right");
}

- (void)leftClick
{
    NSLog(@"left");
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZQStatusCell *cell = [ZQStatusCell cellWithTableView:tableView];
    cell.statusFrame = self.statusFrames[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZQStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}


@end
