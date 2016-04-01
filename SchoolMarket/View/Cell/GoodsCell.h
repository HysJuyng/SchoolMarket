/*
 商品Cell
 
 默认显示：  加按钮   价格
 当商品数量大于0的时候
 价格隐藏 减按钮、数量显示
 
 */

#import <UIKit/UIKit.h>


@interface GoodsCell : UICollectionViewCell
{
    @private
    int goodsNum;
}
@property (weak,nonatomic) UIButton *btnAdd;     //加按钮
@property (weak,nonatomic) UIButton *btnMinus;    //减按钮
@property (strong,nonatomic) UIImageView *goodsImgv;   //商品图片
@property (strong,nonatomic) UILabel *lbNum;      //商品数量
@property (strong,nonatomic) UILabel *lbValue;     //商品价格


- (void)setNum;
- (int)getNum;

@end
