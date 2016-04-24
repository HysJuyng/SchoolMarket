/*
 登录
 */

#import "LoginViewController.h"

#import "RegisterViewController.h"
#import "LoginHeader.h"
#import "AFRequest.h"


@interface LoginViewController () <LRFootViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak) UITableView *loginTableview;
@property (nonatomic,strong) UIAlertController *alertController;
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

//头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}
//脚视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    LRFootView *lrfootView = [[LRFootView alloc ]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100) andSuperVc:self];
    [lrfootView.btnLoginOrReg setTitle:@"登录" forState:(UIControlStateNormal)];
    return lrfootView;
}
//脚视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 300;
}

//单元格个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
//获取单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LRTableviewCell *cell = [[LRTableviewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone; //cell选择样式
    if (indexPath.row == 0) {
        //    cell.titleImgv.image = //设置图片
        cell.tfContent.placeholder = @"输入您的手机号码";  //设置提示文本
    } else if (indexPath.row == 1) {
        //    cell.titleImgv.image = //设置图片
        cell.tfContent.placeholder = @"输入您的密码";  //设置提示文本
        cell.tfContent.secureTextEntry = true; //密码输入
    }

    return cell;
}



//阅读并同意
- (void)ReadAndAgreeClick {
    NSLog(@"点击同意");
}
//登录或注册
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
    NSString *flag = [self textIsRequirements:phone andPasswork:password andCode:nil];
    //根据返回的flag 推出alert
    if (![flag  isEqual: @"success"]) {
        //推出alertview
        self.alertController.message = flag;
        [self presentViewController:self.alertController animated:true completion:nil];
    }else {   //检验成功 发送数据
        NSLog(@"%@",flag);
        [self login:phone andPasswork:password];
    }
    
    
}
//打开用户服务协议
- (void)UrSerAgreeClick {
    NSLog(@"用户服务协议");
}

//检测输入的内容有没符合要求
- (nonnull NSString*)textIsRequirements:(nonnull NSString*)phone andPasswork:(nonnull NSString*)passwork andCode:(nullable NSString*)code {
    if (phone.length != 11) {
        return @"手机号码长度为11位!";
    }
    if (passwork.length < 6 || passwork.length > 16) {
        return @"密码长度为6到16位!";
    }
    if (code.length == 0 && code != nil) {
        return @"请输入验证码!";
    }
    return @"success";
}

//注册  跳转注册页面
- (void)registerClick {
    RegisterViewController *subvc = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:subvc animated:true];
}

//登录并验证
- (void)login:(NSString*)name andPasswork:(NSString*)password {
    AFRequest *post = [[AFRequest alloc] init];
    NSString *url = @"http://schoolserver.nat123.net/SchoolMarketServer/userLogin.jhtml";
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:name forKey:@"username"];
    [param setObject:password forKey:@"password"];
    [post postLogin:url andParameter:param andResponse:^(NSString * _Nonnull flag) {
        NSString *messgae = [flag valueForKey:@"message"];
        if ([messgae isEqualToString:@"success"]) {
            //登录 成功 返回上级
            [self.navigationController popViewControllerAnimated:true];
        } else {
            //登录 失败 提示失败信息
            self.alertController.message = messgae;
            [self presentViewController:self.alertController animated:true completion:nil];
        }
    }];
}

/**
 *  懒加载 alertController
 */
- (UIAlertController *)alertController {
    if (! _alertController) {
        
        _alertController = [UIAlertController alertControllerWithTitle:@"error" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
        
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
