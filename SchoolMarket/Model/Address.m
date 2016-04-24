/*
 收货地址model
 */

#import "Address.h"

@implementation Address


//初始化
/**
*  通过字典初始化模型
*
*  @param addressDic 收货地址字典
*/
- (instancetype)initWithAddressDic:(NSDictionary *)addressDic {
    self = [super init];
    if (self) {
        
        self.addressId = [addressDic[@"addressId"] intValue];
        self.userId = [addressDic[@"userId"] intValue];
        self.addressDetail = addressDic[@"addressDetail"];
        self.consignee = addressDic[@"consignee"];
        self.phone = addressDic[@"phone"];
        
    }
    return self;
}

@end
