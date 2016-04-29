/*
 注册和登录 脚视图
 
 三个按钮： 阅读并同意  用户服务协议   点击按钮（登录/注册）
 */

#import <UIKit/UIKit.h>

@protocol LRFootViewDelegate <NSObject>

- (void)ReadAndAgreeClick;   //阅读并同意
- (void)LoginOrRegClick;   //登录或注册
- (void)UrSerAgreeClick;   //打开用户服务协议

@end

@interface LRFootView : UIView

@property (nonatomic,weak) id<LRFootViewDelegate> delegate;

@property (nonatomic,weak) UIButton *btnLoginOrReg;   //登录或注册按钮
@property (nonatomic,weak) UIButton *btnReadAndAgree;        //阅读并同意
@property (nonatomic,weak) UIButton *btnUrSerAgree;  //用户服务协议 user service agreement


//初始化 
- (instancetype)initWithFrame:(CGRect)frame andSuperVc:(UIViewController*)supervc;

@end
