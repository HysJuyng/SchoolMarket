/*
 AFRequest
 */

#import "AFRequest.h"

#import "AFNetworking.h"
#import "Commodity.h"
#import "Order.h"
#import "Address.h"
#import "Advert.h"

//#import "Categories.h"

@implementation AFRequest


#pragma mark GET
/**
 *  获取分类信息
 *
 *  @param url             请求地址
 *  @param parameter       请求参数
 *  @param categoriesblock 闭包回调
 */
+ (void)getCategorier:(nonnull NSString *)url andParameter:(nullable NSDictionary *)parameter andCategorierBlock:(nonnull categoriesResponseBlock)categoriesblock andError:(nullable errorBlock)errorblock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        categoriesblock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        errorblock(error);
    }];
}

/**
 *  获取商品信息
 *
 *  @param url       请求地址
 *  @param parameter 参数
 *  @param commblock 闭包回调
 */
+ (void)getComm:(nonnull NSString *)url andParameter:(nullable NSDictionary *)parameter andCommBlock:(nonnull dataResponseBlock)commblock andError:(nullable errorBlock)errorblock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *comms = [[NSMutableArray alloc] init];
        //处理数据
        NSMutableArray *commsArr = responseObject;
        NSLog(@"%@", responseObject);
        //提取数组
        for (NSDictionary *dict in commsArr) {
            [comms addObject:[[Commodity alloc] initWithCommDic:dict ]];
        }
        NSLog(@"%@", responseObject);
        commblock(comms);     //闭包回调处理
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        errorblock(error);
    }];
}
/**
 *  获取热卖和特价商品
 *
 *  @param url       请求地址
 *  @param parameter 参数
 *  @param commblock 闭包回调 （热卖和特价数组）
 */
+ (void)getSaleAndSpecialComm:(nonnull NSString*)url andParameter:(nullable NSDictionary*)parameter andCommBlock:(nonnull saleAndSpecialComm)commblock andError:(nullable errorBlock)errorblock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *hotComms = [[NSMutableArray alloc] init];  //热卖商品
        NSMutableArray *recommendComms = [[NSMutableArray alloc] init];  //特价商品
        //处理数据
        NSMutableArray *commsArr = responseObject;
        NSLog(@"%@", responseObject);
        //提取数组
        for (NSDictionary *dict in (commsArr[0])[@"推荐商品"]) {  //推荐
            [recommendComms addObject:[[Commodity alloc] initWithCommDic:dict ]];
        }
        for (NSDictionary *dict in (commsArr[0])[@"热卖商品"]) {  //热卖
            [hotComms addObject:[[Commodity alloc] initWithCommDic:dict ]];
        }
        commblock(hotComms,recommendComms);     //闭包回调处理(热卖，推荐)
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        errorblock(error);
    }];
}
/**
 *  获取订单
 *
 *  @param url       请求地址
 *  @param parameter 参数 （userid）
 *  @param commblock 闭包回调 （订单）
 */
+ (void)getOrderByUserid:(nonnull NSString*)url andParameter:(nullable NSDictionary*)parameter andBlock:(nonnull OrderBlock)orderblock andError:(nullable errorBlock)errorblock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *orders = [[NSMutableArray alloc] init];  //订单数组
        //处理数据
        NSMutableArray *ordersArr = responseObject;
        NSLog(@"%@", responseObject);
        //提取数组
        for (NSDictionary *dict in ordersArr) {
            [orders addObject:[[Order alloc] initWithDic:dict ]];
        }
        orderblock(orders);     //闭包回调处理(订单数组)
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        errorblock(error);
    }];
}
/**
 *  获取收货地址
 *
 *  @param url          url
 *  @param parameter    参数（用户id 或者 收货地址id）
 *  @param addressBlock 闭包（收货地址数组）
 */
+ (void)getAddresses:(nonnull NSString *)url andParameter:(nullable NSDictionary *)parameter andAddress:(nonnull dataResponseBlock)addressBlock andError:(nullable errorBlock)errorblock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *addresses = [[NSMutableArray alloc] init];  //地址数组
        //处理数据
        NSMutableArray *addressArr = responseObject;
        NSLog(@"%@", responseObject);
        //提取数组
        for (NSDictionary *dict in addressArr) {
            [addresses addObject:[[Address alloc] initWithAddressDic:dict]];
        }

        addressBlock(addresses);     //闭包回调处理(返回地址数组)
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        errorblock(error);
    }];
}
/**
 *  获取广告
 *
 *  @param url            请求地址
 *  @param parameter      参数
 *  @param advertiseBlock 返回
 *  @param errorblock     错误返回
 */
