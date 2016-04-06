/*
 注册
 */

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "LoginHeader.h"

@interface RegisterViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,weak) UIButton *btnGetCode;   //获取验证码按钮


- (void)getIdentifyingCode;   //获取验证码

@end
