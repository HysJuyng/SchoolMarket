/*
 登录
 */

#import "LoginViewController.h"

#import "RegisterViewController.h"
#import "LoginHeader.h"
#import "AFRequest.h"
#import "FMDBsql.h"
#import "User.h"
#import "NotifitionSender.h"


@interface LoginViewController () <LRFootViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak) UITableView *loginTableview;
@property (nonatomic,strong) UIAlertController *alertController;

@property (nonatomic,assign) int isAgree;  //同意条款状态 1为同意 0为不同意
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    
    //导航栏右侧注册按钮
    UIBarButtonItem *tempregister = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:(UIBarButtonItemStylePlain) target:self action:@selector(registerClick)];
    self.btnRegister = tempregister;
    self.navigationItem.rightBarButtonItem = self.btnRegister;
    
    
    //tableview
    UITableView *temptableview = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    self.loginTableview = temptableview;
    self.loginTableview.delegate = self;
    self.loginTableview.dataSource = self;
    [self.loginTableview setSeparatorInset:UIEdgeInsetsMake(0, 30, 0, 30)];
    [self.view addSubview:self.loginTableview];
    
}

#pragma mark tableview代理方法
/** 头视图高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}
/** 脚视图*/
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    LRFootView *lrfootView = [[LRFootView alloc ]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100) andSuperVc:self];
    lrfootView.delegate = self;
    [lrfootView.btnLoginOrReg setTitle:@"登录" forState:(UIControlStateNormal)];
    self.isAgree = 1;//设置初始状态 默认为同意
    return lrfootView;
}
/** 脚视图高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 300;
}
/** 单元格个数*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
/** 获取单元格*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LRTableviewCell *cell = [[LRTableviewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone; //cell选择样式
    if (indexPath.row == 0) {
        cell.tfContent.placeholder = @"输入您的手机号码";  //设置提示文本
        
        //设置手机号码tag
        cell.tfContent.tag = 101;
        
    } else if (indexPath.row == 1) {
        cell.tfContent.placeholder = @"输入您的密码";  //设置提示文本
        cell.tfContent.secureTextEntry = true; //密码输入
    }

    return cell;
}


#pragma mark 自定义方法
/**
 *  检测输入的内容有没符合要求
 *
 *  @param phone    用户电话
 *  @param password 密码
 *  @param code     验证码
 *
 *  @return 返回信息
 */
- (nonnull NSString*)textIsRequirements:(nonnull NSString*)phone andPassword:(nonnull NSString*)password andCode:(nullable NSString*)code {
    if (phone.length != 11) {
        return @"手机号码长度为11位!";
    }
    if (password.length < 6 || password.length > 16) {
        return @"密码长度为6到16位!";
    }
    if (code.length == 0 && code != nil) {
        return @"请输入验证码!";
    }
    if (self.isAgree == 0) {
        return @"请阅读并同意《用户服务协议》";
    }
    return @"success";
}
/**
 *  阅读并同意
 */
- (void)ReadAndAgreeClick:(UIButton*)sender {
    NSLog(@"点击同意");
    LRFootView *footview = (LRFootView*)[sender superview];
    //切换状态
    if (self.isAgree == 1) {
        self.isAgree = 0;
        [footview setAgreeImg:[UIImage imageNamed:@"checked_grey"]];
    } else {
        self.isAgree = 1;
        [footview setAgreeImg:[UIImage imageNamed:@"checked_green"]];
    }
}
/**
 *  登录或注册
 */
- (void)LoginOrRegClick {
    NSLog(@"登录");
    
    //判断输入格式是否正确 (主要是字数)
    //获取两个cell的文本
    
    //获取手机号码
    NSIndexPath *phoneIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    NSString *phone = [NSString stringWithString:((LRTableviewCell*)[self.loginTableview cellForRowAtIndexPath:phoneIndex]).tfContent.text];
    //获取密码
    NSIndexPath *passwordIndex = [NSIndexPath indexPathForItem:1 inSection:0];
    NSString *password = [NSString stringWithString:((LRTableviewCell*)[self.loginTableview cellForRowAtIndexPath:passwordIndex]).tfContent.text];

    NSLog(@"%@,%@",phone,password);
    //检验输入是否符合要求
    NSString *flag = [self textIsRequirements:phone andPassword:password andCode:nil];
    //根据返回的flag 推出alert
    if (![flag  isEqual: @"success"]) {
        //推出alertview
        self.alertController.message = flag;
        [self presentViewController:self.alertController animated:true completion:nil];
    }else {   //检验成功 发送数据
        NSLog(@"%@",flag);
        [self login:phone andpassword:password];
    }
}
/**
 *  打开用户服务协议
 */
- (void)UrSerAgreeClick {
    NSLog(@"用户服务协议");
}
/**
 *  注册  跳转注册页面
 */
- (void)registerClick {
    RegisterViewController *subvc = [[RegisterViewController alloc] init];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:subvc animated:true];
}
/**
 *  登录并验证
 *
 *  @param userphone 用户手机
 *  @param password  用户密码
 */
- (void)login:(NSString*)userphone andpassword:(NSString*)password {
    //url
    NSString *url = @"http://schoolserver.nat123.net/SchoolMarketServer/userLoginByPhone.jhtml";
    //参数
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:userphone forKey:@"userPhone"];
    [param setObject:password forKey:@"password"];
    //请求
    [AFRequest postLogin:url andParameter:param andResponse:^(NSString * _Nullable flag, NSDictionary * _Nullable dic) {
        if (dic) {
            //登录成功 修改userdefalut
            NSUserDefaults *userdef = [[NSUserDefaults alloc] init];
            [userdef setObject:@"true" forKey:@"logined"];//登录状态
            [userdef setObject:userphone forKey:@"userphone"];  //登录用户手机
            
            //获得用户信息
            User *user = [[User alloc] initWithUserDic:dic];
            //保存用户信息到数据库
            [FMDBsql savePersonalMsg:user];
            //把用户id设置在userdefaults中
            [userdef setObject:[NSString stringWithFormat:@"%d",user.userId] forKey:@"userId"];
            //发送通知
            [NotifitionSender updateUserMsg];
            
            //登录 成功 跳转个人中心
            self.tabBarController.selectedIndex = 3;
            [self.navigationController popToRootViewControllerAnimated:true];
        } else {
            //登录 失败 提示失败信息
            self.alertController.message = flag;
            [self presentViewController:self.alertController animated:true completion:nil];
        }
    } andError:^(NSError * _Nullable error) {
        //推出alertview
        self.alertController.message = @"网络请求失败！";
        [self presentViewController:self.alertController animated:true completion:nil];
    }];
}

/**
 *  懒加载 alertController
 */
- (UIAlertController *)alertController {
    if (! _alertController) {
        
        _alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleAlert)];
        
        //取消按钮
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消");
        }];
        [_alertController addAction:cancel];
    }

    return _alertController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
