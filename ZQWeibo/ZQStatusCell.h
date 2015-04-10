//
//  ZQStatusCell.h
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-23.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQStatusFrame.h"
@interface ZQStatusCell : UITableViewCell

@property (nonatomic, strong) ZQStatusFrame *statusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
