/*
 AFRequest
 */

#import <Foundation/Foundation.h>


//闭包
typedef void (^commResponseBlock)( NSMutableArray * _Nonnull comms);
typedef void (^saleAndSpecialComm)( NSMutableArray * _Nonnull hotComms,NSMutableArray * _Nonnull recommendComms);
typedef void (^OrderBlock)( NSMutableArray * _Nonnull orders);
typedef void (^addressResponseBlock)( NSMutableArray * _Nonnull address);
typedef void (^categoriesResponseBlock)( NSMutableArray * _Nonnull categories);
typedef void (^postBack)( NSString * _Nonnull flag,NSDictionary * _Nullable dic);
typedef void (^orderPostBack)(NSString * _Nonnull resultStr);


@interface AFRequest : NSObject

/**
 *  获取收货地址
 *
 *  @param url          url
 *  @param parameter    参数（用户id 或者 收货地址id）
 *  @param addressBlock 闭包（收货地址数组）
 */
+ (void)getAddresses:(nonnull NSString *)url andParameter:(nullable NSDictionary *)parameter andAddress:(nonnull addressResponseBlock)addressBlock;

/**
 *  获取分类信息
 *
 *  @param url             请求地址
 *  @param parameter       请求参数
 *  @param categoriesblock 闭包回调
 */
+ (void)getCategorier:(nonnull NSString *)url andParameter:(nullable NSDictionary *)parameter andCategorierBlock:(nonnull categoriesResponseBlock)categoriesblock;
/**
 *  获取商品信息
 *
 *  @param url       请求地址
 *  @param parameter 参数 
 *  @param commblock 闭包回调 (商品)
 */
+ (void)getComm:(nonnull NSString*)url andParameter:(nullable NSDictionary*)parameter andCommBlock:(nonnull commResponseBlock)commblock andError:(nullable errorBlock)errorblock;
/**
 *  获取热卖和特价商品
 *
 *  @param url       请求地址
 *  @param parameter 参数 (空)
 *  @param commblock 闭包回调 （热卖和特价数组）
 */
+ (void)getSaleAndSpecialComm:(nonnull NSString*)url andParameter:(nullable NSDictionary*)parameter andCommBlock:(nonnull saleAndSpecialComm)commblock andError:(nullable errorBlock)errorblock;

//获取图片（数组）地址
- (void)getImgs:(nonnull NSString*)url andParameter:(nullable NSDictionary*)parameter andImgsBlock:(nonnull commResponseBlock)imgsblock andError:(nullable errorBlock)errorblock;
/**
 *  获取订单
 *
 *  @param url       请求地址
 *  @param parameter 参数 （userid）
 *  @param commblock 闭包回调 （订单）
 */
+ (void)getOrderByUserid:(nonnull NSString*)url andParameter:(nullable NSDictionary*)parameter andBlock:(nonnull OrderBlock)orderblock andError:(nullable errorBlock)errorblock;
/**
 *  添加收货地址
 *
 *  @param url       请求地址
 *  @param parameter 参数（收货地址内容）
 *  @param postback  返回
 *  @param errorblock 错误信息返回
 */
+ (void)postAddress:(nonnull NSString*)url andParameter:(nonnull NSDictionary*)parameter andResponse:(nonnull postBackMessage)postback andError:(nullable errorBlock)errorblock;

//发送请求
+ (void)postLogin:(nonnull NSString*)url andParameter:(nonnull NSDictionary*)parameter andResponse:(nonnull postBack)postback;
/**
 *  发送下单请求
 *
 *  @param url       请求地址
 *  @param parameter 发送对象
 *  @param postback  闭包回调（是否成功下单）
 */
+ (void)postConfirmOrder:(nonnull NSString*)url andParameter:(nonnull NSDictionary*)parameter andResponse:(nonnull orderPostBack)postback;

@end
