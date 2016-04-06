/*
 注册
 */

#import "RegisterViewController.h"

@interface RegisterViewController () <LRFootViewDelegate>

@property (nonatomic,strong) UITableView *registerTableview;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"用户注册";
    
    //tableview
    self.registerTableview = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    self.registerTableview.delegate = self;
    self.registerTableview.dataSource = self;
    [self.registerTableview setSeparatorInset:UIEdgeInsetsMake(0, 30, 0, 30)];
    [self.view addSubview:self.registerTableview];
    
    //获取验证码按钮   添加到手机号cell里面
    UIButton *tempcode = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    self.btnGetCode = tempcode;
    [self.btnGetCode setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    [self.btnGetCode addTarget:self action:@selector(getIdentifyingCode) forControlEvents:(UIControlEventTouchUpInside)];
}


//头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}
//脚视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    LRFootView *lrfootView = [[LRFootView alloc ]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100) andSuperVc:self];
    [lrfootView.btnLoginOrReg setTitle:@"注册" forState:(UIControlStateNormal)];
    return lrfootView;
}
//脚视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 300;
}

//单元格个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
//获取单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LRTableviewCell *cell = [[LRTableviewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone; //cell选择样式
    if (indexPath.row == 0) {
        //    cell.titleImgv.image = //设置图片
        cell.tfContent.placeholder = @"输入您的手机号码";  //设置提示文本
        self.btnGetCode.frame = CGRectMake(self.view.frame.size.width / 4 * 3, 8, self.view.frame.size.width / 5, 30);
        self.btnGetCode.titleLabel.adjustsFontSizeToFitWidth = true;
        [cell addSubview:self.btnGetCode];
    } else if (indexPath.row == 1) {
        //    cell.titleImgv.image = //设置图片
        cell.tfContent.placeholder = @"输入您的密码";  //设置提示文本
        cell.tfContent.secureTextEntry = true; //密码输入
    } else if (indexPath.row == 2) {
        //    cell.titleImgv.image = //设置图片
        cell.tfContent.placeholder = @"请输入短信验证码";  //设置提示文本
    }
    
    return cell;
}

//阅读并同意
- (void)ReadAndAgreeClick {
    NSLog(@"点击同意");
}
//登录或注册
- (void)LoginOrRegClick {
    NSLog(@"注册");
}
//打开用户服务协议
- (void)UrSerAgreeClick {
    NSLog(@"用户服务协议");
}

//获取验证码
- (void)getIdentifyingCode {
    NSLog(@"获取验证码");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
