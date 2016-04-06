/*
 注册
 */

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "LoginHeader.h"

@interface RegisterViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,weak) UIButton *btnGetCode;   //获取验证码按钮


- (void)getIdentifyingCode;   //获取验证码
- (nonnull NSString*)textIsRequirements:(nonnull NSString*)phone andPasswork:(nonnull NSString*)passwork andCode:(nullable NSString*)code;    //检测输入的内容有没符合要求
@end
