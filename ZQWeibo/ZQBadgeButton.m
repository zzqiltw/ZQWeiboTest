//
//  ZQBadgeButton.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-8.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQBadgeButton.h"

@implementation ZQBadgeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage resizableImage:@"main_badge"] forState:UIControlStateNormal];
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        self.frame = CGRectMake(0, 0, self.currentBackgroundImage.size.width, self.currentImage.size.height);
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    
    if (badgeValue.length > 0) {
        self.hidden = NO;
        [self setTitle:badgeValue forState:UIControlStateNormal];
        CGSize size = [badgeValue sizeWithFont:self.titleLabel.font];
        CGRect frame = self.frame;
        frame.size.width = size.width + 10;
        frame.size.height = size.height + 4;
        self.contentEdgeInsets = UIEdgeInsetsMake(1, 3, 1, 3);
        self.frame = frame;
    } else {
        self.hidden = YES;
    }
}
@end
