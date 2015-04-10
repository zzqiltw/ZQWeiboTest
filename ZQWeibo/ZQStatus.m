//
//  ZQStatus.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-22.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQStatus.h"
#import "NSDate+Addition.h"
#import "MJExtension/MJExtension.h"
@implementation ZQStatus

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [ZQPhoto class]};
}

- (NSString *)created_at
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    // 真机调试必须加上这段，否则出不来
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *date = [formatter dateFromString:_created_at];
    return [date diff2now];
}

- (void)setSource:(NSString *)source
{
    if ([source rangeOfString:@"<a href="].length > 0) {
        int start = [source rangeOfString:@">"].location + 1;
        int end = [source rangeOfString:@"</a>"].location;
        
        source = [source substringWithRange:NSMakeRange(start, end - start)];
    }
    _source = [NSString stringWithFormat:@"来自%@", source];
}

@end
