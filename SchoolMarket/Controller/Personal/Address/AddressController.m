//
//  AddressController.m
//  SchoolMarket
//
//  Created by tb on 16/4/24.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import "AddressController.h"
#import "AddressCell.h"
#import "EditAddressController.h"
#import "AFRequest.h"
#import "Address.h"
#import "NotifitionSender.h"

@interface AddressController () <UITableViewDataSource, UITableViewDelegate,AddressCellDelegate>

/**  收货地址列表 */
@property (nonatomic, weak) UITableView *addressTbl;

/**  新增收货地址按钮 */
@property (nonatomic, weak) UIButton *addBtn;

@property (nonatomic,strong) NSMutableArray *addresses;

@property (nonatomic,strong) UIAlertController *alertController;

@end

@implementation AddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货地址";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 收货地址列表
    CGFloat addressTblY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat addressTblW = self.view.bounds.size.width;
    CGFloat addressTblH = (self.view.bounds.size.height - addressTblY) * 0.85;
    
    [self createAddressTblWithFrame:CGRectMake(0, addressTblY, addressTblW, addressTblH)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 新增收货地址按钮
    CGFloat addBtnW = self.view.bounds.size.width * 0.9;
    CGFloat addBtnX = (self.view.bounds.size.width - addBtnW) * 0.5;
    CGFloat addBtnY = CGRectGetMaxY(self.addressTbl.frame) + ((self.view.bounds.size.height - CGRectGetMaxY(self.addressTbl.frame)) - 44) * 0.5;
    
    [self createAddBtnWithFrame:CGRectMake(addBtnX, addBtnY, addBtnW, 44)];
    
    //设置通知
    [self setNotification];
    
    //发送请求
    [self getAddresses];
    
}

/** 设置通知*/
- (void)setNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //接收刷新通知
    [center addObserver:self selector:@selector(getAddresses) name:@"updateAddressList" object:nil];
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

/** 获取收货地址数据*/
- (void)getAddresses {
    //取得用户id
    NSUserDefaults *userdef = [[NSUserDefaults alloc]init];
    NSString *userid = [userdef objectForKey:@"userId"];
    //请求地址
    NSString *url = @"http://schoolserver.nat123.net/SchoolMarketServer/findAllAdress.jhtml";
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:userid,@"userId", nil];
    [AFRequest getAddresses:url andParameter:param andAddress:^(NSMutableArray * _Nonnull data) {
        //获取数组
        self.addresses = data;
        //如果没有收货地址 则提示
        if (self.addresses.count == 0) {
            //推出alertview
            self.alertController.message = @"暂无收货地址!";
            [self presentViewController:self.alertController animated:true completion:nil];
        }
        //刷新数据
        [self.addressTbl reloadData];
    } andError:^(NSError * _Nullable error) {
        //推出alertview
        self.alertController.message = @"网络请求失败！";
        [self presentViewController:self.alertController animated:true completion:nil];
    }];
}

#pragma mark - 收货地址列表
/**  收货地址列表Tbl */
- (UITableView *)createAddressTblWithFrame:(CGRect)frame
{
    if (self.addressTbl == nil) {
        UITableView *addressTbl = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        addressTbl.dataSource = self;
        addressTbl.delegate = self;
        self.addressTbl = addressTbl;
        [self.view addSubview:self.addressTbl];
    }
    return self.addressTbl;
}

#pragma mark 数据源方法
/**  tableView分组数量 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/**  tableView每个分组的cell数量 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addresses.count;
}

/**  设置cell的明细 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressCell *cell = [AddressCell cellWithTableView:tableView];
    //设置内容
    //判断是否为默认地址
    if (((Address*)self.addresses[indexPath.row]).defaultedAddress == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@  %@ (默认)",((Address*)self.addresses[indexPath.row]).consignee,((Address*)self.addresses[indexPath.row]).phone];
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"%@  %@",((Address*)self.addresses[indexPath.row]).consignee,((Address*)self.addresses[indexPath.row]).phone];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:18.0];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",((Address*)self.addresses[indexPath.row]).addressDetail];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:17.0];
    
    //编辑按钮tag
    cell.btnEdit.tag = indexPath.row;
    
    
    return cell;
}

#pragma mark 代理方法
/**  设置头视图的高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  2.0f;
}

/**  设置脚视图的高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8.0f;
}

/**  设置cell的高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return self.view.bounds.size.width * 0.2;
    } else
        return tableView.rowHeight;
}

/**  被选中后执行的方法 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //判断是否需要选择
    if (self.isSelectAddress) {  //选择
        //通过通知返回选中地址model
        [NotifitionSender selectAddress:self.addresses[indexPath.row]];
        //返回上级页面
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
/**  实现拖拽删除 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    //取消按钮
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    
    [alert addAction:cancelAction];
    
    //确定按钮
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        //发送删除请求
        NSString *url = @"http://schoolserver.nat123.net/SchoolMarketServer/deleteAddress.jhtml";
        NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",((Address*)self.addresses[indexPath.row]).addressId],@"addressId", nil];
        [AFRequest postAddress:url andParameter:param andResponse:^(NSString * _Nullable message) {
            //推出alertview
            self.alertController.message = @"删除成功!";
            [self presentViewController:self.alertController animated:true completion:nil];
            //移除单元格
            [self.addresses removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationLeft)];
            
        } andError:^(NSError * _Nullable error) {
            //推出alertview
            self.alertController.message = @"网络请求失败！";
            [self presentViewController:self.alertController animated:true completion:nil];
        }];
    }];
    
    [alert addAction:okAction];
    
    //推出alertview
    alert.message = @"确定要删除吗?";
    [self presentViewController:alert animated:true completion:nil];

}

#pragma mark addresscell代理
/**
 *  编辑按钮点击方法
 *
 *  @param button 按钮
 */
- (void)editClick:(UIButton *)button {
    
    //跳转编辑按钮
    [self goToEditAddress:self.addresses[button.tag]];
    
}


#pragma mark - 新增收货地址按钮
/**  新增收货地址按钮 */
- (UIButton *)createAddBtnWithFrame:(CGRect)frame
{
    if (self.addBtn == nil) {
        UIButton *addBtn = [[UIButton alloc] initWithFrame:frame];
        addBtn.backgroundColor = [UIColor colorWithRed:10.0/255.0 green:200.0/255.0 blue:150.0/255.0 alpha:1.0];
        addBtn.layer.cornerRadius = 5.0;
        [addBtn setTitle:@"新增收货地址" forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
        self.addBtn = addBtn;
        [self.view addSubview:self.addBtn];
    }
    return self.addBtn;
}

/** 新增收货地址按钮事件*/
- (void)addClick {
    [self goToEditAddress:nil];
}

/**  进入编辑收货地址页面 */
- (void)goToEditAddress:(Address*)address
{

    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    EditAddressController *edit = [[EditAddressController alloc] init];
    //正向传值
    if (address) {
        edit.address = address;
    } else {
        edit.count = (int)self.addresses.count;
    }
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:edit animated:YES];
}

@end
