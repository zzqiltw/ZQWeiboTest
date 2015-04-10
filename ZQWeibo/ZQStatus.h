//
//  ZQStatus.h
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-22.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZQUser.h"
#import "ZQPhoto.h"
@interface ZQStatus : NSObject
/**
 *  微博的内容(文字)
 */
@property (nonatomic, copy) NSString *text;
/**
 *  微博的来源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  微博的时间
 */
@property (nonatomic, copy) NSString *created_at;
/**
 *  微博的ID
 */
@property (nonatomic, copy) NSString *idstr;


/**
 *  微博的转发数
 */
@property (nonatomic, assign) int reposts_count;
/**
 *  微博的评论数
 */
@property (nonatomic, assign) int comments_count;
/**
 *  微博的表态数(被赞数)
 */
@property (nonatomic, assign) int attitudes_count;

/**
 *  微博的作者
 */
@property (nonatomic, strong) ZQUser *user;
/**
 *  被转发的微博
 */
@property (nonatomic, strong) ZQStatus *retweeted_status;

@property (nonatomic, strong) NSArray *pic_urls;

@end
