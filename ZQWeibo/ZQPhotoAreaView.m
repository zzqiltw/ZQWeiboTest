//
//  ZQPhotoAreaView.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-28.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQPhotoAreaView.h"
#import "ZQPhoto.h"
#import "ZQPhotoView.h"

#import "MJPhotoBrowser/MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface ZQPhotoAreaView ()

@property (nonatomic, weak) ZQPhotoView *currentNewPhotoView;
@property (nonatomic, assign) CGRect currentFrame;

@end

@implementation ZQPhotoAreaView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        // 先把9个全部加进去,然后根据数量决定要不要隐藏
        for (NSInteger i = 0; i < 9; ++i) {
            ZQPhotoView *photoView = [[ZQPhotoView alloc] init];
            photoView.userInteractionEnabled = YES;
            photoView.tag = i;
            [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)]];
            [self addSubview:photoView];
        }
    }
    return self;
}

- (void)photoTap:(UIGestureRecognizer *)recognizer
{
    UIButton *cover = [[UIButton alloc] init];
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.9;
    [cover addTarget:self action:@selector(coverTap:) forControlEvents:UIControlEventTouchUpInside];
    cover.frame = [UIScreen mainScreen].applicationFrame;
    [[UIApplication sharedApplication].keyWindow addSubview:cover];
    
    ZQPhotoView *currentPhotoView = (ZQPhotoView *)recognizer.view;
    ZQPhotoView *newPhotoView = [[ZQPhotoView alloc] init];
    newPhotoView.image = currentPhotoView.image;
    newPhotoView.frame = [self convertRect:currentPhotoView.frame toView:cover];
    self.currentFrame = newPhotoView.frame;
    self.currentNewPhotoView = newPhotoView;

    [UIView animateWithDuration:0.2f animations:^{
        CGFloat x = 0;
        CGFloat width = cover.frame.size.width;
        CGFloat height = newPhotoView.frame.size.width * cover.frame.size.height / width;
        CGFloat y = (cover.frame.size.height - height) * 0.5;
        newPhotoView.frame = CGRectMake(x, y, width, height);
        [cover addSubview:newPhotoView];
    }];
    
//    int count = self.photos.count;
//    // MJ老师三方框架:图片浏览器
//    
//    // 1.封装图片数据
//    NSMutableArray *myphotos = [NSMutableArray arrayWithCapacity:count];
//    for (int i = 0; i<count; i++) {
//        // 一个MJPhoto对应一张显示的图片
//        MJPhoto *mjPhoto = [[MJPhoto alloc] init];
//        
//        mjPhoto.srcImageView = self.subviews[i]; // 来源于哪个UIImageView
//        
//        ZQPhoto *zqPhoto = self.photos[i];
//        NSString *photoUrl = [zqPhoto.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
//        mjPhoto.url = [NSURL URLWithString:photoUrl]; // 图片路径
//        
//        [myphotos addObject:mjPhoto];
//    }
//    
//    // 2.显示相册
//    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
//    browser.currentPhotoIndex = recognizer.view.tag; // 弹出相册时显示的第一张图片是？
//    browser.photos = myphotos; // 设置所有的图片
//    [browser show];

}

- (void)coverTap:(UIButton *)cover
{
    [UIView animateWithDuration:0.2f animations:^{
        cover.backgroundColor = [UIColor clearColor];
        self.currentNewPhotoView.frame = self.currentFrame;
    } completion:^(BOOL finished) {
        [cover removeFromSuperview];
    }];
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    NSInteger photoCount = photos.count;
    // 如果是4张图那么就田字格否则一律九宫格
    NSInteger maxCol = photoCount == 4 ? 2 : 3;
    for (NSInteger i = 0; i < self.subviews.count; ++i) {
        ZQPhotoView *photoView = self.subviews[i];
        if (i >= photoCount) {
            photoView.hidden = YES;
        } else {
            photoView.hidden = NO;
            // 传递模型
            photoView.photo = photos[i];
            
            NSInteger col = i % maxCol;
            NSInteger row = i / maxCol;
            CGFloat photoViewX = col * (ZQPhotoW + ZQPhotoMargin);
            CGFloat photoViewY = row * (ZQPhotoH + ZQPhotoMargin);
            photoView.frame = CGRectMake(photoViewX, photoViewY, ZQPhotoW, ZQPhotoH);


            if (photos.count == 1) {
                photoView.contentMode = UIViewContentModeScaleAspectFit;
                photoView.clipsToBounds = NO;
            } else {
                photoView.contentMode = UIViewContentModeScaleAspectFill;
                photoView.clipsToBounds = YES;
            }
        }
    }
}

+ (CGSize)photoAreaViewSizeWithPhotoCount:(NSInteger)count
{
    NSInteger maxCol = count == 4 ? 2 : 3;
    // 最多有多少行
    NSInteger rows = (count + maxCol - 1) / maxCol;
    // 最多有多少列
    NSInteger cols = count > maxCol ? maxCol : count;

    CGFloat w = cols * (ZQPhotoW + ZQPhotoMargin) - ZQPhotoMargin;
    CGFloat h = rows * (ZQPhotoH + ZQPhotoMargin) - ZQPhotoMargin;
    
    return CGSizeMake(w, h);
}

@end
