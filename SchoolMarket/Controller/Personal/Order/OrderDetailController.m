/*
 订单详情页面
 */

#import "OrderDetailController.h"
#import "Order.h"
#import "AddressCell.h"
#import "Address.h"
#import "OrderDetailCell.h"
#import "OrderCommShowCell.h"
#import "OrderCommCell.h"


@interface OrderDetailController () <UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@property (nonatomic,strong) UITableView *odTableview;
@property (nonatomic,weak) NSArray *comms;  //商品数组

@end

@implementation OrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    
//    self.automaticallyAdjustsScrollViewInsets = false;
    
    [self.view addSubview:self.odTableview];
}

- (UITableView *)odTableview {
    if (!_odTableview) {
        _odTableview = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
        //设置代理和数据源
        _odTableview.delegate = self;
        _odTableview.dataSource = self;
        [_odTableview setSeparatorInset:UIEdgeInsetsMake(2, 0, 1, 10)];
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
        return 1;
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
            [cell setOrderDetail:@"订单编号" andContent:[NSString stringWithFormat:@"%d",self.orderDetail.orderId]];
        } else if (indexPath.row == 1)  { //状态
            [cell setOrderDetail:@"状态" andContent:[NSString stringWithFormat:@"%@",self.orderDetail.state]];
        } else if (indexPath.row == 2) {  //下单时间
            [cell setOrderDetail:@"下单时间" andContent:[NSString stringWithFormat:@"%@",self.orderDetail.orderTime]];
        } else if (indexPath.row == 3) {  //配送时间
            [cell setOrderDetail:@"配送时间" andContent:[NSString stringWithFormat:@"%@",self.orderDetail.deliverTime]];
        }
        return cell;
        
    } else if (indexPath.section == 2) {  //商品展示
        NSString *cellid = @"commscellid";
        OrderCommShowCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[OrderCommShowCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
        }
        //选中风格
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //设置collectionview代理 和数据源
        cell.commCollectionview.delegate = self;
        cell.commCollectionview.dataSource = self;
        //注册collectionview cellid
        [cell.commCollectionview registerClass:[OrderCommCell class] forCellWithReuseIdentifier:@"commscellid"];
        
        //设置内容
        [cell setOrderDetail:@"商品" andContent:nil];
        
        //单元格自适应
        [cell.commCollectionview sizeToFit];  //先适应collectionview
        [cell sizeToFit];  //再适应cell
        
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
            [cell setOrderDetail:@"总额" andContent:[NSString stringWithFormat:@"%@",self.orderDetail.total]];
        } else if (indexPath.row == 1) { //运费
            [cell setOrderDetail:@"运费" andContent:[NSString stringWithFormat:@"%@",self.orderDetail.freight]];
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
        [cell setOrderDetail:@"备注" andContent:[NSString stringWithFormat:@"%@",self.orderDetail.remarks]];
        cell.lbContent.numberOfLines = 0;//设置行数
        
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
/** 头视图高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}
/** 脚视图高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

#pragma mark collectionview 代理
/** 返回cell个数*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.orderDetail.comms.count;
}
/** 获取cell*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellid = @"commscellid";
    OrderCommCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    //设置内容
    [cell setCommCell:(Commodity*)self.comms[indexPath.row]];
    
    return cell;
    
}
/** cell大小*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width / 4, self.view.frame.size.width / 12 * 5);
}
/** cell间距*/
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, self.view.frame.size.width / 15, 5, 20);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
