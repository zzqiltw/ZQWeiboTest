//
//  ZQStatusFrame.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-23.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQStatusFrame.h"

@implementation ZQStatusFrame

- (instancetype)initWithStatus:(ZQStatus *)status
{
    if (self = [super init]) {
        self.status = status;
    }
    return self;
}

- (void)setStatus:(ZQStatus *)status
{
    _status = status;
    
    [self setupOrigonalStatusSubviewsFrameWithStatus:_status];
}

- (void)setupOrigonalStatusSubviewsFrameWithStatus:(ZQStatus *)status
{
    CGFloat cellWidth = [[UIScreen mainScreen] applicationFrame].size.width - 2 * ZQCellBorder;
    
    CGFloat topX = 0;
    CGFloat topY = 0;
    CGFloat topW = cellWidth;
    CGFloat topH = 0;
    
    CGFloat iconX = ZQCellMargin;
    CGFloat iconY = ZQCellMargin;
    CGFloat iconWH = 35;
    _iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    CGFloat nameX = CGRectGetMaxX(_iconViewF) + ZQCellMargin;
    CGFloat nameY = iconY;
    CGSize nameSize = [status.user.name sizeWithFont:ZQStatusNameFont];
    _nameLabelF = (CGRect){{nameX, nameY}, nameSize};
    
    if (status.user.mbtype > 2) {
        CGFloat vipX = CGRectGetMaxX(_nameLabelF) + ZQCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipW = 14;
        CGFloat vipH = nameSize.height;// 这里是为了让vip图片垂直居中
        
        _vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(_nameLabelF) + ZQCellMargin * 0.5;
    CGSize timeSize = [status.created_at sizeWithFont:ZQStatusTimeFont];
    _timeLabelF = (CGRect){{timeX, timeY}, timeSize};
    
    CGFloat sourceX = CGRectGetMaxX(_timeLabelF) + ZQCellMargin * 0.5;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:ZQStatusSourceFont];
    _sourceLabelF = (CGRect){{sourceX, sourceY}, sourceSize};
    
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(_sourceLabelF), CGRectGetMaxY(_iconViewF)) + ZQCellMargin;
    CGSize contentSize = [status.text sizeWithFont:ZQStatusContentFont constrainedToSize:CGSizeMake(topW - contentX - 2 * ZQCellMargin, MAXFLOAT)];
    _contentLabelF = (CGRect){{contentX, contentY}, contentSize};
    
    if (status.pic_urls.count) {
        CGFloat photoX = iconX;
        CGFloat photoY = CGRectGetMaxY(_contentLabelF) + ZQCellMargin;
//        CGFloat photoWH = 70;
//        _photoViewF = CGRectMake(photoX, photoY, photoWH, photoWH);
        CGSize photoSize = [ZQPhotoAreaView photoAreaViewSizeWithPhotoCount:status.pic_urls.count];
        _photoViewF = (CGRect){{photoX, photoY}, photoSize};
        
        topH = MAX(CGRectGetMaxY(_iconViewF), CGRectGetMaxY(_photoViewF)) + ZQCellMargin;
    } else {
        topH = MAX(CGRectGetMaxY(_iconViewF), CGRectGetMaxY(_contentLabelF)) + ZQCellMargin;
    }
    
    if (status.retweeted_status) {
        CGFloat retweetViewX = iconX + ZQCellMargin * 0.5;
        CGFloat retweetViewY = topH;
        CGFloat retweetViewW = topW - retweetViewX - ZQCellMargin;
        CGFloat retweetViewH = 0;
        
        CGFloat retweetNameX = ZQCellMargin;
        CGFloat retweetNameY = ZQCellMargin;
        NSString *retweetNameText = [NSString stringWithFormat:@"@%@", status.retweeted_status.user.name];
        CGSize retweetNameSize = [retweetNameText sizeWithFont:ZQRetweetStatusNameFont];
        _retweetNameLabelF = (CGRect){{retweetNameX, retweetNameY}, retweetNameSize};
        
        CGFloat retweetContentX = retweetNameY;
        CGFloat retweetContentY = CGRectGetMaxY(_retweetNameLabelF) + ZQCellMargin;
        CGSize retweetContentSize = [status.retweeted_status.text sizeWithFont:ZQRetweetStatusContentFont constrainedToSize:CGSizeMake(retweetViewW - retweetNameX - 2 * ZQCellMargin, MAXFLOAT)];
        _retweetContentLabelF = (CGRect){{retweetContentX, retweetContentY}, retweetContentSize};
        
        if (status.retweeted_status.pic_urls.count) {
            CGFloat retweetPhotoX = retweetNameX;
            CGFloat retweetPhotoY = CGRectGetMaxY(_retweetContentLabelF) + ZQCellMargin;
//            CGFloat retweetPhotoWH = 70;
//            _retweetPhotoViewF = CGRectMake(retweetPhotoX, retweetPhotoY, retweetPhotoWH, retweetPhotoWH);
            CGSize retweetPhotoSize = [ZQPhotoAreaView photoAreaViewSizeWithPhotoCount:status.retweeted_status.pic_urls.count];
            _retweetPhotoViewF = (CGRect){{retweetPhotoX, retweetPhotoY}, retweetPhotoSize};
            
            retweetViewH = CGRectGetMaxY(_retweetPhotoViewF) + ZQCellMargin;
        } else {
            retweetViewH = CGRectGetMaxY(_retweetContentLabelF) + ZQCellMargin;
        }
        
        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        topH += retweetViewH + ZQCellMargin * 2;
    }
    
    _topViewF = CGRectMake(topX, topY, topW, topH);
    
    CGFloat toolX = 0;
    CGFloat toolY = CGRectGetMaxY(_topViewF);
    CGFloat toolW = topW;
    CGFloat toolH = 35;
    _statusToolbarF = CGRectMake(toolX, toolY, toolW, toolH);
    
    _cellHeight = CGRectGetMaxY(_statusToolbarF) + ZQCellBorder;
}


@end
