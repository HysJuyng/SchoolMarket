/*
 商品Cell
 */

#import "CommCell.h"
#import "SDWebImage-umbrella.h"

#import "Commodity.h"

//@class Commodity;

@implementation CommCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        //商品图片imageView
        UIImageView *tempimgv = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width - 10, self.frame.size.height / 5 * 3 - 10)];
        self.commImgv = tempimgv;
        self.commImgv.image = [UIImage imageNamed:@"default_img"];  //设置默认图片
        [self addSubview:self.commImgv];
        
        //商品名称
        UILabel *tempName = [[UILabel alloc] initWithFrame:CGRectMake(5, self.frame.size.height / 5 * 3, self.frame.size.width, self.frame.size.height / 20 * 2)];
        self.lbName = tempName;
        self.lbName.font = [UIFont systemFontOfSize:self.lbName.frame.size.height];
        [self addSubview:self.lbName];
        
        //商品规格
        UILabel *tempSpecification = [[UILabel alloc] initWithFrame:CGRectMake(5, self.frame.size.height / 10 * 7, self.frame.size.width, self.frame.size.height / 20 * 2)];
        self.lbSpecification = tempSpecification;
        self.lbSpecification.font = [UIFont systemFontOfSize:self.lbSpecification.frame.size.height - 3];
        [self addSubview:self.lbSpecification];
        
        //加按钮
        self.btnAdd = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.btnAdd.frame = CGRectMake(self.frame.size.width / 4 * 3, self.frame.size.height / 20 * 17, self.frame.size.width / 4, self.frame.size.width / 4);
        [self.btnAdd setImage:[UIImage imageNamed:@"plus_circle_green"] forState:(UIControlStateNormal)];
        [self addSubview:self.btnAdd];
        
        //减按钮
        self.btnMinus = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.btnMinus.frame = CGRectMake(0, self.frame.size.height / 20 * 17, self.frame.size.width / 4, self.frame.size.width / 4);
        [self.btnMinus setImage:[UIImage imageNamed:@"minus_circle_grey"] forState:(UIControlStateNormal)];
        self.btnMinus.hidden = true; //默认隐藏
        [self addSubview:self.btnMinus];
        
        //价格lable
        UILabel *tempPrice = [[UILabel alloc]initWithFrame:CGRectMake(5, self.frame.size.height / 20 * 17, self.frame.size.width / 2, self.frame.size.width / 4)];
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


//设置选择的商品数量
- (void)setSelectedNum:(NSString*)num {
    self.lbNum.text = num;
}

/** 通过model设置cell内容*/
- (void)setCommCell:(Commodity*)commodity {
    self.lbName.text = commodity.commName;
    self.lbSpecification.text = commodity.specification;
    self.lbPrice.text = [NSString stringWithFormat:@"$%@",commodity.price];
    [self.commImgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://schoolserver.nat123.net/SchoolMarketServer/uploadDir/%@",commodity.picture]]
                     placeholderImage:[UIImage imageNamed:commodity.picture]
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         NSLog(@"%@",commodity.picture);
     }];
}

@end
