/*
 个人页面
 */

#import "PersonalViewController.h"

#import "PersonalHeader.h"
#import "PersonalMsgController.h"
#import "LoginViewController.h"
#import "AddressController.h"
#import "OrderViewController.h"
#import "User.h"
#import "FMDBsql.h"

@interface PersonalViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *personalTableview;
//tableview选项数组
@property (nonatomic,copy) NSArray *sectionTitle;
@property (nonatomic,copy) NSArray *sectionImage;
@property (nonatomic,strong) User *userMsg;

@property (nonatomic,assign) int isChange; //判断修改标识
@property (nonatomic,assign) int isLogin;  //判断登录标识

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"个人中心";
    
    //修改标识默认为0
    self.isChange = 0;
    
    //创建tableview
    self.personalTableview = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    self.personalTableview.delegate = self;
    self.personalTableview.dataSource = self;
    self.personalTableview.bounces = false;
    [self.view addSubview:self.personalTableview];
    
    //添加tableview section1的条目
    self.sectionTitle = [[NSArray alloc] initWithObjects:@"订单",@"收货地址",@"常见问题",@"意见反馈",@"关于我们",@"检查更新", nil];
    self.sectionImage = [[NSArray alloc] initWithObjects:@"personal_order",@"personal_addr",@"personal_problem",@"personal_feedback",@"personal_aboutme",@"personal_update", nil];
    
    //设置通知
    [self setNotification];
    
}

/** 设置通知*/
- (void)setNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //重新登录 刷新视图
    [center addObserver:self selector:@selector(updateUserMsgCellWhenIsLogin) name:@"updateUserMsgCell" object:nil];
    //修改信息 刷新视图
    [center addObserver:self selector:@selector(updateUserMsgCellWhenIsChange) name:@"userIsChange" object:nil];
}

/** 懒加载用户数据*/
- (User *)userMsg {
    //获取用户id
    NSUserDefaults *userdef = [[NSUserDefaults alloc] init];
    int userid = [[userdef objectForKey:@"userId"] intValue];
    //懒加载
    if (!_userMsg) {
        //通过数据库查找用户信息
        _userMsg = [FMDBsql getUserMsg:userid];
    } else {
        //判断登录id和原有的id是否一致
        if (userid != _userMsg.userId) {
            //通过数据库查找用户信息
            _userMsg = [FMDBsql getUserMsg:userid];
            //把默认标识取消
            self.isLogin = 0;
        }
        //判断是否已经修改
        if (self.isChange) {
            //通过数据库查找用户信息
            _userMsg = [FMDBsql getUserMsg:userid];
            //把默认标识取消
            self.isChange = 0;
        }
        if (userid == _userMsg.userId && self.isLogin) {
            //通过数据库查找用户信息
            _userMsg = [FMDBsql getUserMsg:userid];
            //把默认标识取消
            self.isLogin = 0;
        }
    }
    
    return _userMsg;
}

#pragma mark tableview代理方法
/** 头视图高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01f;
    }
    return 10;
}
/** 脚视图高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01f;
    }
    return 10;
}

/** tableview区数*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
/** cell个数   第一区为个人信息  第二区为5个选项  第三区为退出登录*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return self.sectionTitle.count;
    }
    return 1;
}
/** 返回单元格*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellid = @"cellid";
    if (indexPath.section == 0) {   //第一区   个人信息
        PersonalMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[PersonalMsgCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid andFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 4)];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;  //单元格选取样式
        //设置内容
        [cell setPersonalCell:self.userMsg];
        return cell;
    } else if (indexPath.section == 1) {   //第二区    一些操作
        PersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[PersonalCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid andSuperVc:self];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;  //单元格选取样式
        
        //设置标题和图片
        [cell setTitleAndImage:self.sectionTitle[indexPath.row] andImage:self.sectionImage[indexPath.row]];
        return cell;
    } else if (indexPath.section == 2) {   //第三区   退出登录
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;  //单元格选取样式
        
        cell.textLabel.text = @"退出登录";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor redColor];
        return cell;
    }
    return nil;
}

/** 单元格高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.view.frame.size.height / 4;
    }
    return 50;
}

/** 选中单元格*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSLog(@"进入个人信息");
        //推出个人信息页面
        PersonalMsgController *subvc = [[PersonalMsgController alloc] init];
        
        //正向传值
        subvc.userMsg = self.userMsg;
        
        //返回按钮
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:(UIBarButtonItemStylePlain) target:nil action:nil];
        
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:subvc animated:true];
        self.hidesBottomBarWhenPushed = NO;
        
    } else if (indexPath.section == 1) {
        NSLog(@"%@",self.sectionTitle[indexPath.row]);
        UIViewController *subvc;
        if (indexPath.row == 0) {   //订单
            subvc = [[OrderViewController alloc] init];
        } else if (indexPath.row == 1) {  //收货地址
            subvc = [[AddressController alloc] init];
        }
        
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
        
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:subvc  animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        
    } else if (indexPath.section == 2) {
        NSLog(@"退出登录");
        [self signOut];
    }
}

#pragma mark 通知方法
/** 通知方法 更新用户信息cell*/
- (void)updateUserMsgCellWhenIsChange {
    
    //修改标识
    self.isChange = 1;
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
    //刷新视图
    [self.personalTableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:(UITableViewRowAnimationNone)];
}
/** 通知方法 更新用户信息cell*/
- (void)updateUserMsgCellWhenIsLogin {
    
    //修改标识
    self.isLogin = 1;
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
    //刷新视图
    [self.personalTableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:(UITableViewRowAnimationNone)];
}

#pragma mark 自定义方法
/**
 *  退出登录
 */
- (void)signOut {
    //修改userdefault
    NSUserDefaults *userdef = [[NSUserDefaults alloc] init];
    [userdef setValue:@"false" forKey:@"logined"];  //取消登录状态
    //删除数据库中用户信息
    [FMDBsql deleteUser:self.userMsg.userId];
    
    //返回主页
    self.tabBarController.selectedIndex = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
