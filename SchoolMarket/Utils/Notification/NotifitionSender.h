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

@end
