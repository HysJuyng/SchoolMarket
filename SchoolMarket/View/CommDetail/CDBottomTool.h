//
//  CDBottomTool.h
//  SchoolMarket
//
//  Created by tb on 16/4/14.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Commodity.h"

@protocol CDBottomToolDelegate <NSObject>

@required
/**  数量变化 */
- (void)changeNumWithBtn:(UIButton *)btn andNum:(int)num;
/**  增加数量 */
- (void)increase;
/**  减少数量 */
- (void)decrease;
/**  转向购物车 */
- (void)shoppingCart;

@end

@interface CDBottomTool : UIView

@property (nonatomic, weak) id<CDBottomToolDelegate> delegate;

/**  底部工具栏 */
@property (nonatomic, weak) UIView *bottomToolView;
/**  购买按钮 */
@property (nonatomic, weak) UIButton *buyBtn;
/**  数量变化按钮 */
@property (nonatomic, weak) UIButton *changeNumBtn;
/**  增加按钮 */
@property (nonatomic, weak) UIButton *increaseBtn;
/**  减少按钮 */
@property (nonatomic, weak) UIButton *decreaseBtn;
/**  购物车按钮 */
@property (nonatomic, weak) UIButton *shoppingCartBtn;

/**  商品对象 */
@property (nonatomic, strong) Commodity *comm;

/** 购买数量 */
@property (nonatomic, assign) int shoppingCartNum;

@end
