/*
 商品model
 */

#import "Commodity.h"

@implementation Commodity


/** 通过字典初始化模型*/
- (nonnull instancetype)initWithCommDic:(nonnull NSDictionary*)commDic
{
    self = [super init];
    if (self) {
        
        self.selectedNum = 0;
        
        self.commodityId = [commDic[@"commodityId"] intValue];    //商品id
        self.mainclassId = [commDic[@"mainclassId"] intValue];    //主分类id
        self.subclassId = [commDic[@"subclassId"] intValue];        //次分类id
        self.superMarketId = [commDic[@"superMarketId"] intValue];    //超市id
        self.picture = commDic[@"picture"];                           //图片
        self.commName = commDic[@"commName"];                         //商品名称
        self.price = commDic[@"price"];                                //加个
        self.sales = commDic[@"sales"];                               //销量
        self.specification = commDic[@"spercification"];                //规格
        self.describe = commDic[@"describe"];                          //描述
        self.stock = commDic[@"stock"];                            //库存
        self.type = commDic[@"type"];                                //商品类型
        self.discount = [commDic[@"discount"] floatValue];             //折扣
        self.specialTime = commDic[@"specialTime"];                   //折扣时间
        
    }
    return self;
}



@end
