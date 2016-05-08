/*
 设置默认地址cell
 */

#import <UIKit/UIKit.h>

@protocol DefaultAddressCellDelegate <NSObject>

- (void)switchOnOrOff:(UISwitch*)sender; //转换开关状态

@end

@interface DefaultAddressCell : UITableViewCell

@property (nonatomic,weak) UILabel *lbTitle;   //标题
@property (nonatomic,weak) UISwitch *swDefault;   //默认地址开关

@property (nonatomic,assign) id<DefaultAddressCellDelegate> delegate; //代理

//初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andFrame:(CGRect)frame;

/**
 *  设置cell
 *
 *  @param title      标题
 *  @param defaultadd 默认状态
 */
- (void)setDefaultAddressCell:(NSString *)title andIsDefault:(int)defaultadd;

@end
