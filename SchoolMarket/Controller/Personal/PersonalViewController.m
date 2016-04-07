/*
 个人页面
 */

#import "PersonalViewController.h"

@interface PersonalViewController ()

@property (nonatomic,strong) UITableView *personalTableview;
//tableview选项数组
@property (nonatomic,copy) NSArray *section1;
@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"个人中心";
    
//    //隐藏导航栏
//    [self.navigationController setNavigationBarHidden:true animated:false];
    
    //创建tableview
    self.personalTableview = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    self.personalTableview.delegate = self;
    self.personalTableview.dataSource = self;
    self.personalTableview.bounces = false;
    [self.view addSubview:self.personalTableview];
    
    //添加tableview section1的条目
    self.section1 = [[NSArray alloc] initWithObjects:@"订单",@"收货地址",@"常见问题",@"意见反馈",@"关于我们",@"检查更新", nil];
    
    
}


//头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01f;
    }
    return 10;
}
//脚视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01f;
    }
    return 10;
}

//tableview区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
//cell个数   第一区为个人信息  第二区为5个选项  第三区为退出登录
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return self.section1.count;
    }
    return 1;
}
//返回单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellid = @"cellid";
    if (indexPath.section == 0) {   //第一区   个人信息
        PersonalMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[PersonalMsgCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid andFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 4)];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;  //单元格选取样式
        cell.lbName.text = @"name";
        cell.lbPhone.text = @"123";
        return cell;
    } else if (indexPath.section == 1) {   //第二区    一些操作
        PersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[PersonalCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid andSuperVc:self];
        }
        cell.lbTitle.text = [NSString stringWithString:self.section1[indexPath.row]];
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

//单元格
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.view.frame.size.height / 4;
    }
    return 50;
}

//选中单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSLog(@"进入个人信息");
//        //隐藏和显示
//        [self.navigationController setNavigationBarHidden:false];
        //推出个人信息页面
        PersonalMsgController *subvc = [[PersonalMsgController alloc] init];
        [self.navigationController pushViewController:subvc animated:true];
    } else if (indexPath.section == 1) {
        NSLog(@"%@",self.section1[indexPath.row]);
    } else if (indexPath.section == 2) {
        NSLog(@"退出登录");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
