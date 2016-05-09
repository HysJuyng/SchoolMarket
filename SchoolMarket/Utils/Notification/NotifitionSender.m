/*
 发送通知的类
 */

#import "NotifitionSender.h"
#import "Commodity.h"
#import "Address.h"

static NSNotificationCenter *center;

@implementation NotifitionSender

/**
 *  初始化
 */
+ (void)initialize {
    if (!center) {
        center = [NSNotificationCenter defaultCenter];
    }

}

#pragma mark 商品cell
/**
 *  发送修改数量通知
 *  通知名字 “updateSelectedNum”  通知的参数有 商品id 数量 类型 主分类id 次分类id
 *  @param comm 选中的商品
 */
+ (void)updateSelectedNumNotification:(Commodity*)comm {
    //若商品空
    if (!comm) {
        return;
    }
    //通知参数 参数为commid selectedNum  type mainclass subclass
    NSMutableDictionary *notificationDic = [[NSMutableDictionary alloc] initWithDictionary:[comm commToNotifitionDic]];
    
    [center postNotificationName:@"updateSelectedNum" object:self userInfo:notificationDic];
}

/**
 *  发送修改数量通知
 *  通知名字 “updateAllSelectedNum”  通知参数  （商品id，数量，类型，主分类id，次分类id）数组
 *  @param comms 需要改动的所有商品
 */
+ (void)updateAllSelectedNumNotification:(NSArray*)comms {
    //如果商品空
    if (comms.count == 0) {
        return;
    }
    
    NSMutableArray *commArr = [[NSMutableArray alloc] init];
    for (Commodity* comm in comms) {
        NSDictionary *commdic = [comm commToNotifitionDic];
        [commArr addObject:commdic];
    }
    //通知参数  （商品id，数量，类型，主分类id，次分类id）数组
    NSDictionary *notificationDic = [[NSDictionary alloc] initWithObjectsAndKeys:commArr,@"comms", nil];
    
    [center postNotificationName:@"updateAllSelectedNum" object:self userInfo:notificationDic];
}

#pragma mark 收货地址
/**
 *  发送更新地址视图
 */
+ (void)updateAddressList {
    [center postNotificationName:@"updateAddressList" object:self];
}

#pragma mark 个人中心
/**
 *  更新个人中心用户信息视图
 */
+ (void)updateUserMsg {
    [center postNotificationName:@"updateUserMsgCell" object:self];
}
/**
 *  编辑用户名
 *
 *  @param name 用户名
 */
+ (void)changeUserName:(NSString*)name {
    //如果空
    if (!name) {
        return;
    }
    
    //通知参数 用户名
    NSDictionary *notificationDic = [[NSDictionary alloc] initWithObjectsAndKeys:name,@"username", nil];

    [center postNotificationName:@"changeUserName" object:self userInfo:notificationDic];
}
/**
 *  发送用户信息已经修改通知
 */
+ (void)userIsChange {
    [center postNotificationName:@"userIsChange" object:self];
}

@end
