//
//  ZQTabButton.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-6.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQTabButton.h"
#import "ZQBadgeButton.h"
#define kImageRatio 0.6

@interface ZQTabButton ()

@property (nonatomic, weak) ZQBadgeButton *badgeButton;

@end

@implementation ZQTabButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        if (!iOS7) {
            [self setBackgroundImage:[UIImage imageWithName:@"tabbar_slider"] forState:UIControlStateSelected];
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } else {
            [self setTitleColor:[UIColor colorWithRed:117.0/255.0 green:117.0/255.0 blue:117.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
        }
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        ZQBadgeButton *badgeButton = [[ZQBadgeButton alloc] init];
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
    }
    return self;
}

- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    //kvo
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionInitial context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionInitial context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionInitial context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionInitial context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
//    [self setTitle:item.title forState:UIControlStateNormal];
//    [self setImage:item.image forState:UIControlStateNormal];
//    [self setImage:item.selectedImage forState:UIControlStateSelected];
//    
//    if (item.badgeValue != nil) {
//        self.badgeButton.badgeValue = item.badgeValue;
//        CGRect frame = self.badgeButton.frame;
//        frame.origin.x -= 30;
//        self.badgeButton.frame = frame;
//    } else {
//        self.badgeButton.hidden = YES;
//    }
}

/**
 *  KVO监听必须在监听器释放的时候，移除监听操作
 *  通知也得在释放的时候移除监听
 */
- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setTitle:self.item.title forState:UIControlStateSelected];
    
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    self.badgeButton.badgeValue = self.item.badgeValue;
    CGRect frame = self.badgeButton.frame;
    frame.origin.x = self.frame.size.width - frame.size.width - 5;
    frame.origin.y = 2;
    self.badgeButton.frame = frame;
}



- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * kImageRatio);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, self.imageView.frame.size.height, contentRect.size.width, contentRect.size.height * (1 - kImageRatio));
}

- (void)setHighlighted:(BOOL)highlighted
{
    // 什么都不做，默认取消highlighted发光效果
}


@end
