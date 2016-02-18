//
//  TTTextView.m
//  weibo
//
//  Created by leo on 16/2/17.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TTTextView.h"

@interface TTTextView ()

@property (nonatomic, weak) UILabel *placeHolderLabel;

@end

@implementation TTTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

- (UILabel *)placeHolderLabel {
    if (_placeHolderLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        
        [self addSubview:label];
        
        _placeHolderLabel = label;
    }
    return _placeHolderLabel;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.placeHolderLabel.font = font;
    [self.placeHolderLabel sizeToFit];
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = placeHolder;
    
    self.placeHolderLabel.text = placeHolder;
    
    // label的尺寸跟文字一样
    [self.placeHolderLabel sizeToFit];
    
}

- (void)setHidePlaceHolder:(BOOL)hidePlaceHolder {
    _hidePlaceHolder = hidePlaceHolder;
    
    self.placeHolderLabel.hidden = hidePlaceHolder;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.placeHolderLabel.x = 5;
    self.placeHolderLabel.y = 8;
    
}

@end
