/*
 登录
 */


#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "RegisterViewController.h"
#import "LoginHeader.h"

@interface LoginViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak) UIBarButtonItem *btnRegister;  //注册按钮


- (void)registerClick;   //注册

@end
