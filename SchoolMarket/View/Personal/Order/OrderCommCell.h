/*
 订单商品cell
 */
#import <UIKit/UIKit.h>

@class Commodity;

@interface OrderCommCell : UICollectionViewCell

@property (weak,nonatomic) UIImageView *commImgv;   //商品图片
@property (weak,nonatomic) UILabel *lbNum;      //商品数量
@property (weak,nonatomic) UILabel *lbPrice;     //商品价格
@property (weak,nonatomic) UILabel *lbName;    //商品名称
@property (weak,nonatomic) UILabel *lbSpecification;    //商品规格

//设置商品内容
- (void)setCommCell:(Commodity*)commodity;

@end
