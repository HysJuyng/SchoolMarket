//
//  ShoppingCart.m
//  SchoolMarket
//
//  Created by tb on 16/4/8.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import "ShoppingCart.h"

@implementation ShoppingCart
/**  初始化空购物车的视图 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 图片
        UIImageView *pic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height * 0.8)];
        pic.backgroundColor = [UIColor cyanColor];
        [self addSubview:pic];
        
        // 文字提示
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, pic.frame.size.height, frame.size.width, frame.size.height * 0.1)];
        tipLabel.text = @"购物车还没有东西喔^_^";
        tipLabel.font = [UIFont systemFontOfSize:20.0f];
        tipLabel.textColor = [UIColor grayColor];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:tipLabel];
        
        // 去超市页面的按钮
        CGFloat btnW = frame.size.width * 0.6;
        CGFloat btnH = (frame.size.height - CGRectGetMaxY(tipLabel.frame)) * 0.9;
        CGFloat btnX = (frame.size.width - btnW) * 0.5;
        CGFloat btnY = CGRectGetMaxY(tipLabel.frame) + btnH * 0.25;
        UIButton *toSMBtn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
        
        // 设置圆角
        toSMBtn.layer.cornerRadius = toSMBtn.frame.size.height * 0.2;
        
        // 设置标题属性
        [toSMBtn setTitle:@"去逛逛" forState:UIControlStateNormal];
        toSMBtn.titleLabel.font = tipLabel.font;
        toSMBtn.backgroundColor = [UIColor greenColor];
        
        // 监听方法
        [toSMBtn addTarget:shoppingCartVC action:@selector(goToSuperMarket) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:toSMBtn];
    }
    return self;
}

@end
