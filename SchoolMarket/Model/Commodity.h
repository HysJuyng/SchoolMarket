/*
 商品model
 */

#import <Foundation/Foundation.h>

//闭包
typedef void (^responseBlock)( NSMutableArray * _Nonnull comms);

@interface Commodity : NSObject

@property (nonatomic,assign) int commodityId;
@property (nonatomic,assign) int classId;
@property (nonatomic,assign) int superMarketId;
@property (nonatomic,copy,nullable) NSString *picture;
@property (nonatomic,copy,nonnull) NSString *commName;
@property (nonatomic,copy,nullable) NSString *price;
@property (nonatomic,copy,nullable) NSString *sales;
@property (nonatomic,copy,nullable) NSString *specification;
@property (nonatomic,copy,nullable) NSString *describe;
@property (nonatomic,copy,nullable) NSString *stock;

@property (nonatomic,assign) int selectedNum;

//初始化
//通过字典初始化模型
- (nonnull instancetype)initWithCommDic:(nonnull NSDictionary*)commDic;


//获取商品信息
+ (void)getComm:(nonnull NSString*)url andParameter:(nullable NSDictionary*)parameter andCommBlock:(nonnull responseBlock)commblock;

@end
