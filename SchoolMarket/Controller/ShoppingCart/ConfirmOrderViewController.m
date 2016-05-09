
//
//  ConfirmOrderViewController.m
//  SchoolMarket
//
//  Created by tb on 16/4/21.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "ConfirmOrderCell.h"
#import "AddressCell.h"
#import "AddressController.h"
#import "Commodity.h"
#import "Order.h"
#import "Address.h"
#import "AFRequest.h"
#import "FMDBsql.h"
#import "NotifitionSender.h"
#import "User.h"

@interface ConfirmOrderViewController () <UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

/**  订单内容 */
@property (nonatomic, weak) UITableView *detailOrderTbl;

/**  姓名 */
@property (nonatomic, weak) UITextField *nameTF;
/**  手机号码 */
@property (nonatomic, weak) UITextField *phoneNumTF;
/**  地址 */
@property (nonatomic, weak) UITextField *addressTF;
/**  详细地址 */
@property (nonatomic, weak) UITextField *detailAddressTF;
/**  备注 */
@property (nonatomic, weak) UITextField *commentTF;
/**  配送时间选择器 */
@property (nonatomic, weak) UIPickerView *timePicker;
/**  配送时间段数组 */
@property (nonatomic, strong) NSArray *pickerData;
/**  底部工具栏 */
@property (nonatomic, weak) UIView *bottomTool;
/**  弹框提示 */
@property (nonatomic, strong) UIAlertController *alertController;

/**  运费 */
@property (nonatomic, copy) NSString *freight;
/**  订单模型 */
@property (nonatomic, strong) Order *order;
/**  默认收货地址模型 */
@property (nonatomic, strong) Address *address;
/**  用户模型 */
@property (nonatomic, strong) User *user;

@end

@implementation ConfirmOrderViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    
    CGFloat detailOrderY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat detailOrderW = self.view.bounds.size.width;
    CGFloat detailOrderH = (self.view.bounds.size.height - detailOrderY) * 0.9;
    
    [self detailOrderTableViewWithFrame:CGRectMake(0, detailOrderY, detailOrderW, detailOrderH)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 底部工具栏
    CGFloat bottomToolW = self.view.bounds.size.width;
    CGFloat bottomToolH = (self.view.bounds.size.height - detailOrderY) * 0.1;
    CGFloat bottomToolY = CGRectGetMaxY(self.detailOrderTbl.frame);
    
    [self bottomToolWithFrame:CGRectMake(0, bottomToolY, bottomToolW, bottomToolH)];
}

#pragma mark - 懒加载
/**  订单模型 */
- (Order *)order {
    if (_order == nil) {
        _order = [[Order alloc] init];
    }
    return _order;
}

/**  收货地址模型 */
- (Address *)address {
    if (_address == nil) {
        NSUserDefaults *userDefaults = [[NSUserDefaults alloc] init];
        NSString *userId = [userDefaults objectForKey:@"userId"];
        // 向服务器请求拿到默认地址
        NSString *url = @"http://schoolserver.nat123.net/SchoolMarketServer/findDefaultedAddress.jhtml";
        NSDictionary *parameter = [[NSDictionary alloc] initWithObjectsAndKeys:userId, @"userId", nil];
        [AFRequest getAddresses:url andParameter:parameter andAddress:^(NSMutableArray * _Nonnull data) {
            _address = data[0];
            _address.userId = userId.intValue;
            [self.detailOrderTbl reloadData];
        } andError:^(NSError * _Nullable error) {
            
        }];
    }
    return _address;
}

