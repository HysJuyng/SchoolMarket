/*
 AFRequest
 */

#import <Foundation/Foundation.h>


//闭包
typedef void (^commResponseBlock)( NSMutableArray * _Nonnull comms);
typedef void (^saleAndSpecialComm)( NSMutableArray * _Nonnull hotComms,NSMutableArray * _Nonnull recommendComms);
typedef void (^OrderBlock)( NSMutableArray * _Nonnull orders);
typedef void (^categoriesResponseBlock)( NSMutableArray * _Nonnull categories);
typedef void (^postBack)( NSString * _Nonnull flag,NSDictionary * _Nullable dic);


@interface AFRequest : NSObject

/**
 *  获取收货地址
 *
 *  @param url          url
 *  @param parameter    参数（用户id 或者 收货地址id）
 *  @param addressBlock 闭包（收货地址数组）
 */
+ (void)getAddresses:(nonnull NSString *)url andParameter:(nullable NSDictionary *)parameter andAddress:(nonnull commResponseBlock)addressBlock;

/**  获取分类信息 */
+ (void)getCategorier:(nonnull NSString *)url andParameter:(nullable NSDictionary *)parameter andCategorierBlock:(nonnull categoriesResponseBlock)categoriesblock;

/**
 *  获取商品信息
 *
 *  @param url       请求地址
 *  @param parameter 参数 
 *  @param commblock 闭包回调 (商品)
 */
+ (void)getComm:(nonnull NSString*)url andParameter:(nullable NSDictionary*)parameter andCommBlock:(nonnull commResponseBlock)commblock;
/**
 *  获取热卖和特价商品
 *
 *  @param url       请求地址
 *  @param parameter 参数 (空)
 *  @param commblock 闭包回调 （热卖和特价数组）
 */
+ (void)getSaleAndSpecialComm:(nonnull NSString*)url andParameter:(nullable NSDictionary*)parameter andCommBlock:(nonnull saleAndSpecialComm)commblock;

//获取图片（数组）地址
- (void)getImgs:(nonnull NSString*)url andParameter:(nullable NSDictionary*)parameter andImgsBlock:(nonnull commResponseBlock)imgsblock;
/**
 *  获取订单
 *
 *  @param url       请求地址
 *  @param parameter 参数 （userid）
 *  @param commblock 闭包回调 （订单）
 */
+ (void)getOrderByUserid:(nonnull NSString*)url andParameter:(nullable NSDictionary*)parameter andBlock:(nonnull OrderBlock)orderblock;

//发送请求
+ (void)postLogin:(nonnull NSString*)url andParameter:(nonnull NSDictionary*)parameter andResponse:(nonnull postBack)postback;

+ (void)posttest;

@end
