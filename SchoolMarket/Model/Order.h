/*
 订单model
 */

#import <Foundation/Foundation.h>

@interface Order : NSObject

/**
 *  订单id
 */
@property (nonatomic,assign) int orderId;
/**
 *  收货地址编号
 */
@property (nonatomic,assign) int addressId;
/**
 *  用户id
 */
@property (nonatomic,assign) int userId;
/**
 *  状态
 */
@property (nonatomic,copy) NSString *state;
/**
 *  下单时间
 */
@property (nonatomic,copy) NSString *orderTime;
/**
 *  配送时间
 */
@property (nonatomic,copy) NSString *deliverTime;
/**
 *  运费
 */
@property (nonatomic,copy) NSString *freight;
/**
 *  总额
 */
@property (nonatomic,copy) NSString *total;
/**
 *  备注
 */
@property (nonatomic,copy) NSString *remarks;


/** 初始化方法 字典转模型*/
- (instancetype)initWithDic:(NSDictionary*)orderDic;

@end