/**  弹框提示 */
- (UIAlertController *)alertController {
    if (!_alertController) {
        _alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *done = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([_alertController.message localizedCaseInsensitiveContainsString:@"成功"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
        [_alertController addAction:done];
    }
    return _alertController;
}

#pragma mark - 订单内容
/**  订单内容 */
- (UITableView *)detailOrderTableViewWithFrame:(CGRect)frame {
    if (self.detailOrderTbl == nil) {
        UITableView *detailOrderTbl = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        
        detailOrderTbl.dataSource = self;
        detailOrderTbl.delegate = self;
        
        self.detailOrderTbl = detailOrderTbl;
        [self.view addSubview:self.detailOrderTbl];
    }
    return self.detailOrderTbl;
}

#pragma mark UITableView 数据源方法
/**  tableView分组数量 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

/**  每个分组cell的数量 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 2;
    } else {
        return 2;
    }
}

/**  cell的明细 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        cell = [AddressCell cellWithTableView:tableView];
        NSString *tempStr = [self.address.consignee stringByAppendingString:@"    "];
        cell.textLabel.text = [tempStr stringByAppendingString:self.address.phone];
        cell.textLabel.font = [UIFont systemFontOfSize:18.0];
        cell.detailTextLabel.text = self.address.addressDetail;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:17.0];
    } else {
        cell = [[ConfirmOrderCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"备注";
                if (self.commentTF == nil) {
                    CGFloat commentTFX = self.view.bounds.size.width * 0.3;
                    CGFloat commentTFW = self.view.bounds.size.width - commentTFX - 15;
                    UITextField *commentTF = [[UITextField alloc] initWithFrame:CGRectMake(commentTFX, 0, commentTFW, cell.frame.size.height)];
                    commentTF.placeholder = @"可选";
                    commentTF.textAlignment = UIControlContentHorizontalAlignmentRight;
                    commentTF.delegate = self;
                    commentTF.returnKeyType = UIReturnKeyDone;
                    commentTF.clearButtonMode = UITextFieldViewModeWhileEditing;
                    self.commentTF = commentTF;
                    [cell addSubview:self.commentTF];
                }
            } else {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = @"送达时间";
                cell.detailTextLabel.text = @"尽快送达";
                self.order.deliverTime = cell.detailTextLabel.text;
                [self createTimePicker:(ConfirmOrderCell *)cell];
            }
        } else if(indexPath.section == 2) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"商品";
                cell.detailTextLabel.text = self.commSumPrice;
            } else {
                cell.textLabel.text = @"运费";
                if (self.freight == nil) {
                    self.freight = @"0";
                }
                cell.detailTextLabel.text = self.freight;
                // 设置订单模型中的运费
                self.order.freight = self.freight;
            }
        }
    }
    
    return cell;
}

#pragma mark UITableView 代理方法
/**  设置头视图高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8.0f;
}

/**  设置脚视图高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8.0f;
}
/**  设置cell的高度  */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.view.bounds.size.width * 0.2;
    } else
        return tableView.rowHeight;
}

/**  cell被选中时执行此方法 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //选中收件人信息的cell时跳到收件人信息列表视图
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
        AddressController *addressController = [[AddressController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:addressController animated:YES];
    } else if (indexPath.section == 1 && indexPath.row == 1){
        // 设置cell为第一响应者
        ConfirmOrderCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell becomeFirstResponder];
    }
}

#pragma mark - 时间选择器
- (void)createTimePicker:(ConfirmOrderCell *)cell {
    // 时间选择器上的工具栏
    UIToolbar *timePickerTool = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    
    // 取消按钮
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(hideTimePicker:)];
    
    UIBarButtonItem *flexItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    // 文字提示
    CGFloat timeTipH = timePickerTool.frame.size.height;
    UILabel *timeTip = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, timeTipH)];
    timeTip.text = @"送达时间";
    timeTip.font = [UIFont boldSystemFontOfSize:18.0];
    timeTip.textColor = [UIColor colorWithRed:0.0/255.0 green:100.0/255.0 blue:255.0/255.0 alpha:1.0];
    timeTip.textAlignment = NSTextAlignmentCenter;
    UIBarButtonItem *timeTipItem = [[UIBarButtonItem alloc] initWithCustomView:timeTip];
    
    UIBarButtonItem *flexItem2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    // 完成按钮
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(hideTimePicker:)];
    
    // 将控件加到Toolbar上
    NSArray *items = @[cancelItem, flexItem1, timeTipItem, flexItem2, doneItem];
    [timePickerTool setItems:items animated:YES];
    
    [cell setInputAccessoryView:timePickerTool];
    
    // 配送时间段数组
    NSArray *dataArray = @[@"尽快送达", @"9:00 - 11:00", @"11:00 - 13:00", @"13:00 - 15:00", @"15:00 - 17:00", @"17:00 - 19:00", @"19:00 - 21:00", @"21:00 - 23:00"];
    self.pickerData = dataArray;
    
    // 时间选择器
    if (self.timePicker == nil) {
        UIPickerView *timePicker = [[UIPickerView alloc] init];
        timePicker.backgroundColor = [UIColor whiteColor];
        
        // 设置数据源和代理为self
        timePicker.dataSource = self;
        timePicker.delegate = self;
        
        // 选中标记
        timePicker.showsSelectionIndicator = YES;
        self.timePicker = timePicker;
        [cell setInputView:self.timePicker];
    }
}

/**  时间选择器工具栏点击方法 */
- (void)hideTimePicker:(UIBarButtonItem *)btnItem {
    // 取消cell的第一响应
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    UITableViewCell *cell = [self.detailOrderTbl cellForRowAtIndexPath:indexPath];
    [cell resignFirstResponder];
    // 如果点击完成按钮则将cell的detailTextLabel改为对应的时间
    if ([btnItem.title isEqualToString:@"完成"]) {
        NSInteger row = [self.timePicker selectedRowInComponent:0];
        cell.detailTextLabel.text = self.pickerData[row];
        // 设置订单模型中的运送时间
        self.order.deliverTime = cell.detailTextLabel.text;
    }
}

