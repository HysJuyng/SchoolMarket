/*
 订单商品cell
 */

#import "OrderCommCell.h"
#import "Commodity.h"
#import "SDWebImage-umbrella.h"

@implementation OrderCommCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        //商品图片imageView
        UIImageView *tempimgv = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width - 10, self.frame.size.height / 5 * 3 - 10)];
        self.commImgv = tempimgv;
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
        
        //价格lable
        UILabel *tempPrice = [[UILabel alloc]initWithFrame:CGRectMake(5, self.frame.size.height / 20 * 17, self.frame.size.width / 3 * 2, self.frame.size.width / 4)];
        self.lbPrice = tempPrice;
        self.lbPrice.font = [UIFont systemFontOfSize:self.lbPrice.frame.size.height / 3 * 2];
        self.lbPrice.textAlignment = NSTextAlignmentLeft;  //设置文本左
        [self addSubview:self.lbPrice];
        
        //数量lable
        UILabel *tempNum = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width / 4, self.frame.size.height / 20 * 17, self.frame.size.width / 3 - 15, self.frame.size.width / 4)];
        self.lbNum = tempNum;
        self.lbNum.textAlignment = NSTextAlignmentRight;  //设置文本右
        [self addSubview:self.lbNum];
    }
    return self;
}

/** 通过model设置cell内容*/
- (void)setCommCell:(Commodity*)commodity {
    self.lbName.text = commodity.commName;
    self.lbSpecification.text = commodity.specification;
    self.lbPrice.text = [NSString stringWithFormat:@"￥%@",commodity.price];
    self.lbNum.text = [NSString stringWithFormat:@"×%d",commodity.selectedNum];
    
    [self.commImgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://schoolserver.nat123.net/SchoolMarketServer/uploadDir/%@",commodity.picture]]
                     placeholderImage:[UIImage imageNamed:@"default_img"]
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                if (error) {
                                    self.commImgv.image = [UIImage imageNamed:@"default_img_failed"];
                                }
                            }];

}

@end
