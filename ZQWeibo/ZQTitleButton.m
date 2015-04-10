//
//  ZQTitleButton.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-13.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQTitleButton.h"

@interface ZQTitleButton ()

@property (nonatomic, assign) CGFloat imageWidth;

@end
@implementation ZQTitleButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage resizableImage:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        
        self.adjustsImageWhenHighlighted = NO;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:19];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat y = 0;
    CGFloat w = contentRect.size.width - self.imageWidth;
    CGFloat h = contentRect.size.height;
    CGFloat x = 0;
    
    return CGRectMake(x, y, w, h);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat y = 0;
    CGFloat w = self.currentImage.size.width + 10;
    self.imageWidth = w;
    CGFloat h = contentRect.size.height;
    CGFloat x = contentRect.size.width - w;
    
    return CGRectMake(x, y, w, h);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    CGRect frame = self.frame;
    CGFloat width = [title sizeWithFont:self.titleLabel.font].width + self.imageWidth + 5;
    frame.size.width = width;
    self.frame = frame;
    [super setTitle:title forState:state];
}
@end
