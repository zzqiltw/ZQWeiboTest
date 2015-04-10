//
//  ZQAccountTool.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-21.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQAccountTool.h"
#define ZQAccountFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data.me"]

@implementation ZQAccountTool

+ (void)saveAccount:(ZQAccount *)account
{
    // 计算账号的过期时间
    NSDate *now = [NSDate date];
    // 当前时间+有效的秒数
    account.expiresDate = [now dateByAddingTimeInterval:account.expires_in];
    [NSKeyedArchiver archiveRootObject:account toFile:ZQAccountFilePath];
}

+ (ZQAccount *)readAccount
{
    ZQAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:ZQAccountFilePath];
    NSDate *now = [NSDate date];
    if ([now compare:account.expiresDate] == NSOrderedAscending) {
        return account;
    } else {
        //过期
        return nil;
    }
}


@end
