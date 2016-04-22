/*
 个人页面
 */

#import "PersonalViewController.h"

#import "PersonalHeader.h"
#import "PersonalMsgController.h"
#import "LoginViewController.h"

@interface PersonalViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *personalTableview;
//tableview选项数组
@property (nonatomic,copy) NSArray *sectionTitle;
@property (nonatomic,copy) NSArray *sectionImage;
@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"个人中心";
    
    
    //创建tableview
    self.personalTableview = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    self.personalTableview.delegate = self;
    self.personalTableview.dataSource = self;
    self.personalTableview.bounces = false;
    [self.view addSubview:self.personalTableview];
    
    //添加tableview section1的条目
    self.sectionTitle = [[NSArray alloc] initWithObjects:@"订单",@"收货地址",@"常见问题",@"意见反馈",@"关于我们",@"检查更新", nil];
    self.sectionImage = [[NSArray alloc] initWithObjects:@"",@"personal_addr",@"personal_problem",@"personal_feedback",@"personal_aboutme",@"personal_update", nil];
    
}

#pragma mark tableview代理
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
        cell.lbName.text = @"godhandsome";
        cell.lbPhone.text = @"18814182438";
        //***********这里应该使用set 通过model填写数据
        return cell;
    } else if (indexPath.section == 1) {   //第二区    一些操作
        PersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[PersonalCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid andSuperVc:self];
        }
        //设置标题和图片
        [cell setTitleAndImage:self.sectionTitle[indexPath.row] andImage:self.sectionImage[indexPath.row]];
        return cell;
    } else if (indexPath.section == 2) {   //第三区   退出登录
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
        }
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
//        //隐藏和显示
//        [self.navigationController setNavigationBarHidden:false];
        //推出个人信息页面
        PersonalMsgController *subvc = [[PersonalMsgController alloc] init];
        //返回按钮
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:(UIBarButtonItemStylePlain) target:nil action:nil];
        [self.navigationController pushViewController:subvc animated:true];
    } else if (indexPath.section == 1) {
        NSLog(@"%@",self.sectionTitle[indexPath.row]);
    } else if (indexPath.section == 2) {
        NSLog(@"退出登录");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
