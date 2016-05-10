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
        self.defaultAddress = [addressDic[@"defaultedAddress"] intValue];
        
    }
    return self;
}

/**
 *  模型转字典 (用于添加和修改地址请求)
 */
- (NSMutableDictionary*)addressToDic:(int)isAdd {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    //判断是否是添加
    if (isAdd) {
        [dic setObject:[NSString stringWithFormat:@"%d",self.userId] forKey:@"userId"];
    } else {
        [dic setObject:[NSString stringWithFormat:@"%d",self.addressId] forKey:@"addressId"];
    }
    
    
    [dic setObject:self.addressDetail forKey:@"addressDetail"];
    [dic setObject:self.consignee forKey:@"consignee"];
    [dic setObject:self.phone forKey:@"phone"];
    [dic setObject:[NSString stringWithFormat:@"%d",self.defaultAddress] forKey:@"defaultedAddress"];
    
    return dic;
}

@end
