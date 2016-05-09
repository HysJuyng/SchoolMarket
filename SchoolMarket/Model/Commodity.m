/*
 商品model
 */

#import "Commodity.h"

@implementation Commodity


/** 通过字典初始化模型*/
- (nonnull instancetype)initWithCommDic:(nonnull NSDictionary*)commDic
{
    self = [super init];
    if (self) {
        
        if (!commDic[@"selectedNum"]) {
            self.selectedNum = 0;
        } else {
            self.selectedNum = [commDic[@"selectedNum"] intValue];
        }
        
        self.commodityId = [commDic[@"commodityId"] intValue];    //商品id
        self.mainclassId = [commDic[@"mainclassId"] intValue];    //主分类id
        self.subclassId = [commDic[@"subclassId"] intValue];        //次分类id
        self.superMarketId = [commDic[@"superMarketId"] intValue];    //超市id
        self.picture = commDic[@"picture"];                           //图片
        self.commName = commDic[@"commName"];                         //商品名称
        self.price = commDic[@"price"];                                //加个
        self.sales = commDic[@"sales"];                               //销量
        self.specification = commDic[@"spercification"];                //规格
        self.describe = commDic[@"describe"];                          //描述
        self.stock = commDic[@"stock"];                            //库存
        self.type = commDic[@"type"];                                //商品类型
        self.discount = [commDic[@"discount"] floatValue];             //折扣
        self.specialTime = commDic[@"specialTime"];                   //折扣时间
        
        if ([commDic objectForKey:@"orderNumber"]) {
            self.orderNumber = [commDic[@"orderNumber"] intValue];
        }
        
    }
    return self;
}

/** 模型转字典*/
- (nonnull NSDictionary*)commToDictionary:(nonnull Commodity*)comm {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:[NSString stringWithFormat:@"%d",self.commodityId] forKey:@"commodityId"];
    [dic setObject:[NSString stringWithFormat:@"%d",self.mainclassId] forKey:@"mainclassId"];
    [dic setObject:[NSString stringWithFormat:@"%d",self.subclassId] forKey:@"subclassId"];
    [dic setObject:[NSString stringWithFormat:@"%d",self.superMarketId] forKey:@"superMarketId"];
    [dic setObject:self.picture forKey:@"picture"];
    [dic setObject:self.commName forKey:@"commName"];
    [dic setObject:self.price forKey:@"price"];
    [dic setObject:self.sales forKey:@"sales"];
    [dic setObject:self.specification forKey:@"spercification"];
    [dic setObject:self.stock forKey:@"stock"];
    [dic setObject:self.type forKey:@"type"];
    [dic setObject:[NSString stringWithFormat:@"%0.1f",self.discount] forKey:@"discount"];
    [dic setObject:self.specialTime forKey:@"specialTime"];

    [dic setObject:[NSString stringWithFormat:@"%d",self.selectedNum] forKey:@"selectedNum"];
    
    return dic;
    
}

/** 模型转通知字典*/
- (nonnull NSDictionary*)commToNotifitionDic {
    
    NSMutableDictionary *notificationDic = [[NSMutableDictionary alloc] init];
    [notificationDic setObject:[NSString stringWithFormat:@"%d",self.commodityId] forKey:@"commodityId"];
    [notificationDic setObject:[NSString stringWithFormat:@"%d",self.selectedNum] forKey:@"selectedNum"];
    [notificationDic setObject:self.type forKey:@"type"];
    [notificationDic setObject:[NSString stringWithFormat:@"%d",self.mainclassId] forKey:@"mainclassId"];
    [notificationDic setObject:[NSString stringWithFormat:@"%d",self.subclassId] forKey:@"subclassId"];
    [notificationDic setObject:self.stock forKey:@"stock"];
    
    return notificationDic;
}


@end
