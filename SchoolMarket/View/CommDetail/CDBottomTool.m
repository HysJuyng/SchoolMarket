//
//  CDBottomTool.m
//  SchoolMarket
//
//  Created by tb on 16/4/14.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import "CDBottomTool.h"

@implementation CDBottomTool
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        
        // 初始化购买按钮和数量变化按钮
        CGFloat BtnW = frame.size.width * 0.4;
        CGFloat BtnH = frame.size.height * 0.5;
        CGFloat BtnX = (frame.size.width - BtnW) * 0.5;
        CGFloat BtnY = (frame.size.height - BtnH) * 0.5;
        
        [self buyAndChangeNumBtnWithView:self andFrame:CGRectMake(BtnX, BtnY, BtnW, BtnH)];
        
        // 初始化购物车按钮
        CGFloat SCBtnH = frame.size.height;
        CGFloat SCBtnW = SCBtnH;
        CGFloat SCBtnY = frame.size.height - SCBtnH * 1.2;
        
        [self shoppingCartBtnWithView:self andFrame:CGRectMake(10.0, SCBtnY, SCBtnW, SCBtnH)];
    }
    return self;
}

#pragma mark - 底部工具栏
/**  初始化底部工具栏 */
- (UIView *)bottomToolViewWithFrame:(CGRect)frame
{
    if (self.bottomToolView == nil) {
        UIView *bottomToolView = [[UIView alloc] initWithFrame:frame];
        bottomToolView.backgroundColor = [UIColor greenColor];
        
        // 初始化购买按钮和数量变化按钮
        CGFloat BtnW = frame.size.width * 0.4;
        CGFloat BtnH = frame.size.height * 0.5;
        CGFloat BtnX = (frame.size.width - BtnW) * 0.5;
        CGFloat BtnY = (frame.size.height - BtnH) * 0.5;
        
        [self buyAndChangeNumBtnWithView:bottomToolView andFrame:CGRectMake(BtnX, BtnY, BtnW, BtnH)];
        
        // 初始化购物车按钮
        CGFloat SCBtnH = frame.size.height;
        CGFloat SCBtnW = SCBtnH;
        CGFloat SCBtnY = frame.size.height - SCBtnH * 1.2;
        
        [self shoppingCartBtnWithView:bottomToolView andFrame:CGRectMake(10.0, SCBtnY, SCBtnW, SCBtnH)];
        
        self.bottomToolView = bottomToolView;
        [self addSubview:self.bottomToolView];
    }
    return self.bottomToolView;
}

/**  购买按钮和数量变化按钮 */
- (void)buyAndChangeNumBtnWithView:(UIView *)view andFrame:(CGRect)frame
{
    if (self.buyBtn == nil || self.changeNumBtn == nil) {
        // 立即购买按钮
        if (self.buyBtn == nil) {
            UIButton *buyBtn = [[UIButton alloc] initWithFrame:frame];
            
            // 设置标题
            [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
            
            // 监听方法
            [buyBtn addTarget:self.delegate action:@selector(increase) forControlEvents:UIControlEventTouchUpInside];
            
            self.buyBtn = buyBtn;
            [view addSubview:self.buyBtn];
        }
        
        // 数量变化按钮
        if (self.changeNumBtn == nil) {
            UIButton *changeNumBtn = [[UIButton alloc] initWithFrame:frame];
            
            // 设置圆角和背景颜色
            changeNumBtn.layer.cornerRadius = 8.0;
            changeNumBtn.backgroundColor = [UIColor whiteColor];
            
            // 设置标题颜色，同时将按钮隐藏
            [changeNumBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            changeNumBtn.hidden = YES;
            
            // 监听方法
            [self increaseAndDecreaseBtnWithButton:changeNumBtn];
            
            self.changeNumBtn = changeNumBtn;
            [view addSubview:self.changeNumBtn];
        }
    }
}

/**  增加按钮和减少按钮 */
- (void)increaseAndDecreaseBtnWithButton:(UIButton *)btn
{
    if (self.increaseBtn == nil || self.decreaseBtn == nil) {
        CGFloat btnH = btn.frame.size.height;
        CGFloat btnW = btnH;
        CGFloat btnX = btn.frame.size.width - btnW;
        // 增加按钮
        if (self.increaseBtn == nil) {
            UIButton *increaseBtn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, 0, btnW, btnH)];
            // 设置标题文字属性
            [increaseBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            [increaseBtn setTitle:@"+" forState:UIControlStateNormal];
            
            // 监听方法
            [increaseBtn addTarget:self.delegate action:@selector(increase) forControlEvents:UIControlEventTouchUpInside];
            
            self.increaseBtn = increaseBtn;
            [btn addSubview:self.increaseBtn];
        }
        
        // 减少按钮
        if (self.decreaseBtn == nil) {
            UIButton *decreaseBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btnW, btnH)];
            // 设置标题文字属性
            [decreaseBtn setTitle:@"-" forState:UIControlStateNormal];
            [decreaseBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            
            // 监听方法
            [decreaseBtn addTarget:self.delegate action:@selector(decrease) forControlEvents:UIControlEventTouchUpInside];
            
            self.decreaseBtn = decreaseBtn;
            [btn addSubview:self.decreaseBtn];
        }
    }
}

/**  购物车按钮 */
- (void)shoppingCartBtnWithView:(UIView *)view andFrame:(CGRect)frame
{
    UIButton *shoppingCartBtn = [[UIButton alloc] initWithFrame:frame];
    
    // 设置圆角和背景颜色
    shoppingCartBtn.layer.cornerRadius = shoppingCartBtn.frame.size.height * 0.5;
    shoppingCartBtn.backgroundColor = [UIColor whiteColor];
    
    //设置图片
    [shoppingCartBtn setBackgroundImage:[UIImage imageNamed:@"cart_btn"] forState:(UIControlStateNormal)];
    
    // 设置标题文字(购物车商品数量)属性(数量需从网络获取)
    [shoppingCartBtn setTitle:[NSString stringWithFormat:@"%d", self.shoppingCartNum] forState:UIControlStateNormal];
    [shoppingCartBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    shoppingCartBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    shoppingCartBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    shoppingCartBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    
    // 监听方法
    [shoppingCartBtn addTarget:self.delegate action:@selector(shoppingCart) forControlEvents:UIControlEventTouchUpInside];
    
    self.shoppingCartBtn = shoppingCartBtn;
    [view addSubview:self.shoppingCartBtn];
}

@end