+ (void)getAdvertises:(nonnull NSString *)url andParameter:(nullable NSDictionary *)parameter andAdvertise:(nonnull ResponseBlock)advertiseBlock andError:(nullable errorBlock)errorblock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        NSArray *dics = responseObject;
        NSMutableArray *data = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in dics) {
            Advert *advert = [[Advert alloc] initWitDic:dic];
            [data addObject:advert];
        }
        
        advertiseBlock(data);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        errorblock(error);
    }];
}

#pragma mark POST
/**
 *  发送请求（登录注册）
 *
 *  @param url        请求地址
 *  @param parameter  参数
 *  @param postback   返回
 *  @param errorblock 错误返回
 */
+ (void)postLogin:(nonnull NSString*)url andParameter:(nonnull NSDictionary*)parameter andResponse:(nonnull postBack)postback andError:(nullable errorBlock)errorblock{
    NSLog(@"%@",parameter);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);   //获得数据
        NSDictionary *dic = responseObject;
        NSDictionary *userdic = [[NSDictionary alloc] init];
        NSString *flag = [[NSString alloc] init];
        if ([[dic objectForKey:@"message"]  isEqual:@"passwordError" ]) {
            flag = @"密码错误！";
        } else if ([[dic objectForKey:@"message"]  isEqual:@"userError" ]) {
            flag = @"用户错误！";
        } else if ([[dic objectForKey:@"message"]  isEqual:@"userexist" ]) {
            flag = @"用户存在！";
        } else {
            userdic = [dic objectForKey:@"message"];
        }
        postback(flag,userdic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        errorblock(error);
    }];
}
/**
 *  添加、修改或删除收货地址
 *
 *  @param url       请求地址
 *  @param parameter 参数（收货地址内容）
 *  @param postback  返回
 */
+ (void)postAddress:(nonnull NSString*)url andParameter:(nonnull NSDictionary*)parameter andResponse:(nonnull postBackMessage)postback andError:(nullable errorBlock)errorblock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = responseObject;
        NSString *message = [[NSString alloc] init];
        if ([dic[@"message"] isEqual:@"addSingleAddressError"]) {
            message = @"添加地址失败!";
        } else if ([dic[@"message"] isEqual:@"alterAddressError"]) {
            message = @"修改地址失败!";
        } else if ([dic[@"message"] isEqual:@"deleteAddressError"]) {
            message = @"删除地址失败!";
        } else {
            message = @"success";
        }
        postback(message);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        errorblock(error);
    }];
}
/**
 *  修改用户信息
 *
 *  @param url        请求地址
 *  @param parameter  参数
 *  @param postback   返回
 *  @param errorblock 错误返回
 */
+ (void)postChangeUserMsg:(nonnull NSString*)url andParameter:(nonnull NSDictionary*)parameter andResponse:(nonnull postBackMessage)postback andError:(nullable errorBlock)errorblock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = responseObject;
        NSString *message = dic[@"message"];
        
        postback(message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        errorblock(error);
    }];
}

+ (void)postConfirmOrder:(NSString *)url andParameter:(NSDictionary *)parameter andResponse:(postBackOrder)postback {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置提交的数据为json格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *result = responseObject;
        NSString *resultStr = result[@"message"];
        postback(resultStr);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

+ (void)posttest {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = @"http://schoolserver.nat123.net/SchoolMarketServer/addOrder.jhtml";
    
    
    Order *order = [[Order alloc] init];
    order.address.addressId = 6;
    order.userId = 2;
    order.state = @"进行中";
    order.orderTime = @"2015-10-01";
    order.deliverTime = @"2015-10-02";
    order.freight = @"1.0";
    order.total = @"12";
    order.remarks = @"213dsa";
    
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:[order orderToDictionary:order]];
    NSLog(@"%@",dic);
//    NSArray *arr1 = @[@"123",@"4"];
    NSDictionary *arr1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"123",@"commodityId",@"4",@"commNumber", nil];
    NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:arr1,arr1, nil];
    [dic setObject:arr forKey:@"commListBeans"];
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:dic,@"buyCommBean", nil];
    NSLog(@"===================%@",param);
    [manager POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);   //获得数据
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

@end
