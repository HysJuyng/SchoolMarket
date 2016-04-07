/*
 AFRequest
 */

#import "AFRequest.h"

@implementation AFRequest


#pragma mark GET
//获取商品信息
- (void)getComm:(nonnull NSString*)url andParameter:(nullable NSDictionary*)parameter andCommBlock:(nonnull responseBlock)commblock {
    //创建数组
    NSMutableArray *comms = [[NSMutableArray alloc] init];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);   //获得数据
        //处理数据
        NSDictionary *dic = responseObject;
        NSArray *commsArr = [[NSArray alloc] initWithArray:[dic objectForKey:@"comm"]];   //提取字典数组
        for (int i = 0; i < commsArr.count; i++) {  //遍历字典数组
            Commodity *comm = [[Commodity alloc] init];
            [comm dicToObject:commsArr[i]];   //字典转comm对象
            [comms addObject:comm];   //添加到结果集
        }
        commblock(comms);     //闭包回调处理
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

//获取图片(数组)地址
- (void)getImgs:(nonnull NSString*)url andParameter:(nullable NSDictionary*)parameter andImgsBlock:(nonnull responseBlock)imgsblock {
    //创建数组
    NSMutableArray *imgs = [[NSMutableArray alloc] init];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject); //获得数据
        //处理数据
        NSDictionary *dic = responseObject;
        [imgs setArray:[dic objectForKey:@"imgs"]];
        imgsblock(imgs);   //闭包回调处理
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark POST
//发送请求（登录注册）
//- (void)postLogin:(nonnull NSString*)url andParameter:(nonnull NSDictionary*)parameter andResponse:(nonnull responseBlock)responseblock {
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);   //获得数据
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//    }];
//}

@end
