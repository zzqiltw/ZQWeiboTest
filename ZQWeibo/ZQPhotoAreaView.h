//
//  ZQPhotoAreaView.h
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-28.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZQPhotoAreaView : UIView
@property (nonatomic, strong) NSArray *photos;

+ (CGSize)photoAreaViewSizeWithPhotoCount:(NSInteger)count;

@end
