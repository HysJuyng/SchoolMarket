/*
 订单cell
 */

#import "OrderCell.h"
#import "Order.h"

@implementation OrderCell

//初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andFrame:(CGRect)frame
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.frame = frame;
        
        //订单id
        UILabel *tempid = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, self.frame.size.width / 3 * 2, self.frame.size.height / 4)];
        self.lbOrderId = tempid;
        self.lbOrderId.textAlignment = NSTextAlignmentLeft;
        self.lbOrderId.font = [UIFont systemFontOfSize:self.lbOrderId.frame.size.height ];
        [self addSubview:self.lbOrderId];
        
        //订单状态
        UILabel *tempstate = [[UILabel alloc] initWithFrame:CGRectMake(10, 3 + self.lbOrderId.frame.size.height, self.frame.size.width / 2, self.frame.size.height / 4)];
        self.lbState = tempstate;
        self.lbState.textAlignment = NSTextAlignmentLeft;
        self.lbState.font = [UIFont systemFontOfSize:self.lbState.frame.size.height / 3 * 2];
        [self addSubview:self.lbState];
        
        //订单总额
        UILabel *temptotalandfeight = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.size.height / 3 * 2 + 3, self.frame.size.width / 3 * 2, self.frame.size.height / 5)];
        self.lbTotalAndFreight = temptotalandfeight;
        self.lbTotalAndFreight.textAlignment = NSTextAlignmentLeft;
        self.lbTotalAndFreight.font = [UIFont systemFontOfSize:self.lbTotalAndFreight.frame.size.height / 5 * 4];
        [self addSubview:self.lbTotalAndFreight];
        
        //右箭头
        UIImageView *tempimgv = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 30, self.frame.size.height / 2 - 5, 10, 10)];
        self.nextImgv = tempimgv;
        self.nextImgv.image = [UIImage imageNamed:@"personal_forward_arrow"];
        [self addSubview:self.nextImgv];
        
    }
    return self;
}

/**
 *  通过模型设置cell内容
 *
 *  @param order 订单模型
 */
- (void)setOrderCellWithOrder:(Order *)order {
    
//    self.lbOrderId.text = [NSString stringWithFormat:@"%d",order.orderId];
//    self.lbState.text = order.state;
//    self.lbTotalAndFreight.text = [NSString stringWithFormat:@"总额：%@(含运费：%@)",order.total,order.freight];
    
    self.lbOrderId.text = @"订单编号：123888439185";
    self.lbState.text = @"未完成";
    self.lbTotalAndFreight.text = @"总额：123（含运费：8）";
    
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
