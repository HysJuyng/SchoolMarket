/*
 特价商品tableviewcell
 
 商品图片 名称 规格 
 原价 特价 
 加减 数量
 */

#import "SpecialCommCell.h"
#import "Commodity.h"
#import "LbMiddleLine.h"
#import "SCCAddAndMinusView.h"
#import "SDWebImage-umbrella.h"


@implementation SpecialCommCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andFrame:(CGRect)frame
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.frame = frame;
        
        //图片
        UIImageView *tempimgv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.height - 20, self.frame.size.height - 20)];
        self.commImgv = tempimgv;
        [self addSubview:self.commImgv];
        
        
        //名字
        UILabel *tempname = [[UILabel alloc] initWithFrame:CGRectMake(self.commImgv.frame.size.width + 20, 10, self.frame.size.width - self.commImgv.frame.size.width - 30, self.frame.size.height / 5)];
        self.lbCommName = tempname;
        self.lbCommName.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.lbCommName];
        
        
        //规格
        UILabel *tempspecification = [[UILabel alloc] initWithFrame:CGRectMake(self.lbCommName.frame.origin.x, self.frame.size.height / 6 + 15, 100, self.frame.size.height / 6)];
        self.lbSpecification = tempspecification;
        self.lbSpecification.textAlignment = NSTextAlignmentLeft;
        self.lbSpecification.font = [UIFont systemFontOfSize:self.lbSpecification.frame.size.height /4 * 3];
        [self addSubview:self.lbSpecification];
        
        
        //特价
        UILabel *tempspecial = [[UILabel alloc] initWithFrame:CGRectMake(self.lbCommName.frame.origin.x, self.frame.size.height / 5 * 3, 60, self.frame.size.height / 4 )];
        self.lbSpecialPrice = tempspecial;
        self.lbSpecialPrice.textAlignment = NSTextAlignmentLeft;
        self.lbSpecialPrice.font = [UIFont systemFontOfSize:self.lbSpecialPrice.frame.size.height - 3];
        [self addSubview:self.lbSpecialPrice];
        
        
        //原价
        LbMiddleLine *tempprice = [[LbMiddleLine alloc] initWithFrame:CGRectMake(self.lbCommName.frame.origin.x + 70, self.frame.size.height / 10 * 7, 40, self.frame.size.height / 20 * 3)];
        self.lbPrice = tempprice;
        self.lbPrice.textAlignment = NSTextAlignmentCenter;
        self.lbPrice.font = [UIFont systemFontOfSize:self.lbPrice.frame.size.height];
        [self addSubview:self.lbPrice];
        
        self.lbPrice.text = @"12.0";
        
        
        //加减view
        SCCAddAndMinusView *tempview = [[SCCAddAndMinusView alloc] initWithFrame:CGRectMake(self.frame.size.width - self.frame.size.height / 4 * 3 - 15, self.frame.size.height - self.frame.size.height / 4 - 10, self.frame.size.height / 4 * 3, self.frame.size.height / 4)];
        self.addAndMinusView = tempview;
        [self addSubview:self.addAndMinusView];
        //隐藏减按钮和数量
        self.addAndMinusView.btnMinus.hidden = true;
        self.addAndMinusView.selectedNum.hidden = true;
        
    }
    return self;
}

//设置内容
- (void)setSpecialComm:(Commodity*)comm {
    [self.commImgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://schoolserver.nat123.net/SchoolMarketServer/uploadDir/%@",comm.picture]] placeholderImage:[UIImage imageNamed:@"default_img"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            self.commImgv.image = [UIImage imageNamed:@"default_img_failed"];
            NSLog(@"%@",comm.picture);
        }
    }];
    self.lbCommName.text = comm.commName;
    self.lbSpecification.text = comm.specification;
    self.lbPrice.text = [NSString stringWithFormat:@"%@",comm.price];;
    //特价
    self.lbSpecialPrice.text = [NSString stringWithFormat:@"%0.2f",[comm.price floatValue] * comm.discount];
}


- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
