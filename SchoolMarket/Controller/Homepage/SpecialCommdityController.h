/*
 特价商品
 */

#import <UIKit/UIKit.h>


@interface SpecialCommdityController : UIViewController 


@property (nonatomic,weak) UIButton *shoppingCartBtn;
@property (nonatomic,assign) int shoppingCartNum;

/**  购物车按钮 */
- (void)shoppingCartBtnWithFrame:(CGRect)frame;
/** 购物车点击*/
- (void)shoppingCart;
@end
