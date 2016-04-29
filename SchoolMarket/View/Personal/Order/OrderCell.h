/*
 订单cell
 */

#import <UIKit/UIKit.h>

@class Order;

@interface OrderCell : UITableViewCell

/**
 *  订单id
 */
@property (nonatomic,weak) UILabel *lbOrderId;
/**
 *  总额 和 运费
 */
@property (nonatomic,weak) UILabel *lbTotalAndFreight;
/**
 *  状态
 */
@property (nonatomic,weak) UILabel *lbState;
/**
 *  右箭头图片
 */
@property (nonatomic,weak) UIImageView *nextImgv;

//初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andFrame:(CGRect)frame;
/**
 *  通过模型设置cell内容
 *
 *  @param order 订单模型
 */
- (void)setOrderCellWithOrder:(Order *)order;

@end
