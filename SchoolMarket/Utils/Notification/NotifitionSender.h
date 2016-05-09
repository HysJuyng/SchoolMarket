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

/**
 *  发送更新地址视图
 */
+ (void)updateAddressList;

/**
 *  更新个人中心用户信息视图
 */
+ (void)updateUserMsg;

/**
 *  编辑用户名
 *
 *  @param name 用户名
 */
+ (void)changeUserName:(NSString*)name;

/**
 *  发送用户信息已经修改通知
 */
+ (void)userIsChange;
@end