#pragma mark UIPickerView 数据源方法
/**  设置显示的列数 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

/**  设置显示的行数 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickerData.count;
}

#pragma mark UIPickerView 代理方法
/**  设置选择器每行显示的内容 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.pickerData[row];
}

#pragma mark - UITextField 代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - 底部工具栏
/**  底部工具栏 */
- (UIView *)bottomToolWithFrame:(CGRect)frame {
    if (self.bottomTool == nil) {
        // 初始化底部工具栏
        UIView *bottomTool = [[UIView alloc] initWithFrame:frame];
        bottomTool.backgroundColor = [UIColor whiteColor];
        
        // 确认下单Button
        CGFloat confirmBtnW = frame.size.width * 0.3;
        CGFloat confirmBtnX = frame.size.width - confirmBtnW;
        UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(confirmBtnX, 0, confirmBtnW, frame.size.height)];
        confirmBtn.backgroundColor = [UIColor colorWithRed:10.0/255.0 green:200.0/255.0 blue:150.0/255.0 alpha:1.0];
        [confirmBtn setTitle:@"确认下单" forState:UIControlStateNormal];
        
        [confirmBtn addTarget:self action:@selector(confirmOrder) forControlEvents:UIControlEventTouchUpInside];
        
        [bottomTool addSubview:confirmBtn];
        
        // 实际支付Label
        UILabel *actuallyPayLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width * 0.25, frame.size.height)];
        actuallyPayLbl.text = @"实际支付";
        actuallyPayLbl.font = [UIFont systemFontOfSize:15.0];
        actuallyPayLbl.textAlignment = NSTextAlignmentCenter;
        
        [bottomTool addSubview:actuallyPayLbl];
        
        // 实际支付金额Label
        CGFloat totalPriceLblX = CGRectGetMaxX(actuallyPayLbl.frame);
        CGFloat totalPriceLblW = bottomTool.frame.size.width - confirmBtnW - totalPriceLblX;
        UILabel *totalPriceLbl = [[UILabel alloc] initWithFrame:CGRectMake(totalPriceLblX, 0, totalPriceLblW, frame.size.height)];
        totalPriceLbl.text = [NSString stringWithFormat:@"%.2f", (self.commSumPrice.floatValue + self.freight.floatValue)];
        totalPriceLbl.textColor = [UIColor redColor];
        // 设置订单模型中的实际支付金额
        self.order.total = totalPriceLbl.text;
        
        [bottomTool addSubview:totalPriceLbl];
        
        self.bottomTool = bottomTool;
        [self.view addSubview:self.bottomTool];
    }
    return self.bottomTool;
}

/**  点击事件 */
- (void)confirmOrder {
    
    // 获取当前时间(点击确认下单后进行此操作)
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *currentDate = [formatter stringFromDate:[NSDate date]];
    
    // 设置订单模型
    self.order.address = self.address;
    self.order.userId = self.address.userId;
    self.order.orderTime = currentDate;
    if (self.commentTF.text == nil) {
        self.order.remarks = @" ";
    } else {
        self.order.remarks = self.commentTF.text;
    }
    // 创建发送请求的参数
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] initWithDictionary:[self.order orderToDictionary:self.order]];
    
    // 将商品模型依次转换成字典并存入数组
    NSMutableArray *array = [NSMutableArray array];
    for (Commodity *comm in self.commsNum) {
        NSDictionary *commDict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d", comm.commodityId], @"commodityId", [NSString stringWithFormat:@"%d", comm.selectedNum], @"commNumber", nil];
        [array addObject:commDict];
    }
    
    // 将数组转为字典
    [parameter setObject:array forKey:@"commListBeans"];
    
    // 请求地址
    NSString *url = @"http://schoolserver.nat123.net/SchoolMarketServer/addOrder.jhtml";
    
    // 发送下单请求
    [AFRequest postConfirmOrder:url andParameter:parameter andResponse:^(NSString * _Nonnull resultStr) {
        if ([resultStr localizedCaseInsensitiveContainsString:@"success"]) {
//            for (Commodity *comm in self.commsNum) {
//                comm.stock = [NSString stringWithFormat:@"%d", (comm.stock.intValue - comm.selectedNum)];
//                comm.selectedNum = 0;
//            }
            // 发送通知，修改已经下单的商品的模型数据
//            [NotifitionSender updateAllSelectedNumNotification:self.commsNum];
            
            // 将已经下单的商品从数据库中删除
            [FMDBsql deleteAllShopcartComms];
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            // 发送重新获取商品数据的通知
            [center postNotificationName:@"reacquireCommodity" object:self];
            // 发送购物车已经更新的通知
            [center postNotificationName:@"shopcartIsUpdate" object:self];
            // 弹出下单成功的提示
            self.alertController.message = @"下单成功";
            [self presentViewController:self.alertController animated:YES completion:nil];
        } else if ([resultStr localizedCaseInsensitiveContainsString:@"error"]) {
            // 弹出下单失败的提示
            self.alertController.message = @"下单失败，请重新下单";
            [self presentViewController:self.alertController animated:YES completion:nil];
        }
    }];
}
@end
