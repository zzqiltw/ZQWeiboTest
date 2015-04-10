//
//  ZQHTTPTool.h
//  ZQWeibo
//
//  Created by zzqiltw on 15-2-7.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZQFormData : NSObject

@property (nonatomic, copy) NSString *paramName;
@property (nonatomic, copy) NSString *filename;
@property (nonatomic, strong) NSData *contentData;
@property (nonatomic, copy) NSString *mimeType;

@end

@interface ZQHTTPTool : NSObject

+ (void)postWithUrlStr:(NSString *)urlString params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

+ (void)getWithUrlStr:(NSString *)urlString params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

+ (void)postWithUrlStr:(NSString *)urlString params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

@end
