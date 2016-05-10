/*
 个人信息 修改
 tableview
 头像 用户名 性别
 */

#import "PersonalMsgController.h"

#import "PersonalHeader.h"
#import "PersonalNameController.h"
#import "User.h"
#import "FMDBsql.h"
#import "NotifitionSender.h"
#import "AFRequest.h"

@interface PersonalMsgController ()  <UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UITableView *personalMsgTableview;
@property (nonatomic,copy) NSArray *msgs;

@property (nonatomic,strong) UIAlertController *alertController;

@property (nonatomic,assign) int isBack;

@end

@implementation PersonalMsgController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账户信息";
    
    //默认标识为0
    self.isBack = 0;
    
    //导航栏右侧保存按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveClick)];
    
    //创建tableview
    self.personalMsgTableview = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    self.personalMsgTableview.delegate = self;
    self.personalMsgTableview.dataSource = self;
    [self.view addSubview:self.personalMsgTableview];
    
    self.msgs = [[NSArray alloc] initWithObjects:@"头像",@"姓名",@"性别", nil];
    
    //设置通知
    [self setNotification];
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
            if (self.isBack) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
        [_alertController addAction:cancel];
    }
    
    return _alertController;
}

/** 设置通知*/
- (void)setNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //接收编辑页面的用户名
    [center addObserver:self selector:@selector(changeUserName:) name:@"changeUserName" object:nil];
}

#pragma mark tableview代理方法
/** 单元格高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
/** 头视图高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}
/** 脚视图高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}
/** 单元格个数*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
/** 获取单元格*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:self.msgs[indexPath.row]];
    if (cell == nil) {
        cell = [[PersonMsgCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:self.msgs[indexPath.row] andFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  //单元格选中样式
    //通过model填写数据
    if (indexPath.row == 0) {
        [cell setPersonMsgCell:self.msgs[indexPath.row] andContent:nil];
    } else if (indexPath.row == 1) {
        [cell setPersonMsgCell:self.msgs[indexPath.row] andContent:self.userMsg.userName];
    } else if (indexPath.row == 2) {
        [cell setPersonMsgCell:self.msgs[indexPath.row] andContent:self.userMsg.sex];
    }
    
    
    return cell;
}

/** 选中单元格 头像：打开图库  姓名：跳转修改姓名  性别：actionsheet*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {  //头像
        NSLog(@"头像");
        [self openGallery];
    } else if (indexPath.row == 1) {  //姓名
        NSLog(@"姓名");
        [self goToChangeName];
    } else if (indexPath.row == 2) {   //性别
        NSLog(@"性别");
        PersonMsgCell *cell = [self.personalMsgTableview cellForRowAtIndexPath:indexPath];
        [self selectSex:cell];
    }
}

#pragma mark 自定义方法
/**
 *  打开图库
 */
- (void)openGallery {
    if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypePhotoLibrary)]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = true;
        [self presentViewController:picker animated:true completion:nil];
    } else {
        UIAlertController *cameraAlert = [UIAlertController alertControllerWithTitle:@"error" message:@"can not open the photoLib" preferredStyle:(UIAlertControllerStyleAlert)];
        //添加action
        //ok
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"click ok");
        }];
        [cameraAlert addAction:okAction];
        //cancel
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"click cancel");
        }];
        [cameraAlert addAction:cancelAction];
        //推出alert
        [self presentViewController:cameraAlert animated:true completion:nil];
    }
}
/**
 *  跳转修改姓名
 */
- (void)goToChangeName {
    PersonalNameController *subvc = [[PersonalNameController alloc] init];
    
    //正向传值
    subvc.userName = self.userMsg.userName;
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:(UIBarButtonItemStylePlain) target:nil action:nil];
    [self.navigationController pushViewController:subvc animated:YES];
}
/**
 *  actionsheet打开性别选择
 */
- (void)selectSex:(PersonMsgCell*)cell {
    UIAlertController *actionsheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    //创建action
    //男
    UIAlertAction *selectMan = [UIAlertAction actionWithTitle:@"男" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"男");
        self.userMsg.sex = @"男";
        cell.lbContent.text = self.userMsg.sex;
    }];
    [actionsheet addAction:selectMan];
    //女
    UIAlertAction *selectWoman = [UIAlertAction actionWithTitle:@"女" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"女");
        self.userMsg.sex = @"女";
        cell.lbContent.text = self.userMsg.sex;
    }];
    [actionsheet addAction:selectWoman];
    //取消
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"cancel");
    }];
    [actionsheet addAction:cancel];
    
    //推出alert
    [self presentViewController:actionsheet animated:true completion:nil];
    
}
/** 保存按钮*/
- (void)saveClick {

    //推出alert
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确定修改吗?" preferredStyle:(UIAlertControllerStyleAlert)];
    
    //确定action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
       //确定操作
        NSString *url = @"http://schoolserver.nat123.net/SchoolMarketServer/alterUser.jhtml";
        NSDictionary *param = [self.userMsg userToDictionary];
        NSLog(@"%@",param);
        //请求
        [AFRequest postChangeUserMsg:url andParameter:param andResponse:^(NSString * _Nullable message) {
            //成功
            if ([message isEqual:@"alterUserSuccess"]) {
                
                //保存数据
                [self saveUserMsg];
                
            } else {
                self.alertController.message = @"失败";
                [self presentViewController:self.alertController animated:true completion:nil];
            }
        } andError:^(NSError * _Nullable error) {
            //请求错误操作
        }];
        
    }];
    [alert addAction:okAction];
    
    //取消action
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:true completion:nil];

}
/** 保存操作*/
- (void)saveUserMsg {
    //保存数据库
    [FMDBsql updateUserMsg:self.userMsg];
    
    //发送通知刷新视图
    [NotifitionSender userIsChange];
    
    //推出alert
    self.alertController.message = @"修改成功!";
    //标识改为1
    self.isBack = 1;
    
    [self presentViewController:self.alertController animated:true completion:nil];
}


#pragma mark 通知方法
/**
 *  接收编辑页面的用户名通知方法
 *
 *  @param notification 通知字典
 */
- (void)changeUserName:(NSNotification *)notification {
    //获取用户名
    NSString *username = notification.userInfo[@"username"];
    
    //更新页面model和cell
    //model
    self.userMsg.userName = username;
    //cell
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.personalMsgTableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:(UITableViewRowAnimationNone)];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
