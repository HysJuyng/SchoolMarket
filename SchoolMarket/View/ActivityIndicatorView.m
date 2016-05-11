//
//  ActivityIndicatorView.m
//  SchoolMarket
//
//  Created by tb on 16/5/9.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import "ActivityIndicatorView.h"

@implementation ActivityIndicatorView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        CGRect frame = activityView.frame;
        frame.size.width *= 1.3;
        frame.size.height *= 1.3;
        activityView.frame = frame;
        activityView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        activityView.layer.cornerRadius = activityView.frame.size.height * 0.2;
        activityView.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
        [self addSubview:activityView];
        [activityView startAnimating];
        if ([activityView isAnimating]) {
            NSLog(@"%s", __func__);
        }
    }
    return self;
}

@end
