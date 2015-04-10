//
//  ZQStatusToolBar.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-25.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQStatusToolBar.h"

@interface ZQStatusToolBar ()

@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *seps;

@property (nonatomic, weak) UIButton *retweetBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *attitudeBtn;

@end

@implementation ZQStatusToolBar

- (NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)seps
{
    if (_seps == nil) {
        _seps = [NSMutableArray array];
    }
    return _seps;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        self.image = [UIImage resizableImage:@"timeline_card_bottom_background"];
        self.highlightedImage = [UIImage resizableImage:@"timeline_card_bottom_background_highlighted"];
        
        self.retweetBtn = [self setupBtnsWithTitle:@"转发" imageName:@"timeline_icon_retweet" bgImgName:@"timeline_card_leftbottom_highlighted"];
        self.commentBtn = [self setupBtnsWithTitle:@"评论" imageName:@"timeline_icon_comment" bgImgName:@"timeline_card_middlebottom_highlighted"];
        self.attitudeBtn = [self setupBtnsWithTitle:@"赞" imageName:@"timeline_icon_unlike" bgImgName:@"timeline_card_rightbottom_highlighted"];
        
        [self setupSeps];
        [self setupSeps];
        
    }
    return self;
}

- (UIButton *)setupBtnsWithTitle:(NSString *)title imageName:(NSString *)imageName bgImgName:(NSString *)bgImgName
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageWithName:imageName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage resizableImage:bgImgName] forState:UIControlStateHighlighted];
    btn.adjustsImageWhenHighlighted = NO;
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 7);
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.btns addObject:btn];
    [self addSubview:btn];
    return btn;
}

- (void)setupSeps
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageWithName:@"timeline_card_bottom_line"];
    [self.seps addObject:imageView];
    [self addSubview:imageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger btnCount = self.btns.count;
    CGFloat btnY = 0;
    CGFloat btnW = self.frame.size.width / btnCount;
    CGFloat btnH = self.frame.size.height;
    
    for (NSInteger i = 0; i < btnCount; ++i) {
        UIButton *button = self.btns[i];
        CGFloat btnX = btnW * i;
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    NSInteger sepCount = self.seps.count;
    CGFloat sepY = 0;
    CGFloat sepW = 2;
    CGFloat sepH = self.frame.size.height;
    
    for (NSInteger i = 0; i < sepCount; ++i) {
        UIImageView *imageView = self.seps[i];
        CGFloat sepX = (i + 1) * btnW;
        imageView.frame = CGRectMake(sepX, sepY, sepW, sepH);
    }

}

- (void)setStatusFrame:(ZQStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    ZQStatus *status = statusFrame.status;
    self.frame = statusFrame.statusToolbarF;
    [self setupBtnTitleWithBtn:self.retweetBtn originalTitle:@"转发" number:status.reposts_count];
    [self setupBtnTitleWithBtn:self.commentBtn originalTitle:@"评论" number:status.comments_count];
    [self setupBtnTitleWithBtn:self.attitudeBtn originalTitle:@"赞" number:status.attitudes_count];
}

- (void)setupBtnTitleWithBtn:(UIButton *)btn originalTitle:(NSString *)ori number:(NSInteger)number
{
    NSString *title = nil;
    if (number != 0) {
        if (number < 1000) {
            title = [NSString stringWithFormat:@"%d", number];
        } else {
            double finalNum = number / 1000.0;
            title = [NSString stringWithFormat:@"%.1fk", finalNum];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    } else {
        title = [NSString stringWithFormat:@"%d", number];
    }
    [btn setTitle:title forState:UIControlStateNormal];
}

@end
