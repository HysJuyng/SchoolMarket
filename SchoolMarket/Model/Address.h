/*
 收货地址model
 */

#import <Foundation/Foundation.h>

@interface Address : NSObject 


/**
 *  收货地址编号
 */
@property (nonatomic,assign) int addressId;
/**
 *  用户id
 */
@property (nonatomic,assign) int userId;
/**
 *  详细地址
 */
@property (nonatomic,copy) NSString *addressDetail;
/**
 *  收件人
 */
@property (nonatomic,copy) NSString *consignee;
/**
 *  电话号码
 */
@property (nonatomic,copy) NSString *phone;
/**
 *  默认地址
 */
@property (nonatomic,assign) int defaultAddress;


//初始化
/**
 *  通过字典初始化模型
 *
 *  @param addressDic 收货地址字典
 */
- (instancetype)initWithAddressDic:(NSDictionary*)addressDic;
/**
 *  模型转字典
 */
- (NSMutableDictionary*)addressToDic:(int)isAdd;

@end
