/*
 订单model
 */

#import <Foundation/Foundation.h>

@class Address;

@interface Order : NSObject

/**
 *  订单id
 */
@property (nonatomic,assign) int orderId;
/**
 *  收货地址编号
 */
@property (nonatomic,strong) Address *address;
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
/**
 *  订单商品数组
 */
@property (nonatomic,strong) NSMutableArray *comms;


/** 初始化方法 字典转模型*/
- (instancetype)initWithDic:(NSDictionary*)orderDic;

/** 模型转字典*/
- (NSDictionary*)orderToDictionary:(Order*)order;

@end
