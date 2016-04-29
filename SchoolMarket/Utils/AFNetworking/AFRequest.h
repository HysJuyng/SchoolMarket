/*
 AFRequest
 */

#import <Foundation/Foundation.h>


//闭包
typedef void (^commResponseBlock)( NSMutableArray * _Nonnull comms);
typedef void (^categoriesResponseBlock)( NSMutableArray * _Nonnull categories);
typedef void (^postBack)( NSString * _Nonnull flag);


@interface AFRequest : NSObject

/**  获取分类信息 */
+ (void)getCategorier:(nonnull NSString *)url andParameter:(nullable NSDictionary *)parameter andCategorierBlock:(nonnull categoriesResponseBlock)categoriesblock;

//获取商品信息
+ (void)getComm:(nonnull NSString*)url andParameter:(nullable NSDictionary*)parameter andCommBlock:(nonnull commResponseBlock)commblock;

//获取图片（数组）地址
- (void)getImgs:(nonnull NSString*)url andParameter:(nullable NSDictionary*)parameter andImgsBlock:(nonnull commResponseBlock)imgsblock;

//发送请求

+ (void)postLogin:(nonnull NSString*)url andParameter:(nonnull NSDictionary*)parameter andResponse:(nonnull postBack)postback;

@end
