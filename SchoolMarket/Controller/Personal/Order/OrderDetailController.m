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
#import "AFRequest.h"
#import "CommDetailViewController.h"


@interface OrderDetailController () <UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@property (nonatomic,strong) UITableView *odTableview;

@property (nonatomic,strong) UIAlertController *alertController;

@end

@implementation OrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    
    [self.view addSubview:self.odTableview];
    [self getComms];
}

/** 订单详情tableview*/
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
/** 获取订单商品*/
- (void)getComms {
    NSString *url = @"http://schoolserver.nat123.net/SchoolMarketServer/findAllOrderComm.jhtml";
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self.orderDetail.orderId],@"orderId", nil];
    [AFRequest getComm:url andParameter:param andCommBlock:^(NSMutableArray * _Nonnull comms) {
        //获取订单商品
        self.orderDetail.comms = comms;
        
        //商品展示cell
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:2];
        [self.odTableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:(UITableViewRowAnimationNone)];
    } andError:^(NSError * _Nullable error) {
        //推出alertview
        self.alertController.message = @"网络请求失败！";
        [self presentViewController:self.alertController animated:true completion:nil];
    }];
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
        AddressCell *cell = [AddressCell cellWithTableView:tableView];
        //选中风格
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //设置内容
        cell.textLabel.text = [NSString stringWithFormat:@"%@  %@",self.orderDetail.address.consignee,self.orderDetail.address.phone];
        cell.textLabel.font = [UIFont systemFontOfSize:18.0];
        cell.detailTextLabel.text = self.orderDetail.address.addressDetail;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:17.0];
        
        [cell sizeToFit];
        
        return cell;
    } else if (indexPath.section == 1) { //订单信息
        NSString *cellid = @"orderdetailcellid";
        OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[OrderDetailCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid andFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
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
            cell = [[OrderCommShowCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid andFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
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
        //设置大小
        CGRect frame = cell.commCollectionview.frame;
        int r = (int)self.orderDetail.comms.count / 3;
        if ((int)self.orderDetail.comms.count % 3 > 0) {
            r ++;
        }
        frame.size.height = (self.view.frame.size.width / 12 * 5  + 10)* r;
        cell.commCollectionview.frame = frame;
        
        return cell;
        
    } else if (indexPath.section == 3) {  //费用
        NSString *cellid = @"orderdetailcellid";
        OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[OrderDetailCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid andFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
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
            cell = [[OrderDetailCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid andFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
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
    //收货地址
    if (indexPath.section == 0) {
        return 70;
    }
    //如果是商品展示区
    if (indexPath.section == 2) {
        int r = (int)self.orderDetail.comms.count / 3;
        if ((int)self.orderDetail.comms.count % 3 > 0) {
            r ++;
        }
        return 50 + (self.view.frame.size.width / 12 * 5 + 10) * r ;
        
    }
    
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
    [cell setCommCell:(Commodity*)self.orderDetail.comms[indexPath.row]];
    
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
/** 选中商品cell*/
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //跳转商品详情
    CommDetailViewController *subvc = [[CommDetailViewController alloc] init];
    //正向传值
    subvc.comm = self.orderDetail.comms[indexPath.row];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:subvc animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
