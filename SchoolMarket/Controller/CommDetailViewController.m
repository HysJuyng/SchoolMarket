//
//  CommDetailViewController.m
//  SchoolMarket
//
//  Created by tb on 16/4/6.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import "CommDetailViewController.h"
#import "CommDetail.h"

@interface CommDetailViewController ()

@property (nonatomic, weak) UIView *commDetailView;

@end

@implementation CommDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    
    CGFloat commDetailY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat commDetailW = self.view.bounds.size.width;
    CGFloat commDetailH = self.view.bounds.size.height - commDetailY;
    
    [self commDetailViewWithFrame:CGRectMake(0, commDetailY, commDetailW, commDetailH)];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (UIView *)commDetailViewWithFrame:(CGRect)frame
{
    if (self.commDetailView == nil) {
        CommDetail *commDetailView = [[CommDetail alloc] initWithFrame:frame];
        self.commDetailView = commDetailView;
        [self.view addSubview:self.commDetailView];
    }
    return self.commDetailView;
}

@end
