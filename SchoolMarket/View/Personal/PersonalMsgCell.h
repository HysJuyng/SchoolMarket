/*
 个人主页 头部信息
 头像  用户名  手机号码
 */

#import <UIKit/UIKit.h>

@interface PersonalMsgCell : UITableViewCell


@property (nonatomic,weak) UIImageView *userImgv;
@property (nonatomic,weak) UILabel *lbName;
@property (nonatomic,weak) UILabel *lbPhone;

//初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andFrame:(CGRect)frame;
@end
