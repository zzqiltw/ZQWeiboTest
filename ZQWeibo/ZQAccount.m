//
//  ZQAccount.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-21.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQAccount.h"


@implementation ZQAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeInt64ForKey:@"expires_in"];
        self.remind_in = [aDecoder decodeInt64ForKey:@"remind_in"];
        self.uid = [aDecoder decodeInt64ForKey:@"uid"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.expiresDate = [aDecoder decodeObjectForKey:@"expiresDate"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [aCoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [aCoder encodeInt64:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.expiresDate forKey:@"expiresDate"];
}

@end
