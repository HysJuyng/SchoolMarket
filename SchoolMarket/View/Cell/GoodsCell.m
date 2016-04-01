/*
 商品Cell
 */

#import "GoodsCell.h"

@implementation GoodsCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //商品数量默认为0
        goodsNum = 0;
        
        //商品图片imageView
        self.goodsImgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height / 4 * 3)];
        self.goodsImgv.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.goodsImgv];
        
        //加按钮
        self.btnAdd = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.btnAdd.frame = CGRectMake(self.frame.size.width / 4 * 3, self.frame.size.height / 4 * 3, self.frame.size.width / 4, self.frame.size.height / 4);
//        [self.btnAdd setImage:<#(nullable UIImage *)#> forState:(UIControlStateNormal)];
        self.btnAdd.backgroundColor = [UIColor blueColor];
        [self.btnAdd setTitle:@"+" forState:(UIControlStateNormal)];
        [self addSubview:self.btnAdd];
        
        //减按钮
        self.btnMinus = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.btnMinus.frame = CGRectMake(0, self.frame.size.height / 4 * 3, self.frame.size.width / 4, self.frame.size.height / 4);
//        [self.btnMinus setImage:<#(nullable UIImage *)#> forState:(UIControlStateNormal)];
        self.btnMinus.backgroundColor = [UIColor blueColor];
        [self.btnMinus setTitle:@"-" forState:(UIControlStateNormal)];
        self.btnMinus.hidden = true; //默认隐藏
        [self addSubview:self.btnMinus];
        
        //价格lable
        self.lbValue = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height / 4 * 3, self.frame.size.width / 2, self.frame.size.height / 4)];
        [self addSubview:self.lbValue];
        
        //数量lable
        self.lbNum = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width / 4, self.frame.size.height / 4 * 3, self.frame.size.width / 2, self.frame.size.height / 4)];
        self.lbNum.textAlignment = NSTextAlignmentCenter;
        self.lbNum.hidden = true;  //默认隐藏
        [self addSubview:self.lbNum];
    }
    return self;
}

//增加商品数量
- (void)setNum{
    goodsNum++;
}
//获取商品数量
- (int)getNum{
    return goodsNum;
}

@end
