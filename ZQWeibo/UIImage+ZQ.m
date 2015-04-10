//
//  UIImage+ZQ.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-6.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "UIImage+ZQ.h"

@implementation UIImage (ZQ)

+ (UIImage *)imageWithName:(NSString *)name
{
    if (iOS7) {
        NSString *iOS7Name = [name stringByAppendingString:@"_os7"];
        UIImage *newImage = [UIImage imageNamed:iOS7Name];
        if (newImage != nil) {
            return newImage;
        }
    }
    
    return [UIImage imageNamed:name];
}

+ (UIImage *)imageOriginalWithName:(NSString *)name
{
    if (iOS7) {
        return [[UIImage imageWithName:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    return [UIImage imageWithName:name];
}

+ (UIImage *)resizableImage:(NSString *)name
{
    return [UIImage resizableImage:name leftScale:0.5 topScale:0.5];
}

+ (UIImage *)resizableImage:(NSString *)name leftScale:(CGFloat)left topScale:(CGFloat)top
{
    UIImage *image = [UIImage imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}
@end
