/*
 个人信息 修改
 tableview
 头像 用户名 性别
 */

#import "PersonalMsgController.h"

@interface PersonalMsgController ()

@property (nonatomic,strong) UITableView *personalMsgTableview;
@property (nonatomic,copy) NSArray *msgs;
@end

@implementation PersonalMsgController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账户信息";
    
    //创建tableview
    self.personalMsgTableview = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    self.personalMsgTableview.delegate = self;
    self.personalMsgTableview.dataSource = self;
    [self.view addSubview:self.personalMsgTableview];
    
    self.msgs = [[NSArray alloc] initWithObjects:@"头像",@"姓名",@"性别", nil];
}

#pragma mark 代理
//单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
//头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}
//脚视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}
//单元格个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
//获取单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:self.msgs[indexPath.row]];
    if (cell == nil) {
        cell = [[PersonMsgCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:self.msgs[indexPath.row] andFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  //单元格选中样式
    cell.lbTitle.text = self.msgs[indexPath.row];
    cell.lbContent.text = @"Content";
    return cell;
}

//选中单元格 头像：打开图库  姓名：跳转修改姓名  性别：actionsheet
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {  //头像
        NSLog(@"头像");
        [self openGallery];
    } else if (indexPath.row == 1) {  //姓名
        NSLog(@"姓名");
        [self goToChangeName];
    } else if (indexPath.row == 2) {   //性别
        NSLog(@"性别");
        [self selectSex];
    }
}

#pragma mark 自定义方法
//打开图库
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
//跳转修改姓名
- (void)goToChangeName {
    PersonalNameController *subvc = [[PersonalNameController alloc] init];
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:(UIBarButtonItemStylePlain) target:nil action:nil];
    [self.navigationController pushViewController:subvc animated:true];
}
//actionsheet打开性别选择
- (void)selectSex {
    UIAlertController *actionsheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    //创建action
    //男
    UIAlertAction *selectMan = [UIAlertAction actionWithTitle:@"男" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"男");
    }];
    [actionsheet addAction:selectMan];
    //女
    UIAlertAction *selectWoman = [UIAlertAction actionWithTitle:@"女" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"女");
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

//返回上级
- (void)doBack {
    //隐藏
//    [self.navigationController setNavigationBarHidden:true animated:false];
    //返回
    [self.navigationController popViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
