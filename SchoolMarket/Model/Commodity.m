/*
 商品model
 */

#import "Commodity.h"

@implementation Commodity

@synthesize commodityId;
@synthesize classId;
@synthesize superMarketId;
@synthesize picture;
@synthesize commName;
@synthesize price;
@synthesize sales;
@synthesize specification;
@synthesize describe;
@synthesize stock;



//字典转换为对象
- (Commodity*)dicToObject:(NSDictionary*)commDic {
    Commodity *comm = [[Commodity alloc] init];
    [comm setCommodityId:[[commDic valueForKey:@"commodityId"]intValue]];
    [comm setClassId:[[commDic valueForKey:@"classId"]intValue]];
    [comm setSuperMarketId:[[commDic valueForKey:@"superMarketId"]intValue]];
    [comm setPicture:[commDic valueForKey:@"picture"]];
    [comm setCommName:[commDic valueForKey:@"commName"]];
    [comm setPrice:[[commDic valueForKey:@"price"]floatValue]];
    [comm setSales:[[commDic valueForKey:@"sales"]intValue]];
    [comm setSpecification:[commDic valueForKey:@"spercification"]];
    [comm setDescribe:[commDic valueForKey:@"describes"]];
    [comm setStock:[[commDic valueForKey:@"stock"]intValue]];
    return comm;
}


@end
