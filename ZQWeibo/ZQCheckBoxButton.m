//
//  ZQCheckBoxButton.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-13.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQCheckBoxButton.h"

@implementation ZQCheckBoxButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selected = NO;
        
        [self setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];

        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    }
    return self;
}

+ (ZQCheckBoxButton *)button
{
    return [[self alloc] init];
}

@end
