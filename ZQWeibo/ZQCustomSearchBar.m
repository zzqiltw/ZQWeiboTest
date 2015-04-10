//
//  ZQCustomSearchBar.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-11.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQCustomSearchBar.h"

@implementation ZQCustomSearchBar

+ (ZQCustomSearchBar *)searchBar {
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.background = [UIImage resizableImage:@"searchbar_textfield_background"];
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.enablesReturnKeyAutomatically = YES;
        self.returnKeyType = UIReturnKeySearch;
        
        NSAttributedString *attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入搜索内容" attributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor], NSFontAttributeName : [UIFont systemFontOfSize:8]}];
        self.attributedPlaceholder = attributedPlaceholder;
        
        UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"searchbar_textfield_search_icon"]];
        leftView.contentMode = UIViewContentModeCenter;
        CGRect frame = leftView.frame;
        frame.size.width += 10;
        leftView.frame = frame;
        
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftView = leftView;
    }
    return self;
}

@end
