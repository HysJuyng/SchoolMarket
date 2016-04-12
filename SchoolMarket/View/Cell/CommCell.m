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
        self->commNum = 0;
        
        //商品图片imageView
        UIImageView *tempimgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height / 5 * 3)];
        self.commImgv = tempimgv;
        self.commImgv.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.commImgv];
        
        //商品名称
        UILabel *tempName = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height / 5 * 3, self.frame.size.width, self.frame.size.height / 20 * 2)];
        self.lbName = tempName;
        self.lbName.font = [UIFont systemFontOfSize:self.lbName.frame.size.height];
        [self addSubview:self.lbName];
        
        //商品规格
        UILabel *tempSpecification = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height / 10 * 7, self.frame.size.width, self.frame.size.height / 20 * 2)];
        self.lbSpecification = tempSpecification;
        self.lbSpecification.font = [UIFont systemFontOfSize:self.lbSpecification.frame.size.height - 3];
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
        UILabel *tempPrice = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height / 20 * 17, self.frame.size.width / 2, self.frame.size.width / 4)];
        self.lbPrice = tempPrice;
        self.lbPrice.font = [UIFont systemFontOfSize:self.lbPrice.frame.size.height / 2];
        [self addSubview:self.lbPrice];
        
        //数量lable
        UILabel *tempNum = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width / 4, self.frame.size.height / 20 * 17, self.frame.size.width / 2, self.frame.size.width / 4)];
        self.lbNum = tempNum;
        self.lbNum.textAlignment = NSTextAlignmentCenter;
        self.lbNum.hidden = true;  //默认隐藏
        [self addSubview:self.lbNum];
    }
    return self;
}


//getter setter
@synthesize commNum;

//增加商品数量
- (void)addNum{
    commNum++;
}
//减少商品数量
- (void)minusNum {
    commNum--;
}

@end
