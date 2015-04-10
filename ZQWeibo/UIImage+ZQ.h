//
//  UIImage+ZQ.h
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-6.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZQ)

+ (UIImage *)imageWithName:(NSString *)name;
+ (UIImage *)imageOriginalWithName:(NSString *)name;
+ (UIImage *)resizableImage:(NSString *)name;
+ (UIImage *)resizableImage:(NSString *)name leftScale:(CGFloat)left topScale:(CGFloat)top;

@end
