/*
 商品Cell
 
 默认显示：  加按钮   价格
 当商品数量大于0的时候
 价格隐藏 减按钮、数量显示
 
 goodsNum记录选择的商品数量
 */

#import <UIKit/UIKit.h>


@interface CommCell : UICollectionViewCell
{
    @private
    int commNum;
}
@property (weak,nonatomic) UIButton *btnAdd;     //加按钮
@property (weak,nonatomic) UIButton *btnMinus;    //减按钮
@property (weak,nonatomic) UIImageView *commImgv;   //商品图片
@property (weak,nonatomic) UILabel *lbNum;      //商品数量
@property (weak,nonatomic) UILabel *lbPrice;     //商品价格
@property (weak,nonatomic) UILabel *lbName;    //商品名称
@property (weak,nonatomic) UILabel *lbSpecification;    //商品规格

@property int commNum;

- (void)addNum;  //商品数量++
- (void)minusNum; //商品数量--

@end
