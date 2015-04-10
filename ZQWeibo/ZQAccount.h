//
//  ZQAccount.h
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-21.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZQAccount : NSObject<NSCoding>
@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, assign) long long expires_in;
@property (nonatomic, assign) long long remind_in;
@property (nonatomic, assign) long long uid;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSDate *expiresDate;

+ (instancetype)accountWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
