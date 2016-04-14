/*
 商品model
 */

#import "Commodity.h"
#import "AFNetworking.h"

@implementation Commodity


/** 通过字典初始化模型*/
- (nonnull instancetype)initWithCommDic:(nonnull NSDictionary*)commDic
{
    self = [super init];
    if (self) {
        
        self.selectedNum = 0;
        
        self.commodityId = [[commDic valueForKey:@"commodityId"]intValue];
        self.classId = [[commDic valueForKey:@"classId"]intValue];
        self.superMarketId = [[commDic valueForKey:@"superMarketId"]intValue];
        self.picture = [commDic valueForKey:@"picture"];
        self.commName = [commDic valueForKey:@"commName"];
        self.price = [commDic valueForKey:@"price"];
        self.sales = [commDic valueForKey:@"sales"];
        self.specification = [commDic valueForKey:@"spercification"];
        self.describe = [commDic valueForKey:@"describes"];
        self.stock = [commDic valueForKey:@"stock"];
    }
    return self;
}


#pragma mark 网络请求
/** 获取商品信息*/
+ (void)getComm:(nonnull NSString*)url andParameter:(nullable NSDictionary*)parameter andCommBlock:(nonnull responseBlock)commblock {
    //创建数组
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *comms = [[NSMutableArray alloc] init];
        NSLog(@"%@",responseObject);   //获得数据
        //处理数据
        NSDictionary *dic = responseObject;
        //提取数组
        NSMutableArray *commsArr = [[NSMutableArray alloc] initWithObjects:dic, nil][0];
        for (int i = 0; i < commsArr.count; i++) {  //遍历字典数组
            Commodity *comm = [[Commodity alloc] initWithCommDic:commsArr[i]];
            [comms addObject:comm];   //添加到结果集
        }
        commblock(comms);     //闭包回调处理
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

@end
