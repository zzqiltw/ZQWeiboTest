//
//  ZQStatusPicsView.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-2-5.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQStatusPicsView.h"

@interface ZQStatusPicsView ()

@property (nonatomic, weak) UIButton *plusImageButton;

@end
@implementation ZQStatusPicsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIButton *button = [[UIButton alloc] init];
        [button setBackgroundImage:[UIImage imageWithName:@"compose_pic_add"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithName:@"compose_pic_add_highlighted"] forState:UIControlStateHighlighted];
        [self addSubview:button];
        
    }
    return self;
}

- (void)addImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self insertSubview:imageView atIndex:self.subviews.count - 1];
}

- (NSArray *)selectedPhotos
{
    NSMutableArray *images = [NSMutableArray array];
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView *)subview;
            [images addObject:imageView.image];
        }
    }
    
    return images;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat imageW = 70;
    CGFloat imageH = imageW;
    NSInteger maxCol = 4;
    CGFloat margin = (self.frame.size.width - maxCol * imageW) / (maxCol + 1);
    for (NSInteger i = 0; i < self.subviews.count; ++i) {
        NSInteger col = i % maxCol;
        NSInteger row = i / maxCol;
        
        CGFloat imageX = col * (imageW + margin) + margin;
        CGFloat imageY = row * (imageH + margin) + margin;
        
        UIView *subView = self.subviews[i];
        subView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    }
}
@end
