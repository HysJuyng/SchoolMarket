/*
 AFRequest
 */

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Model.h"


typedef void (^responseBlock)( NSMutableArray * _Nonnull responseArr);

@interface AFRequest : NSObject




//获取商品信息
- (void)getComm:(nonnull NSString*)url andParameter:(nullable NSDictionary*)parameter andCommBlock:(nonnull responseBlock)commblock;

//获取图片（数组）地址
- (void)getImgs:(nonnull NSString*)url andParameter:(nullable NSDictionary*)parameter andImgsBlock:(nonnull responseBlock)imgsblock;

@end
