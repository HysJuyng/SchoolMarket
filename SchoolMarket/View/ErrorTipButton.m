//
//  ErrorTipButton.m
//  SchoolMarket
//
//  Created by tb on 16/5/10.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import "ErrorTipButton.h"

@implementation ErrorTipButton
- (instancetype)init {
    self = [super init];
    if (self) {
        self.enabled = NO;
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        [self setTitle:@"网络错误" forState:UIControlStateNormal];
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        [self sizeToFit];
        CGRect frame = self.frame;
        frame.size.height += 40.0;
        frame.size.width *= 1.6;
        self.frame = frame;
        [self setImage:[UIImage imageNamed:@"error"] forState:UIControlStateNormal];
        self.titleEdgeInsets = UIEdgeInsetsMake(5.0, -self.imageView.frame.size.width, 0, 0);
        self.imageEdgeInsets = UIEdgeInsetsMake(CGRectGetMaxY(self.titleLabel.frame), 0, 0, -self.titleLabel.intrinsicContentSize.width);
        self.layer.cornerRadius = self.frame.size.height * 0.2;
    }
    return self;
}

@end
