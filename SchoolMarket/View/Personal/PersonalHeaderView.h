/*
 个人主页头视图
 图像  用户名  手机号
 */

#import <UIKit/UIKit.h>

@interface PersonalHeaderView : UIView


@property (nonatomic,weak) UIImageView *userImgv;
@property (nonatomic,weak) UILabel *lbName;
@property (nonatomic,weak) UILabel *lbPhone;

//初始化
- (instancetype)initWithFrame:(CGRect)frame andSuperVC:(UIViewController*)supervc;
@end
