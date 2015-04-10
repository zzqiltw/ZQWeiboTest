//
//  ZQHTTPTool.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-2-7.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQHTTPTool.h"
#import <AFNetworking/AFNetworking.h>

@implementation ZQFormData

@end

@implementation ZQHTTPTool

+ (void)postWithUrlStr:(NSString *)urlString params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getWithUrlStr:(NSString *)urlString params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postWithUrlStr:(NSString *)urlString params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (ZQFormData *eachFormData in formDataArray) {
            [formData appendPartWithFileData:eachFormData.contentData name:eachFormData.paramName fileName:eachFormData.filename mimeType:eachFormData.mimeType];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}



@end
