/*
 个人信息 修改
 tableview
 头像 用户名 性别
 */

#import <UIKit/UIKit.h>
@class User;


@interface PersonalMsgController : UIViewController 


@property (nonatomic,weak) UIBarButtonItem *btnBack;  //导航栏左侧返回按钮

@property (nonatomic,weak) User *userMsg;  //用户信息


@end
