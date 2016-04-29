/*
 订单model
 */

#import "Order.h"

@implementation Order


/** 初始化方法 字典转模型*/
- (instancetype)initWithDic:(NSDictionary*)orderDic
{
    self = [super init];
    if (self) {
        
        self.orderId = [orderDic[@"orderId"] intValue];
        self.addressId = [orderDic[@"addressId"] intValue];
        self.userId = [orderDic[@"userId"] intValue];
        self.orderTime = orderDic[@"orderTime"];
        self.deliverTime = orderDic[@"deliverTime"];
        self.freight = orderDic[@"freight"];
        self.total = orderDic[@"total"];
        self.remarks = orderDic[@"remarks"];
        
        //加个判断状态的
//        self.state = orderDic[@"state"];
        
    }
    return self;
}


@end
