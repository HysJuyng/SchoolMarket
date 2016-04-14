/*
 AFRequest
 */

#import "AFRequest.h"

@implementation AFRequest


#pragma mark GET
////获取商品信息
//- (void)getComm:(nonnull NSString*)url andParameter:(nullable NSDictionary*)parameter andCommBlock:(nonnull responseBlock)commblock {
//    //创建数组
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSMutableArray *comms = [[NSMutableArray alloc] init];
//        NSLog(@"%@",responseObject);   //获得数据
//        //处理数据
//        NSDictionary *dic = responseObject;
//        //提取数组
//        NSMutableArray *commsArr = [[NSMutableArray alloc] initWithObjects:dic, nil][0];
//        for (int i = 0; i < commsArr.count; i++) {  //遍历字典数组
//            Commodity *comm = [[Commodity alloc] init];
//            comm = [comm dicToObject:commsArr[i]];   //字典转comm对象
//            [comms addObject:comm];   //添加到结果集
//        }
//        commblock(comms);     //闭包回调处理
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//    }];
//}


#pragma mark POST
//发送请求（登录注册）
- (void)postLogin:(nonnull NSString*)url andParameter:(nonnull NSDictionary*)parameter andResponse:(nonnull postBack)postback {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);   //获得数据
        NSString *flag = (NSString *)responseObject;
        postback(flag);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

@end
