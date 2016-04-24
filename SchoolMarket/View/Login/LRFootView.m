/*
 注册和登录 脚视图
 */

#import "LRFootView.h"

@implementation LRFootView

- (instancetype)initWithFrame:(CGRect)frame andSuperVc:(UIViewController*)supervc
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //阅读并同意
        UIButton *tempraa = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.btnReadAndAgree = tempraa;
        self.btnReadAndAgree.frame = CGRectMake(15, 10, supervc.view.frame.size.width / 4, 25);
        [self.btnReadAndAgree setTitle:@"我已阅读并同意" forState:(UIControlStateNormal)];
        self.btnReadAndAgree.titleLabel.font = [UIFont systemFontOfSize:self.btnReadAndAgree.frame.size.height / 5 * 2]; //字体大小
        self.btnReadAndAgree.tintColor = [UIColor grayColor];
        [self.btnReadAndAgree setImage:nil forState:(UIControlStateNormal)];   //设置图片 图片有两张
        [self.btnReadAndAgree addTarget:supervc action:@selector(ReadAndAgreeClick) forControlEvents:(UIControlEventTouchUpInside)];  //点击事件
        [self addSubview:self.btnReadAndAgree];
        
        //用户服务协议
        UIButton *tempusa = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.btnUrSerAgree = tempusa;
        self.btnUrSerAgree.frame = CGRectMake(supervc.view.frame.size.width / 4 + 20, 10, supervc.view.frame.size.width / 4, 25);
        [self.btnUrSerAgree setTitle:@"《用户服务协议》" forState:(UIControlStateNormal)];
        self.btnUrSerAgree.titleLabel.font = [UIFont systemFontOfSize:self.btnUrSerAgree.frame.size.height / 5 * 2]; //字体大小
        self.btnUrSerAgree.tintColor = [UIColor colorWithRed:10.0/255.0 green:200.0/255.0 blue:150.0/255.0 alpha:1.0]; //字体颜色
        [self.btnUrSerAgree addTarget:supervc action:@selector(UrSerAgreeClick) forControlEvents:(UIControlEventTouchUpInside)];  //点击事件
        [self addSubview:self.btnUrSerAgree];
        
        //登录或注册按钮
        UIButton *templar = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.btnLoginOrReg = templar;
        self.btnLoginOrReg.frame = CGRectMake(15, 50, supervc.view.frame.size.width - 30, 40);
        self.btnLoginOrReg.backgroundColor = [UIColor lightGrayColor];   //默认颜色 当输入完全时变绿色
        self.btnLoginOrReg.tintColor = [UIColor whiteColor];
        [self.btnLoginOrReg addTarget:supervc action:@selector(LoginOrRegClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.btnLoginOrReg];
        
        
    }
    return self;
}


@end
