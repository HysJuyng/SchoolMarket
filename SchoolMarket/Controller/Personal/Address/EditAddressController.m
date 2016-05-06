//
//  EditAddressController.m
//  SchoolMarket
//
//  Created by tb on 16/4/24.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import "EditAddressController.h"
#import "Address.h"
#import "EditAddressCell.h"
#import "DefaultAddressCell.h"
#import "AFRequest.h"

@interface EditAddressController () <UITableViewDataSource,DefaultAddressCellDelegate>

/**  tableView容器 */
@property (nonatomic, weak) UITableView *containerTbl;
/** 选择状态*/
@property (nonatomic,assign) int switchflag;
@property (nonatomic,strong) UIAlertController *alertController;

@end

@implementation EditAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑地址";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveClick)];
    
    [self createContainerTbl];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

/** 懒加载数据*/
- (Address *)address {
    if (!_address) {
        _address = [[Address alloc] init];
    }
    return _address;
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

/**  创建容器 */
- (UITableView *)createContainerTbl
{
    if (self.containerTbl == nil) {
        UITableView *containerTbl = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
        containerTbl.dataSource = self;
        self.containerTbl = containerTbl;
        [self.view addSubview:self.containerTbl];
    }
    return self.containerTbl;
}

#pragma mark 数据源方法

/**  设置每个分组的cell数量 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

/**  设置cell的明细 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 3) {
        EditAddressCell *cell = [[EditAddressCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            if (!self.address) {
                [cell setEditAddressCell:@"联 系 人:" andPlaceholder:@"请输入联系人姓名" andText:nil];
            } else {
                [cell setEditAddressCell:@"联 系 人:" andPlaceholder:@"请输入联系人姓名" andText:self.address.consignee];
            }
        } else if (indexPath.row == 1) {
            if (!self.address) {
                [cell setEditAddressCell:@"手机号码:" andPlaceholder:@"请输入手机号码" andText:nil];
            } else {
                [cell setEditAddressCell:@"手机号码:" andPlaceholder:@"请输入手机号码" andText:self.address.phone];
            }
            cell.tfContent.tag = 101;
        } else {
            if (!self.address) {
                [cell setEditAddressCell:@"详细地址:" andPlaceholder:@"请输入详细地址" andText:nil];
            } else {
                [cell setEditAddressCell:@"详细地址:" andPlaceholder:@"请输入详细地址" andText:self.address.addressDetail];
            }
            
        }
        
        return cell;
    } else {
        NSString *cellid = @"defaultaddressid";
        DefaultAddressCell *cell = [[DefaultAddressCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid andFrame:CGRectMake(0, 0, self.view.frame.size.width,50 )];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (!self.address) {
            self.switchflag = 0;
            [cell setDefaultAddressCell:@"默认地址:" andIsDefault:0];
        } else {
            [cell setDefaultAddressCell:@"默认地址:" andIsDefault:self.address.defaultAddress];
            self.switchflag = self.address.defaultAddress;
        }
        
        //设置代理
        cell.delegate = self;
        
        return cell;
    }
    
}


#pragma mark 自定义方法
/** 保存按钮*/
- (void)saveClick {
    
    //获取收货地址信息
    for (int i = 0; i < 3; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
        EditAddressCell *cell = [self.containerTbl cellForRowAtIndexPath:index];
        if (i == 0) {
            self.address.consignee = cell.tfContent.text;
        } else if (i == 1) {
            self.address.phone = cell.tfContent.text;
        } else if (i == 2) {
            self.address.addressDetail = cell.tfContent.text;
        }
    }
    self.address.defaultAddress = self.switchflag;
    //获取用户信息
    NSUserDefaults *userdef = [[NSUserDefaults alloc] init];
    self.address.userId = [[userdef objectForKey:@"userId"] intValue];
    
    //检测输入是否正确
    NSString *flag = [self textIsRequirements:self.address.phone andConsignee:self.address.consignee andAddressDetail:self.address.addressDetail];
    if ([flag isEqualToString:@"success"]) {  //成功则发送请求
        //发送请求
        [self postAddress:self.address];
    } else {  //失败弹出提示
        //推出alertview
        self.alertController.message = flag;
        [self presentViewController:self.alertController animated:true completion:nil];
    }
    
}

/** 设置选择状态*/
- (void)switchOnOrOff:(UISwitch*)sender {
    NSLog(@"123");
    if (self.switchflag == 1) {
        self.switchflag = 0;
//        sender.on = false;
    } else {
        self.switchflag = 1;
//        sender.on = true;
    }
}

/**
 *  发送地址到服务器
 *
 *  @param address 地址model
 */
- (void)postAddress:(Address *)address {
    
    NSString *url = @"http://schoolserver.nat123.net/SchoolMarketServer/addSingleAddress.jhtml";
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:[address addressToDic]];
    
    NSLog(@"%@",param);
    
    //发送请求
    [AFRequest postAddress:url andParameter:param andResponse:^(NSString * _Nonnull message) {
        //请求完成
        if ([message isEqualToString:@"success"]) {
            //返回上级视图
            [self.navigationController popViewControllerAnimated:true];
        } else {
            //推出alertview
            self.alertController.message = message;
            [self presentViewController:self.alertController animated:true completion:nil];
        }
    } andError:^(NSError * _Nullable error) {
        //推出alertview
        self.alertController.message = @"网络请求失败！";
        [self presentViewController:self.alertController animated:true completion:nil];
    }];
    
}

/**
 *  检测输入的内容有没符合要求
 *
 *  @param phone    用户电话
 *  @param password 密码
 *  @param code     验证码
 *
 *  @return 返回信息
 */
- (nonnull NSString*)textIsRequirements:(nonnull NSString*)phone andConsignee:(nonnull NSString*)consignee andAddressDetail:(nullable NSString*)addressDetail {
    if (consignee.length == 0) {
        return @"请输入联系人!";
    }
    if (phone.length == 0) {
        return @"请输入手机号码!";
    }
    if (phone.length != 11) {
        return @"手机号码长度为11位!";
    }
    if (addressDetail.length == 0 ) {
        return @"请输入详细地址!";
    }
    return @"success";
}

@end
