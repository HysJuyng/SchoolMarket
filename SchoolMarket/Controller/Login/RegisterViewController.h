/*
 注册
 */

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@interface RegisterViewController : BaseViewController 


@property (nonatomic,weak) UIButton *btnGetCode;   //获取验证码按钮


- (void)getIdentifyingCode;   //获取验证码

@end
