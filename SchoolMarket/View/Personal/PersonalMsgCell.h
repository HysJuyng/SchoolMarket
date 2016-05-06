/*
 个人主页 头部信息
 头像  用户名  手机号码
 */

#import <UIKit/UIKit.h>

@class User;

@interface PersonalMsgCell : UITableViewCell


@property (nonatomic,weak) UIImageView *userImgv;
@property (nonatomic,weak) UILabel *lbName;
@property (nonatomic,weak) UIImageView *phoneImgv;
@property (nonatomic,weak) UILabel *lbPhone;

//初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andFrame:(CGRect)frame;

/**
 *  设置内容
 *
 *  @param user 用户model
 */
- (void)setPersonalCell:(User*)user;

@end
