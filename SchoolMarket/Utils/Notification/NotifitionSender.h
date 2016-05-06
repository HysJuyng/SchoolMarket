/*
 发送通知的类
 */

#import <Foundation/Foundation.h>
@class Commodity;

@interface NotifitionSender : NSObject

/**
 *  发送修改数量通知
 *  通知名字 “updateSelectedNum”  通知的参数有 商品id 数量 类型 主分类id 次分类id
 *  @param comm 选中的商品
 */
+ (void)updateSelectedNumNotification:(Commodity*)comm;
/**
 *  发送修改数量通知
 *  通知名字 “updateAllSelectedNum”  通知参数  （商品id，数量，类型，主分类id，次分类id）数组
 *  @param comms 需要改动的所有商品
 */
+ (void)updateAllSelectedNumNotification:(NSArray*)comms;
@end
