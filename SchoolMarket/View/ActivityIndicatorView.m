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
    self = [super initWithFrame:CGRectMake(0, 0, frame.size.height * 0.2, frame.size.height * 0.2)];
    self.center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
    self.layer.cornerRadius = self.frame.size.height * 0.2;
    if (self) {
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        [self addSubview:activityView];
        [activityView startAnimating];
    }
    return self;
}

@end
