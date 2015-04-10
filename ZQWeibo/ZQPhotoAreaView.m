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
    int count = self.photos.count;
    
    // MJ老师三方框架:图片浏览器
    
    // 1.封装图片数据
    NSMutableArray *myphotos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 一个MJPhoto对应一张显示的图片
        MJPhoto *mjPhoto = [[MJPhoto alloc] init];
        
        mjPhoto.srcImageView = self.subviews[i]; // 来源于哪个UIImageView
        
        ZQPhoto *zqPhoto = self.photos[i];
        NSString *photoUrl = [zqPhoto.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mjPhoto.url = [NSURL URLWithString:photoUrl]; // 图片路径
        
        [myphotos addObject:mjPhoto];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = recognizer.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = myphotos; // 设置所有的图片
    [browser show];

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
