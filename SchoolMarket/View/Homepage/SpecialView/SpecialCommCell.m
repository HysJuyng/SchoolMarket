/*
 特价商品tableviewcell
 
 商品图片 名称 规格 
 原价 特价 
 加减 数量
 */

#import "SpecialCommCell.h"
#import "Commodity.h"

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
        
        self.lbCommName.backgroundColor = [UIColor greenColor];
        
        //规格
        UILabel *tempspecification = [[UILabel alloc] initWithFrame:CGRectMake(self.lbCommName.frame.origin.x, self.frame.size.height / 6 + 15, 100, self.frame.size.height / 6)];
        self.lbSpecification = tempspecification;
        self.lbSpecification.textAlignment = NSTextAlignmentLeft;
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
        UILabel *tempprice = [[UILabel alloc] initWithFrame:CGRectMake(self.lbCommName.frame.origin.x + 70, self.frame.size.height / 10 * 7, 40, self.frame.size.height / 20 * 3)];
        self.lbPrice = tempprice;
        self.lbPrice.textAlignment = NSTextAlignmentLeft;
        self.lbPrice.font = [UIFont systemFontOfSize:self.lbPrice.frame.size.height];
        [self addSubview:self.lbPrice];
        
        self.lbPrice.backgroundColor = [UIColor grayColor];
        
    }
    return self;
}

//设置内容
- (void)setSpecialComm:(Commodity*)comm {
    self.commImgv.image = [UIImage imageNamed:comm.picture];
    self.lbCommName.text = comm.commName;
    self.lbSpecification.text = comm.specification;
    self.lbPrice.text = comm.price;
    //还要添加特价
}

//- (void)drawTextInRect:(CGRect)rect {
//    
//    //划线
//    CGFloat x = 0;
//    CGFloat y = rect.size.height / 2;
//    CGFloat w = rect.size.width;
//    CGFloat h = 1;
//    UIRectFill(CGRectMake(x, y, w, h));
//}
//- (void)drawLine:(CGRect)rect
//{
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    // 1.起点
//    CGFloat startX = 0;
//    CGFloat startY = rect.size.height * 0.5;
//    CGContextMoveToPoint(ctx, startX, startY);
//    
//    // 2.终点
//    CGFloat endX = rect.size.width;
//    CGFloat endY = startY;
//    CGContextAddLineToPoint(ctx, endX, endY);
//    
//    // 3.绘图渲染
//    CGContextStrokePath(ctx);
//}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
