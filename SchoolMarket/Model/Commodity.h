/*
 商品model
 */

#import <Foundation/Foundation.h>



@interface Commodity : NSObject 


/**
 *  商品id
 */
@property (nonatomic,assign) int commodityId;
/**
 *  主分类id
 */
@property (nonatomic,assign) int mainclassId;
/**
 *  次分类id
 */
@property (nonatomic,assign) int subclassId;
/**
 *  超市id
 */
@property (nonatomic,assign) int superMarketId;
/**
 *  图片
 */
@property (nonatomic,copy,nullable) NSString *picture;
/**
 *  商品名称
 */
@property (nonatomic,copy,nonnull) NSString *commName;
/**
 *  价格
 */
@property (nonatomic,copy,nullable) NSString *price;
/**
 *  销量
 */
@property (nonatomic,copy,nullable) NSString *sales;
/**
 *  规格
 */
@property (nonatomic,copy,nullable) NSString *specification;
/**
 *  描述
 */
@property (nonatomic,copy,nullable) NSString *describe;
/**
 *  库存
 */
@property (nonatomic,copy,nullable) NSString *stock;
/**
 *  商品类型
 */
@property (nonatomic,copy,nullable) NSString *type;
/**
 *  折扣
 */
@property (nonatomic,assign) float discount;
/**
 *  折扣时间
 */
@property (nonatomic,copy,nullable) NSDate *specialTime;




//选择的数量
@property (nonatomic,assign) int selectedNum;
//订单上数量
@property (nonatomic,assign) int orderNumber;

//初始化
//通过字典初始化模型
- (nonnull instancetype)initWithCommDic:(nonnull NSDictionary*)commDic;
// 模型转字典
- (nonnull NSDictionary*)commToDictionary:(nonnull Commodity*)comm;
/**
 *  模型转通知字典
 *
 *  @param comm 商品模型
 *
 *  @return 通知字典
 */
- (nonnull NSDictionary*)commToNotifitionDic;

@end
