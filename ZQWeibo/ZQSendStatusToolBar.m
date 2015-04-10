//
//  ZQSendStatusToolBar.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-2-3.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQSendStatusToolBar.h"

@implementation ZQSendStatusToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.设置背景
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"compose_toolbar_background"]];
        
        // 2.添加按钮
        [self addButtonWithIcon:@"compose_camerabutton_background" highIcon:@"compose_camerabutton_background_highlighted" tag:ZQSendStatusToolBarButtonTypeCamera];
        [self addButtonWithIcon:@"compose_toolbar_picture" highIcon:@"compose_toolbar_picture_highlighted" tag:ZQSendStatusToolBarButtonTypePicture];
        [self addButtonWithIcon:@"compose_mentionbutton_background" highIcon:@"compose_mentionbutton_background_highlighted" tag:ZQSendStatusToolBarButtonTypeMention];
        [self addButtonWithIcon:@"compose_trendbutton_background" highIcon:@"compose_trendbutton_background_highlighted" tag:ZQSendStatusToolBarButtonTypeTrend];
        [self addButtonWithIcon:@"compose_emoticonbutton_background" highIcon:@"compose_emoticonbutton_background_highlighted" tag:ZQSendStatusToolBarButtonTypeEmotion];
    }
    return self;
}

- (void)addButtonWithIcon:(NSString *)icon highIcon:(NSString *)highIcon tag:(int)tag
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    [self addSubview:button];
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(toolBar:didClickBtnAtToolBarWithTag:)]) {
        [self.delegate toolBar:self didClickBtnAtToolBarWithTag:button.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    for (int i = 0; i<self.subviews.count; i++) {
        UIButton *button = self.subviews[i];
        CGFloat buttonX = buttonW * i;
        button.frame = CGRectMake(buttonX, 0, buttonW, buttonH);
    }
}

@end

