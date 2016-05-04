/*
 订单详情页面
 */

#import <UIKit/UIKit.h>

@class Order;

@interface OrderDetailController : UIViewController

/**
 *  订单模型
 */
@property (nonatomic,weak) Order *orderDetail;

@end
