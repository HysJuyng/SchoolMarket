/*
 商品model
 */

#import <Foundation/Foundation.h>

@interface Commodity : NSObject
{
    @private
    int commodityId;    //商品id
    int classId;    //分类id
    int superMarketId;  //超市id
    NSString *picture;  //图片
    NSString *commName;  //商品名称
    float price;   //价格
    int sales;   //销售量
    NSString *specification;   //规格
    NSString *describe;   //描述
    int stock;   //库存
}

@property (nonatomic,assign) int commodityId;
@property (nonatomic,assign) int classId;
@property (nonatomic,assign) int superMarketId;
@property (nonatomic,copy) NSString *picture;
@property (nonatomic,copy) NSString *commName;
@property (nonatomic,assign) float price;
@property (nonatomic,assign) int sales;
@property (nonatomic,copy) NSString *specification;
@property (nonatomic,copy) NSString *describe;
@property (nonatomic,assign) int stock;

//初始化


//字典转换为对象
- (Commodity*)dicToObject:(NSDictionary*)commDic;

@end
