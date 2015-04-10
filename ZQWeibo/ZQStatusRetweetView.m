//
//  ZQStatusRetweetView.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-27.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQStatusRetweetView.h"
#import "ZQPhoto.h"
#import "ZQPhotoAreaView.h"
#import <UIImageView+WebCache.h>
@interface ZQStatusRetweetView ()

/** 被转发微博作者的昵称 */
@property (nonatomic, weak) UILabel *retweetNameLabel;
/** 被转发微博的正文\内容 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 被转发微博的配图 */
@property (nonatomic, weak) ZQPhotoAreaView *retweetPhotoView;

@end
@implementation ZQStatusRetweetView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        self.image = [UIImage resizableImage:@"timeline_retweet_background" leftScale:0.9 topScale:0.4];
        /** 2.被转发微博作者的昵称 */
        UILabel *retweetNameLabel = [[UILabel alloc] init];
        retweetNameLabel.font = ZQRetweetStatusNameFont;
        [self addSubview:retweetNameLabel];
        self.retweetNameLabel = retweetNameLabel;
        
        /** 3.被转发微博的正文\内容 */
        UILabel *retweetContentLabel = [[UILabel alloc] init];
        retweetContentLabel.font = ZQRetweetStatusContentFont;
        retweetContentLabel.numberOfLines = 0;
        //    retweetContentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:retweetContentLabel];
        self.retweetContentLabel = retweetContentLabel;
        
        /** 4.被转发微博的配图 */
        ZQPhotoAreaView *retweetPhotoView = [[ZQPhotoAreaView alloc] init];
        [self addSubview:retweetPhotoView];
        self.retweetPhotoView = retweetPhotoView;
    }
    return self;
}

- (void)setStatusFrame:(ZQStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    ZQStatus *retweetStatus = statusFrame.status.retweeted_status;
    ZQUser *user = retweetStatus.user;
    
    // 1.父控件
    if (retweetStatus) {
        self.hidden = NO;
        self.frame = self.statusFrame.retweetViewF;
        
        // 2.昵称
        self.retweetNameLabel.text = [NSString stringWithFormat:@"@%@", user.name];
        self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
        
        // 3.正文
        self.retweetContentLabel.text = retweetStatus.text;
        self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
        
        // 4.配图
        if (retweetStatus.pic_urls.count) {
            self.retweetPhotoView.hidden = NO;
            self.retweetPhotoView.frame = self.statusFrame.retweetPhotoViewF;
//            ZQPhoto *photo = retweetStatus.pic_urls[0];
//            self.retweetPhotoView.photo = photo;
            self.retweetPhotoView.photos = retweetStatus.pic_urls;
            
        } else {
            self.retweetPhotoView.hidden = YES;
        }
    } else {
        self.hidden = YES;
    }

}
@end
