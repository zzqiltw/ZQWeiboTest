//
//  ZQPhotoView.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-28.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQPhotoView.h"
#import <UIImageView+WebCache.h>

@interface ZQPhotoView ()

@property (nonatomic, weak) UIImageView *gifImage;

@end
@implementation ZQPhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *gifImage = [[UIImageView alloc] init];
        gifImage.image = [UIImage imageWithName:@"timeline_image_gif"];
        gifImage.frame = (CGRect){CGPointZero, gifImage.image.size};
        [self addSubview:gifImage];
        self.gifImage = gifImage;
    }
    return self;
}

- (void)setPhoto:(ZQPhoto *)photo
{
    _photo = photo;
    
    self.gifImage.hidden = ![self.photo.thumbnail_pic hasSuffix:@"gif"];
    [self sd_setImageWithURL:[NSURL URLWithString:self.photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 保证在右下角
    self.gifImage.layer.position = CGPointMake(self.frame.size.width, self.frame.size.height);
    self.gifImage.layer.anchorPoint = CGPointMake(1, 1);
}


@end
