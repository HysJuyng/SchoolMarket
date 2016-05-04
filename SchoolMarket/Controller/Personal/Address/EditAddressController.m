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

@interface EditAddressController () <UITableViewDataSource>

/**  tableView容器 */
@property (nonatomic, weak) UITableView *containerTbl;

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
/**  设置分组数量 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/**  设置每个分组的cell数量 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

/**  设置cell的明细 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditAddressCell *cell = [[EditAddressCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [cell setEditAddressCell:@"联 系 人:" andPlaceholder:@"请输入联系人姓名" andText:self.address.consignee];
        } else if (indexPath.row == 1) {
            [cell setEditAddressCell:@"手机号码:" andPlaceholder:@"请输入手机号码" andText:self.address.phone];
        } else {
            [cell setEditAddressCell:@"详细地址:" andPlaceholder:@"请输入详细地址" andText:self.address.addressDetail];
        }
    }
    return cell;
}


#pragma mark 自定义方法
/** 保存按钮*/
- (void)saveClick {
    
    //获取收货地址信息
    NSString *consignee;
    NSString *phone;
    NSString *addressDetail;
    for (int i = 0; i < 3; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
        EditAddressCell *cell = [self.containerTbl cellForRowAtIndexPath:index];
        if (i == 0) {
            consignee = cell.tfContent.text;
        } else if (i == 1) {
            phone = cell.tfContent.text;
        } else if (i == 2) {
            addressDetail = cell.tfContent.text;
        }
    }
    
    NSLog(@"%@,%@,%@",consignee,phone,addressDetail);
    
}
@end
