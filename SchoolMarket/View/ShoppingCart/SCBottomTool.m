//
//  BottomTool.m
//  SchoolMarket
//
//  Created by tb on 16/4/9.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import "SCBottomTool.h"

@implementation SCBottomTool
/**  初始化底部工具栏 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        
        // 结算按钮
        CGFloat payW = frame.size.width * 0.3;
        CGFloat payX = frame.size.width - payW;
        
        UIButton *pay = [[UIButton alloc] initWithFrame:CGRectMake(payX, 0, payW, frame.size.height)];
        pay.backgroundColor = [UIColor colorWithRed:10.0/255.0 green:200.0/255.0 blue:150.0/255.0 alpha:1.0];
        
        [pay setTitle:@"结算" forState:UIControlStateNormal];
        
        // 监听方法，跳转到确认订单页面
        [pay addTarget:self.delegate action:@selector(goToConfirmOrder) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:pay];
        
        
        // 继续选购按钮
        CGFloat cSelectW = payW * 0.7;
        CGFloat cSelectX = payX - cSelectW;
        
        UIButton *continueSelect = [[UIButton alloc] initWithFrame:CGRectMake(cSelectX, 0, cSelectW, frame.size.height)];
        // 设置文字各项属性
        [continueSelect setTitle:@"继续选购" forState:UIControlStateNormal];
        continueSelect.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        continueSelect.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [continueSelect setTitleColor:[UIColor colorWithRed:10.0/255.0 green:200.0/255.0 blue:150.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        // 监听方法，跳转到超市页面
        [continueSelect addTarget:self.delegate action:@selector(goToSuperMarket) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:continueSelect];
        
        
        // 合计
        CGFloat sumW = frame.size.width * 0.15;
        UILabel *sum = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, sumW, frame.size.height)];
        sum.text = @"合计";
        sum.textAlignment = NSTextAlignmentCenter;
        [self addSubview:sum];
        
        
        // 总价
        if (self.sumPriceLbl == nil) {
            CGFloat sumPriceX = CGRectGetMaxX(sum.frame);
            CGFloat sumPriceW = CGRectGetMinX(continueSelect.frame) - sumPriceX;
            
            UILabel *sumPriceLbl = [[UILabel alloc] initWithFrame:CGRectMake(sumPriceX, 0, sumPriceW, frame.size.height)];
            sumPriceLbl.textColor = [UIColor redColor];
            
            self.sumPriceLbl = sumPriceLbl;
            [self addSubview:self.sumPriceLbl];
        }
    }
    return self;
}


@end
