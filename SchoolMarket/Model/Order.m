/*
 订单model
 */

#import "Order.h"
#import "Address.h"

@implementation Order


/** 初始化方法 字典转模型*/
- (instancetype)initWithDic:(NSDictionary*)orderDic
{
    self = [super init];
    if (self) {
        
        self.orderId = [orderDic[@"orderId"] intValue];
        self.orderTime = orderDic[@"orderTime"];
        self.deliverTime = orderDic[@"deliverTime"];
        self.freight = orderDic[@"freight"];
        self.total = orderDic[@"total"];
        self.remarks = orderDic[@"remarks"];
        //状态
        if ([orderDic[@"state"] intValue] == 0) {
            self.state = @"进行中";
        } else {
            self.state = @"已完成";
        }
        //收货地址
        self.address = [[Address alloc] initWithAddressDic:orderDic[@"addressBean"]];

    }
    return self;
}

/** 模型转字典*/
- (NSDictionary*)orderToDictionary:(Order*)order {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:[NSString stringWithFormat:@"%d",self.address.addressId] forKey:@"addressId"];
    [dic setObject:[NSString stringWithFormat:@"%d",self.userId] forKey:@"userId"];
    
    [dic setObject:self.orderTime forKey:@"orderTime"];
    [dic setObject:self.deliverTime forKey:@"deliverTime"];
    [dic setObject:self.freight forKey:@"freight"];
    [dic setObject:self.total forKey:@"total"];
    [dic setObject:self.remarks forKey:@"remarks"];
    
    return dic;
}


@end
