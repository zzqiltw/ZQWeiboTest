//
//  ZQTextView.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-2-2.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQTextView.h"

@interface ZQTextView ()
@property (nonatomic, weak) UILabel *placeholderLabel;
@end
@implementation ZQTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *placeHoldeLabel = [[UILabel alloc] init];
        placeHoldeLabel.numberOfLines = 0;
        placeHoldeLabel.font = self.font;
        placeHoldeLabel.textColor = [UIColor lightGrayColor];
        placeHoldeLabel.backgroundColor = [UIColor clearColor];
        placeHoldeLabel.hidden = YES;
        [self insertSubview:placeHoldeLabel atIndex:0];
        self.placeholderLabel = placeHoldeLabel;
        
        self.alwaysBounceVertical = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}


- (void)textDidChange:(NSNotification *)notification
{
    self.placeholderLabel.hidden = self.text.length != 0;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setPlaceholder:(NSString *)placeholder
{
//    _placeholder = placeholder;
    _placeholder = [placeholder copy];
    self.placeholderLabel.text = _placeholder;
    
    if (self.placeholderLabel.text.length != 0) {
        self.placeholderLabel.hidden = NO;
        
        CGFloat placeholderX = 5;
        CGFloat placeholderY = 7;
        CGFloat placeholderMaxW = self.frame.size.width - 2 * placeholderX;
        CGFloat placeholderMaxH = self.frame.size.height - 2 * placeholderY;
        CGSize placeholderSize = [_placeholder sizeWithFont:self.placeholderLabel.font constrainedToSize:CGSizeMake(placeholderMaxW, placeholderMaxH)];
        
        self.placeholderLabel.frame = (CGRect){{placeholderX, placeholderY}, placeholderSize};
    } else {
        self.placeholderLabel.hidden = YES;
    }
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLabel.font = font;
    // 下面一句可以重新执行setPlaceholder方法重新计算frame
    self.placeholder = self.placeholder;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}

@end
