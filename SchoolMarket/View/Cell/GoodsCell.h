/*
 商品Cell
 */

#import <UIKit/UIKit.h>

@interface GoodsCell : UICollectionViewCell

@property (weak,nonatomic) UIButton *btnAdd;     //加按钮
@property (weak,nonatomic) UIButton *btnMinus;    //减按钮
@property (weak,nonatomic) UIImageView *goodsImgv;   //商品图片
@property (weak,nonatomic) UILabel *lbNum;      //商品数量
@property (weak,nonatomic) UILabel *lbValue;     //商品价格


//初始化方法  带frame  superVc
- (instancetype)initWithFrame:(CGRect)frame andSuperVc:(UIViewController*)superVc;

@end
