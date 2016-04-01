/*
 商品Cell
 */

#import "CommCell.h"

@implementation CommCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //商品数量默认为0
        goodsNum = 0;
        
        //商品图片imageView
        self.commImgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height / 5 * 3)];
        self.commImgv.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.commImgv];
        
        //商品名称
        self.lbName = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height / 5 * 3, self.frame.size.width, self.frame.size.height / 20 * 3)];
        self.lbName.font = [UIFont systemFontOfSize:self.lbName.frame.size.height];
        [self addSubview:self.lbName];
        
        //商品规格
        self.lbSpecification = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height / 4 * 3, self.frame.size.width, self.frame.size.height / 20)];
        self.lbSpecification.font = [UIFont systemFontOfSize:self.lbSpecification.frame.size.height];
        [self addSubview:self.lbSpecification];
        
        //加按钮
        self.btnAdd = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.btnAdd.frame = CGRectMake(self.frame.size.width / 4 * 3, self.frame.size.height / 20 * 17, self.frame.size.width / 4, self.frame.size.width / 4);
//        [self.btnAdd setImage:<#(nullable UIImage *)#> forState:(UIControlStateNormal)];
        self.btnAdd.backgroundColor = [UIColor blueColor];
        [self.btnAdd setTitle:@"+" forState:(UIControlStateNormal)];
        [self addSubview:self.btnAdd];
        
        //减按钮
        self.btnMinus = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.btnMinus.frame = CGRectMake(0, self.frame.size.height / 20 * 17, self.frame.size.width / 4, self.frame.size.width / 4);
//        [self.btnMinus setImage:<#(nullable UIImage *)#> forState:(UIControlStateNormal)];
        self.btnMinus.backgroundColor = [UIColor blueColor];
        [self.btnMinus setTitle:@"-" forState:(UIControlStateNormal)];
        self.btnMinus.hidden = true; //默认隐藏
        [self addSubview:self.btnMinus];
        
        //价格lable
        self.lbPrice = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height / 20 * 17, self.frame.size.width / 2, self.frame.size.width / 4)];
        [self addSubview:self.lbPrice];
        
        //数量lable
        self.lbNum = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width / 4, self.frame.size.height / 20 * 17, self.frame.size.width / 2, self.frame.size.width / 4)];
        self.lbNum.textAlignment = NSTextAlignmentCenter;
        self.lbNum.hidden = true;  //默认隐藏
        [self addSubview:self.lbNum];
    }
    return self;
}

//增加商品数量
- (void)setNum{
    commNum++;
}
//获取商品数量
- (int)getNum{
    return commNum;
}

@end
