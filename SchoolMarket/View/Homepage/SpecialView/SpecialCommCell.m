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
        
        self.commImgv.backgroundColor = [UIColor blueColor];
        
        //名字
        UILabel *tempname = [[UILabel alloc] initWithFrame:CGRectMake(self.commImgv.frame.size.width + 20, 10, self.frame.size.width - self.commImgv.frame.size.width - 30, self.frame.size.height / 5)];
        self.lbCommName = tempname;
        self.lbCommName.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.lbCommName];
        
        self.lbCommName.backgroundColor = [UIColor colorWithRed:10.0/255.0 green:200.0/255.0 blue:150.0/255.0 alpha:1.0];
        
        //规格
        UILabel *tempspecification = [[UILabel alloc] initWithFrame:CGRectMake(self.lbCommName.frame.origin.x, self.frame.size.height / 6 + 15, 100, self.frame.size.height / 6)];
        self.lbSpecification = tempspecification;
        self.lbSpecification.textAlignment = NSTextAlignmentLeft;
        self.lbSpecification.font = [UIFont systemFontOfSize:self.lbSpecification.frame.size.height /4 * 3];
        [self addSubview:self.lbSpecification];
        
        self.lbSpecification.backgroundColor = [UIColor purpleColor];
        
        //特价
        UILabel *tempspecial = [[UILabel alloc] initWithFrame:CGRectMake(self.lbCommName.frame.origin.x, self.frame.size.height / 5 * 3, 60, self.frame.size.height / 4 )];
        self.lbSpecialPrice = tempspecial;
        self.lbSpecialPrice.textAlignment = NSTextAlignmentLeft;
        self.lbSpecialPrice.font = [UIFont systemFontOfSize:self.lbSpecialPrice.frame.size.height - 3];
        [self addSubview:self.lbSpecialPrice];
        
        self.lbSpecialPrice.backgroundColor = [UIColor yellowColor];
        
        //原价
        LbMiddleLine *tempprice = [[LbMiddleLine alloc] initWithFrame:CGRectMake(self.lbCommName.frame.origin.x + 70, self.frame.size.height / 10 * 7, 40, self.frame.size.height / 20 * 3)];
        self.lbPrice = tempprice;
        self.lbPrice.textAlignment = NSTextAlignmentCenter;
        self.lbPrice.font = [UIFont systemFontOfSize:self.lbPrice.frame.size.height];
        [self addSubview:self.lbPrice];
        
        self.lbPrice.text = @"12.0";
        self.lbPrice.backgroundColor = [UIColor grayColor];
        
        
        //加减view
        SCCAddAndMinusView *tempview = [[SCCAddAndMinusView alloc] initWithFrame:CGRectMake(self.frame.size.width - self.frame.size.height / 4 * 3 - 15, self.frame.size.height - self.frame.size.height / 4 - 10, self.frame.size.height / 4 * 3, self.frame.size.height / 4)];
        self.addAndMinusView = tempview;
        [self addSubview:self.addAndMinusView];
        
    }
    return self;
}

//设置内容
- (void)setSpecialComm:(Commodity*)comm {
    [self.commImgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://schoolserver.nat123.net/SchoolMarketServer/uploadDir/%@",comm.picture]] placeholderImage:[UIImage imageNamed:comm.picture] completed:nil];
    self.lbCommName.text = comm.commName;
    self.lbSpecification.text = comm.specification;
    self.lbPrice.text = comm.price;
    //还要添加特价
    self.lbSpecialPrice.text = [NSString stringWithFormat:@"%0.1f",[comm.price floatValue] * comm.discount];
}


- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
