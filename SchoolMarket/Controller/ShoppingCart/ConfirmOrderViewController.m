//
//  ConfirmOrderViewController.m
//  SchoolMarket
//
//  Created by tb on 16/4/21.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "ConfirmOrderCell.h"

@interface ConfirmOrderViewController () <UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

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

#pragma mark - 订单内容
/**  订单内容 */
- (UITableView *)detailOrderTableViewWithFrame:(CGRect)frame
{
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

/**  每个分组cell的数量 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    } else if (section == 1) {
        return 2;
    } else {
        return 2;
    }
}

/**  cell的明细 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConfirmOrderCell *cell = [[ConfirmOrderCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        UITextField *info = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, self.view.bounds.size.width - 30, cell.frame.size.height)];
        if (indexPath.row == 0) {
            if (self.nameTF == nil) {
                info.text = @"小峰";
                self.nameTF = info;
                [cell addSubview:self.nameTF];
            }
        } else if (indexPath.row == 1) {
            if (self.phoneNumTF == nil) {
                info.text = @"18814182437";
                self.phoneNumTF = info;
                [cell addSubview:self.phoneNumTF];
            }
        } else if (indexPath.row == 2) {
            if (self.addressTF == nil) {
                info.text = @"江门市蓬江区五邑大学";
                self.addressTF = info;
                [cell addSubview:self.addressTF];
            }
        } else {
            if (self.detailAddressTF == nil) {
                info.text = @"17602";
                self.detailAddressTF = info;
                [cell addSubview:self.detailAddressTF];
            }
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"备注";
            if (self.commentTF == nil) {
                CGFloat commentTFX = self.view.bounds.size.width * 0.3;
                CGFloat commentTFW = self.view.bounds.size.width - commentTFX - 15;
                UITextField *commentTF = [[UITextField alloc] initWithFrame:CGRectMake(commentTFX, 0, commentTFW, cell.frame.size.height)];
                commentTF.placeholder = @"可选";
                commentTF.textAlignment = UIControlContentHorizontalAlignmentRight;
                self.commentTF = commentTF;
                [cell addSubview:self.commentTF];
            }
        } else {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"送达时间";
            cell.detailTextLabel.text = @"尽快送到";
            
            [self createTimePicker:cell];
        }
    } else if(indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"商品";
            cell.detailTextLabel.text = @"￥50";
        } else {
            cell.textLabel.text = @"运费";
            cell.detailTextLabel.text = @"￥3";
        }
    }
    
    return cell;
}

#pragma mark UITableView 代理方法
/**  设置头视图高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8.0f;
}

/**  设置脚视图高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8.0f;
}

/**  cell被选中时执行此方法 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSLog(@"收货地址");
    } else if (indexPath.section == 1 && indexPath.row == 1){
        // 设置cell为第一响应者
        ConfirmOrderCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell becomeFirstResponder];
    }
}

#pragma mark - 时间选择器
- (void)createTimePicker:(ConfirmOrderCell *)cell
{
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
- (void)hideTimePicker:(UIBarButtonItem *)btnItem
{
    // 取消cell的第一响应
    NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    ConfirmOrderCell *cell = [self.detailOrderTbl cellForRowAtIndexPath:cellIndexPath];
    [cell resignFirstResponder];
    // 如果点击完成按钮则将cell的detailTextLabel改为对应的时间
    if ([btnItem.title isEqualToString:@"完成"]) {
        NSInteger row = [self.timePicker selectedRowInComponent:0];
        cell.detailTextLabel.text = self.pickerData[row];
    }
}

#pragma mark UIPickerView 数据源方法
/**  设置显示的列数 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

/**  设置显示的行数 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerData.count;
}

#pragma mark UIPickerView 代理方法
/**  设置选择器每行显示的内容 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickerData[row];
}



#pragma mark - 底部工具栏
/**  底部工具栏 */
- (UIView *)bottomToolWithFrame:(CGRect)frame
{
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
        
//        confirm addTarget:self action:<#(nonnull SEL)#> forControlEvents:<#(UIControlEvents)#>
        
        [bottomTool addSubview:confirmBtn];
        
        // 实际支付Label
        UILabel *actuallyPayLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width * 0.25, frame.size.height)];
        actuallyPayLbl.text = @"实际支付";
        actuallyPayLbl.font = [UIFont systemFontOfSize:15.0];
        actuallyPayLbl.textAlignment = NSTextAlignmentCenter;
        
        [bottomTool addSubview:actuallyPayLbl];
        
        // 总支付金额Label
        CGFloat totalPriceLblX = CGRectGetMaxX(actuallyPayLbl.frame);
        CGFloat totalPriceLblW = bottomTool.frame.size.width - confirmBtnW - totalPriceLblX;
        UILabel *totalPriceLbl = [[UILabel alloc] initWithFrame:CGRectMake(totalPriceLblX, 0, totalPriceLblW, frame.size.height)];
        totalPriceLbl.text = @"￥50";
        totalPriceLbl.textColor = [UIColor redColor];
        
        [bottomTool addSubview:totalPriceLbl];
        
        self.bottomTool = bottomTool;
        [self.view addSubview:self.bottomTool];
    }
    return self.bottomTool;
}

@end
