//
//  ZQAccountTool.h
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-21.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZQAccount.h"
@interface ZQAccountTool : NSObject

+ (void)saveAccount:(ZQAccount *)account;

+ (ZQAccount *)readAccount;

@end
