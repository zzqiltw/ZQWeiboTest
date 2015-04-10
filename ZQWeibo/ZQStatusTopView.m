//
//  ZQStatusTopView.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-27.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQStatusTopView.h"
#import "ZQStatus.h"
#import "ZQUser.h"
#import "ZQStatusRetweetView.h"
#import "ZQPhotoAreaView.h"
#import <UIImageView+WebCache.h>
@interface ZQStatusTopView ()

/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) ZQPhotoAreaView *photoView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文\内容 */
@property (nonatomic, weak) UILabel *contentLabel;
/** 被转发的微博 */
@property (nonatomic, weak) ZQStatusRetweetView *retweetView;

@end

@implementation ZQStatusTopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        self.image = [UIImage resizableImage:@"timeline_card_top_background"];
        self.highlightedImage = [UIImage resizableImage:@"timeline_card_top_background_highlighted"];

        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    /** 2.头像 */
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    self.iconView = iconView;
    
    /** 3.会员图标 */
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    vipView.contentMode = UIViewContentModeCenter;
    self.vipView = vipView;
    
    /** 4.配图 */
    ZQPhotoAreaView *photoView = [[ZQPhotoAreaView alloc] init];
    [self addSubview:photoView];
    self.photoView = photoView;
    
    /** 5.昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = ZQStatusNameFont;
    nameLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 6.时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = ZQStatusTimeFont;
    
    timeLabel.textColor = ZQColor(240, 140, 19);
    timeLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    /** 7.来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = ZQStatusSourceFont;
    sourceLabel.textColor = ZQColor(135, 135, 135);
    sourceLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    /** 8.正文\内容 */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = ZQColor(39, 39, 39);
    contentLabel.font = ZQStatusContentFont;
    contentLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    /** 9.被转发微博的view(父控件) */
    ZQStatusRetweetView *retweetView = [[ZQStatusRetweetView alloc] init];
    [self addSubview:retweetView];
    self.retweetView = retweetView;
}

- (void)setStatusFrame:(ZQStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    self.frame = statusFrame.topViewF;
    
    ZQStatus *status = statusFrame.status;
    ZQUser *user = status.user;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.statusFrame.status.user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    self.iconView.frame = self.statusFrame.iconViewF;
    
    self.nameLabel.text = statusFrame.status.user.name;
    self.nameLabel.frame = self.statusFrame.nameLabelF;
    
    if (user.mbtype > 2) {
        self.vipView.hidden = NO;
        self.vipView.frame = self.statusFrame.vipViewF;
        self.nameLabel.textColor = [UIColor redColor];
        NSString *vipImage = [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank];
        self.vipView.image = [UIImage imageWithName:vipImage];
    } else {
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    CGFloat timeX = self.statusFrame.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(self.statusFrame.nameLabelF) + ZQCellMargin * 0.5;
    CGSize timeSize = [status.created_at sizeWithFont:ZQStatusTimeFont];
    self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
    self.timeLabel.text = status.created_at;
    
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + ZQCellMargin * 0.5;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:ZQStatusSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    self.sourceLabel.text = status.source;
    
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelF;
    
    if (status.pic_urls.count) {
        self.photoView.hidden = NO;
        self.photoView.frame = self.statusFrame.photoViewF;
//        ZQPhoto *photo = status.pic_urls[0];
//        [self.photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
        self.photoView.photos = status.pic_urls;
    } else {
        self.photoView.hidden = YES;
    }
    
    self.retweetView.statusFrame = _statusFrame;
}

@end
