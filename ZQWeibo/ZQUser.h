//
//  ZQUser.h
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-22.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZQUser : NSObject

/**
 *  用户的ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  用户的昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  用户的头像
 */
@property (nonatomic, copy) NSString *profile_image_url;

/**
 *  是否为vip
 */
@property (nonatomic, assign) NSInteger mbrank;
@property (nonatomic, assign) NSInteger mbtype;



@end
