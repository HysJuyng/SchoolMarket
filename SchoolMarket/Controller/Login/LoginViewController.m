/*
 登录
 */

#import "LoginViewController.h"

@interface LoginViewController () <LRFootViewDelegate>

@property (nonatomic,strong) UITableView *loginTableview;
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
    self.loginTableview = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
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
}
//打开用户服务协议
- (void)UrSerAgreeClick {
    NSLog(@"用户服务协议");
}

//获取验证码
- (void)getIdentifyingCode {
    NSLog(@"getcode");
}

//注册  跳转注册页面
- (void)registerClick {
    RegisterViewController *subvc = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:subvc animated:true];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
