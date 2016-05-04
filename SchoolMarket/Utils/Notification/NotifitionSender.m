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
    NSMutableDictionary *notificationDic = [[NSMutableDictionary alloc] init];
    [notificationDic setObject:[NSString stringWithFormat:@"%d",comm.commodityId] forKey:@"commid"];
    [notificationDic setObject:[NSString stringWithFormat:@"%d",comm.selectedNum] forKey:@"selectedNum"];
    [notificationDic setObject:comm.type forKey:@"type"];
    [notificationDic setObject:[NSString stringWithFormat:@"%d",comm.mainclassId] forKey:@"mainclassId"];
    [notificationDic setObject:[NSString stringWithFormat:@"%d",comm.subclassId] forKey:@"subclassId"];
    
    [center postNotificationName:@"updateSelectedNum" object:self userInfo:notificationDic];
}


@end
