/*
 商品model
 */

#import <Foundation/Foundation.h>

@interface Comm : NSObject
{
    @private
    int commId;    //商品id
    int clasId;    //分类id
    int supMarkId;  //超市id
    NSString *picture;  //图片
    NSString *commName;  //商品名称
    float price;   //价格
    int sales;   //销售量
    NSString *specification;   //规格
    NSString *describe;   //描述
    int stock;   //库存
}

@property (nonatomic,assign) int commId;
@property (nonatomic,assign) int clasId;
@property (nonatomic,assign) int supMarkId;
@property (nonatomic,copy) NSString *picture;
@property (nonatomic,copy) NSString *commName;
@property (nonatomic,assign) float price;
@property (nonatomic,assign) int sales;
@property (nonatomic,copy) NSString *specification;
@property (nonatomic,copy) NSString *describe;
@property (nonatomic,assign) int stock;

//初始化


//字典转换为对象
- (Comm*)dicToObject:(NSDictionary*)commDic;

@end
