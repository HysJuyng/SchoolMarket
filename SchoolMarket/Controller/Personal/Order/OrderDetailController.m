/*
 订单详情页面
 */

#import "OrderDetailController.h"
#import "Order.h"
#import "AddressCell.h"
#import "Address.h"
#import "OrderDetailCell.h"


@interface OrderDetailController () <UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,weak) UITableView *odTableview;

@end

@implementation OrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    
    [self.view addSubview:self.odTableview];
}

- (UITableView *)odTableview {
    if (!_odTableview) {
        UITableView *tempodtableview = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
        _odTableview = tempodtableview;
        //设置代理和数据源
        _odTableview.delegate = self;
        _odTableview.dataSource = self;
    }
    return _odTableview;
}

#pragma mark tableview代理
/** 返回tableview区数*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
/** 返回单元格行数*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) { //收货地址
        return 0;
    } else if (section == 1) { //订单信息
        return 4;
    } else if (section == 2) {  //商品展示
        return 1;
    } else if (section == 3) {  //费用
        return 2;
    } else {   //备注
        return 1;
    }
}
/** 获取cell*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //根据区来获取cell
    if (indexPath.section == 0) {  //收货地址
        NSString *cellid = @"addresscellid";
        AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[AddressCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
        }
        //选中风格
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //设置内容
        cell.textLabel.text = @"姓名 手机号码";
        cell.textLabel.font = [UIFont systemFontOfSize:18.0];
        cell.detailTextLabel.text = @"详细地址";
        cell.detailTextLabel.font = [UIFont systemFontOfSize:17.0];
        
        return cell;
    } else if (indexPath.section == 1) { //订单信息
        NSString *cellid = @"orderdetailcellid";
        OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[OrderDetailCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
        }
        //选中风格
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //设置内容
        if (indexPath.row == 0) {  //订单id
            [cell setOrderDetail:@"订单编号" andContent:[NSString stringWithFormat:@"%d",self.order.orderId]];
        } else if (indexPath.row == 1)  { //状态
            [cell setOrderDetail:@"状态" andContent:[NSString stringWithFormat:@"%@",self.order.state]];
        } else if (indexPath.row == 2) {  //下单时间
            [cell setOrderDetail:@"下单时间" andContent:[NSString stringWithFormat:@"%@",self.order.orderTime]];
        } else if (indexPath.row == 3) {  //配送时间
            [cell setOrderDetail:@"配送时间" andContent:[NSString stringWithFormat:@"%@",self.order.deliverTime]];
        }
        return cell;
        
    } else if (indexPath.section == 2) {  //商品展示
        NSString *cellid = @"commscellid";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
        }
        //选中风格
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //设置内容
        
        return cell;
        
    } else if (indexPath.section == 3) {  //费用
        NSString *cellid = @"orderdetailcellid";
        OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[OrderDetailCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
        }
        //选中风格
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //设置内容
        if (indexPath.row == 0) {   //总额
            [cell setOrderDetail:@"总额" andContent:[NSString stringWithFormat:@"%@",self.order.total]];
        } else if (indexPath.row == 1) { //运费
            [cell setOrderDetail:@"运费" andContent:[NSString stringWithFormat:@"%@",self.order.freight]];
        }
        return cell;
    } else {   //备注
        NSString *cellid = @"orderdetailcellid";
        OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[OrderDetailCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
        }
        //选中风格
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //设置内容
        [cell setOrderDetail:@"备注" andContent:[NSString stringWithFormat:@"%@",self.order.remarks]];
        cell.lbContent.numberOfLines = 0;//设置行数
        
        return cell;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
