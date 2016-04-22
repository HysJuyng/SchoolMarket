/*
 登录
 */


#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@interface LoginViewController : BaseViewController 

@property (nonatomic,weak) UIBarButtonItem *btnRegister;  //注册按钮


- (void)registerClick;   //注册

- (nonnull NSString*)textIsRequirements:(nonnull NSString*)phone andPasswork:(nonnull NSString*)passwork andCode:(nullable NSString*)code;    //检测输入的内容有没符合要求
@end
