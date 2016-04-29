/*
 订单详情cell
 */

#import <UIKit/UIKit.h>

@interface OrderDetailCell : UITableViewCell

/**
 *  标题
 */
@property (nonatomic,weak) UILabel *lbTitle;
/**
 *  内容
 */
@property (nonatomic,weak) UILabel *lbContent;

/**
 *  设置cell内容
 *
 *  @param title   标题
 *  @param content 内容
 */
- (void)setOrderDetail:(NSString *)title andContent:(NSString *)content;

@end
