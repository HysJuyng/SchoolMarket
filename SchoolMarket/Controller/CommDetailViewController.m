/*
 商品详情
 */
//  Created by tb on 16/4/6.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import "CommDetailViewController.h"
#import "CommDetail.h"
#import "RootTabBarController.h"

@interface CommDetailViewController () <CommDetailDelegate>

@property (nonatomic, weak) CommDetail *commDetailView;

/** 购买数量 */
@property (nonatomic, assign) int shoppingCartNum;

@end

@implementation CommDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    
    CGFloat commDetailY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat commDetailW = self.view.bounds.size.width;
    CGFloat commDetailH = self.view.bounds.size.height - commDetailY;
    
    [self commDetailViewWithFrame:CGRectMake(0, 0, commDetailW, commDetailH)];
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

#pragma mark - 点击事件
/**  数量变化 */
- (void)changeNumWithBtn:(UIButton *)btn andNum:(int)num
{
    // 获取当前数量
    int currentNum = btn.currentTitle.intValue;
    
    // 改变数量
    currentNum += num;
    self.commDetailView.shoppingCartNum = currentNum;
    
    // 改变按钮标题
    [btn setTitle:[NSString stringWithFormat:@"%d", currentNum] forState:UIControlStateNormal];
}

/**  增加数量 */
- (void)increase
{
    if (self.commDetailView.changeNumBtn.isHidden == YES) {
        self.commDetailView.buyBtn.hidden = YES;
        self.commDetailView.changeNumBtn.hidden = NO;
    }
    // 需要加一个判断库存是否充足的条件
    [self changeNumWithBtn:self.commDetailView.changeNumBtn andNum:1];
    [self changeNumWithBtn:self.commDetailView.shoppingCartBtn andNum:1];
}

/**  减少数量 */
- (void)decrease
{
    if (self.commDetailView.shoppingCartNum > 1) {
        [self changeNumWithBtn:self.commDetailView.changeNumBtn andNum:-1];
        [self changeNumWithBtn:self.commDetailView.shoppingCartBtn andNum:-1];
    } else {
        self.commDetailView.changeNumBtn.hidden = YES;
        self.commDetailView.buyBtn.hidden = NO;
        [self changeNumWithBtn:self.commDetailView.shoppingCartBtn andNum:-1];
        [self changeNumWithBtn:self.commDetailView.changeNumBtn andNum:-1];
    }
}

/**  购物车 */
- (void)shoppingCart
{
    RootTabBarController *vc = [[RootTabBarController alloc] init];
    self.view.window.rootViewController = vc;
    vc.selectedIndex = 2;
}
@end
