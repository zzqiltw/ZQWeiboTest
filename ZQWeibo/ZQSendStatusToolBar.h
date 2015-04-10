//
//  ZQSendStatusToolBar.h
//  ZQWeibo
//
//  Created by zzqiltw on 15-2-3.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ZQSendStatusToolBarButtonTypeCamera,
    ZQSendStatusToolBarButtonTypePicture,
    ZQSendStatusToolBarButtonTypeMention,
    ZQSendStatusToolBarButtonTypeTrend,
    ZQSendStatusToolBarButtonTypeEmotion
} ZQSendStatusToolBarButtonType;

@protocol ZQSendStatusToolBarDelegate;

@interface ZQSendStatusToolBar : UIView

@property (nonatomic, weak) id<ZQSendStatusToolBarDelegate> delegate;

@end

@protocol ZQSendStatusToolBarDelegate <NSObject>

@optional
- (void)toolBar:(ZQSendStatusToolBar *)toolBar didClickBtnAtToolBarWithTag:(ZQSendStatusToolBarButtonType)tag;

@end
