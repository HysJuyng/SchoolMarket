/*
 发送通知的类
 */

#import "NotifitionSender.h"
#import "Commodity.h"

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

@end
