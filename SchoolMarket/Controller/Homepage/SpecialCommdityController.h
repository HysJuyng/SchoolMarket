/*
 特价商品
 */

#import <UIKit/UIKit.h>
#import "SpecialCommCell.h"

@protocol SpecialCommdityControllerDelegate <NSObject>

- (void)goToShopcart;

@end


@interface SpecialCommdityController : UIViewController <UITableViewDataSource,UITableViewDelegate,SCCAddAndMinusViewDelegate>


@property (nonatomic,weak) UIButton *shoppingCartBtn;
@property (nonatomic,assign) int shoppingCartNum;

@property (nonatomic,assign) id<SpecialCommdityControllerDelegate> delegate;

/**  购物车按钮 */
- (void)shoppingCartBtnWithFrame:(CGRect)frame;
/** 购物车点击*/
- (void)shoppingCart;
@end
