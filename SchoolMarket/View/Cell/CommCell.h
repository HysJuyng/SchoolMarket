/*
 商品Cell
 
 默认显示：  加按钮   价格
 当商品数量大于0的时候
 价格隐藏 减按钮、数量显示
 
 goodsNum记录选择的商品数量
 */

#import <UIKit/UIKit.h>

@class Commodity;

@interface CommCell : UICollectionViewCell
@property (weak,nonatomic) UIButton *btnAdd;     //加按钮
@property (weak,nonatomic) UIButton *btnMinus;    //减按钮
@property (weak,nonatomic) UIImageView *commImgv;   //商品图片
@property (weak,nonatomic) UILabel *lbNum;      //商品数量
@property (weak,nonatomic) UILabel *lbPrice;     //商品价格
@property (weak,nonatomic) UILabel *lbName;    //商品名称
@property (weak,nonatomic) UILabel *lbSpecification;    //商品规格


//设置选择的商品数量
- (void)setSelectedNum:(NSString*)num;

//设置商品内容
- (void)setCommCell:(Commodity*)commodity;

@end
