/*
 商品Cell
 */

#import "GoodsCell.h"

@implementation GoodsCell


- (instancetype)initWithFrame:(CGRect)frame andSuperVc:(UIViewController*)superVc
{
    self = [super initWithFrame:frame];
    if (self) {
        self.goodsImgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 4 * 3, self.frame.size.height / 4 * 3)];
        [self addSubview:self.goodsImgv];
        
    }
    return self;
}

@end
