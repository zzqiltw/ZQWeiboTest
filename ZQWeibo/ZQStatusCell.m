//
//  ZQStatusCell.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-23.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQStatusCell.h"
#import "ZQStatusToolBar.h"
#import "ZQStatusTopView.h"
#import <UIImageView+WebCache.h>

@interface ZQStatusCell ()

/** 顶部的view */
@property (nonatomic, weak) ZQStatusTopView *topView;

/** 微博的工具条 */
@property (nonatomic, weak) ZQStatusToolBar *statusToolbar;

@end

@implementation ZQStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *CellID = @"status";
    ZQStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellID];
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];// 这个很重要，否则会不协调
        
        /** 1.顶部的view */
        ZQStatusTopView *topView = [[ZQStatusTopView alloc] init];
        [self.contentView addSubview:topView];
        self.topView = topView;

        /** 2.工具条 */
        ZQStatusToolBar *statusToolbar = [[ZQStatusToolBar alloc] init];
        [self.contentView addSubview:statusToolbar];
        self.statusToolbar = statusToolbar;
    }
    return self;
}

/**
 *  拦截tableview设置cell的frame的操作,使cell的内部缩进
 *
 *  @param frame <#frame description#>
 */
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = ZQCellBorder;
    frame.origin.y += ZQCellBorder;
    frame.size.width -= 2 * ZQCellBorder;
    frame.size.height -= 2 * ZQCellBorder;
    [super setFrame:frame];
}

- (void)setStatusFrame:(ZQStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;

    self.topView.statusFrame = _statusFrame;
    self.statusToolbar.statusFrame = _statusFrame;
}


@end
