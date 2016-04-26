//
//  EditAddressController.m
//  SchoolMarket
//
//  Created by tb on 16/4/24.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import "EditAddressController.h"

@interface EditAddressController () <UITableViewDataSource>

/**  联系人 */
@property (nonatomic, weak) UITextField *consigneeTF;
/**  手机号码 */
@property (nonatomic, weak) UITextField *phoneTF;
/**  详细地址 */
@property (nonatomic, weak) UITextField *addDetailTF;

/**  tableView容器 */
@property (nonatomic, weak) UITableView *containerTbl;

@end

@implementation EditAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑地址";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:nil];
    
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
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"联 系 人";
            [self createTextFieldWithCell:cell andTextField:self.consigneeTF andText:@"请输入联系人姓名"];
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"手机号码";
            [self createTextFieldWithCell:cell andTextField:self.phoneTF andText:@"请输入手机号码"];
        } else {
            cell.textLabel.text = @"详细地址";
            [self createTextFieldWithCell:cell andTextField:self.addDetailTF andText:@"请输入详细地址"];
        }
    }
    return cell;
}

/**  设置UITextField */
- (UITextField *)createTextFieldWithCell:(UITableViewCell *)cell andTextField:(UITextField *)textField andText:(NSString *)text
{
    if (textField == nil) {
        CGFloat tfX = self.view.bounds.size.width * 0.3;
        CGFloat tfW = self.view.bounds.size.width - tfX - 15;
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(tfX, 0, tfW, cell.frame.size.height)];
        tf.placeholder = text;
        textField = tf;
        [cell addSubview:textField];
    }
    return textField;
}
@end
