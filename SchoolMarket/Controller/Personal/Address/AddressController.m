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

@interface AddressController () <UITableViewDataSource, UITableViewDelegate>

/**  收货地址列表 */
@property (nonatomic, weak) UITableView *addressTbl;

/**  新增收货地址按钮 */
@property (nonatomic, weak) UIButton *addBtn;

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
    return 20;
}

/**  设置cell的明细 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressCell *cell = [AddressCell cellWithTableView:tableView];
    cell.textLabel.text = @"姓名 手机号码";
    cell.textLabel.font = [UIFont systemFontOfSize:18.0];
    cell.detailTextLabel.text = @"详细地址";
    cell.detailTextLabel.font = [UIFont systemFontOfSize:17.0];
    
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
    [self goToEditAddress];
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
        [addBtn addTarget:self action:@selector(goToEditAddress) forControlEvents:UIControlEventTouchUpInside];
        self.addBtn = addBtn;
        [self.view addSubview:self.addBtn];
    }
    return self.addBtn;
}

/**  进入编辑收货地址页面 */
- (void)goToEditAddress
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    EditAddressController *edit = [[EditAddressController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:edit animated:YES];
}

@end
