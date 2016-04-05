/*
 商品model
 */

#import "Comm.h"

@implementation Comm

//getter setter
@synthesize commId;
@synthesize clasId;
@synthesize supMarkId;
@synthesize picture;
@synthesize commName;
@synthesize price;
@synthesize sales;
@synthesize specification;
@synthesize describe;
@synthesize stock;



//字典转换为对象
- (Comm*)dicToObject:(NSDictionary*)commDic {
    Comm *comm = [[Comm alloc] init];
    [comm setCommId:[[commDic valueForKey:@"commId"]intValue]];
    [comm setClasId:[[commDic valueForKey:@"clasId"]intValue]];
    [comm setSupMarkId:[[commDic valueForKey:@"supMarkId"]intValue]];
    [comm setPicture:[commDic valueForKey:@"picture"]];
    [comm setCommName:[commDic valueForKey:@"commName"]];
    [comm setPrice:[[commDic valueForKey:@"price"]floatValue]];
    [comm setSales:[[commDic valueForKey:@"sales"]intValue]];
    [comm setSpecification:[commDic valueForKey:@"specification"]];
    [comm setDescribe:[commDic valueForKey:@"describe"]];
    [comm setStock:[[commDic valueForKey:@"stock"]intValue]];
    return comm;
}

@end
