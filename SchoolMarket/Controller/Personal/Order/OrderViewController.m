/*
 订单页面
 */

#import "OrderViewController.h"
#import "OrderCell.h"
#import "OrderDetailController.h"


@interface OrderViewController () <UITableViewDataSource,UITableViewDelegate>

//@property (nonatomic,weak) StatesOfOrderView *statesView; 
@property (nonatomic,strong) UITableView *statesTableview;    //状态tableview
@property (nonatomic,strong) UITableView *orderTableview;   //订单tableview

@property (nonatomic,strong) NSArray *states;  //状态数组
@property (nonatomic,strong) NSMutableArray *ongoingOrders;   //进行中的订单
@property (nonatomic,strong) NSMutableArray *completedOrders;  //已完成的订单

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的订单";
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    //添加状态tableview
    [self.view addSubview:self.statesTableview];
    self.states = [[NSArray alloc] initWithObjects:@"进行中",@"已完成", nil];
    
    //添加订单tableview
    [self.view addSubview:self.orderTableview];
    
}

/** 状态tableview*/
- (UITableView *)statesTableview {
    if (!_statesTableview) {
        _statesTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 50, self.view.frame.size.width ) style:(UITableViewStyleGrouped)];
        _statesTableview.center = CGPointMake(self.view.frame.size.width / 2, CGRectGetMaxY(self.navigationController.navigationBar.frame) + (_statesTableview.frame.size.width) / 2);
        // 逆时针旋转90°
        _statesTableview.transform = CGAffineTransformMakeRotation(-M_PI_2);
        //移除滚动条
        _statesTableview.showsVerticalScrollIndicator = NO;
        //取消滚动
        _statesTableview.scrollEnabled = false;
        //设置代理和数据源
        _statesTableview.delegate = self;
        _statesTableview.dataSource = self;
    }
    return _statesTableview;
}
/** 订单tableview*/
- (UITableView *)orderTableview {
    if (!_orderTableview) {
        CGFloat ordervY = self.statesTableview.frame.origin.y + self.statesTableview.frame.size.height;
        CGFloat ordervH = self.view.frame.size.height -  ordervY;
        _orderTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, ordervY , self.view.frame.size.width, ordervH) style:(UITableViewStyleGrouped)];
        //设置代理和数据源
        _orderTableview.delegate = self;
        _orderTableview.dataSource = self;
        
        [_orderTableview setSeparatorInset:UIEdgeInsetsMake(2, 0, 1, 10)];
    }
    return _orderTableview;
}

#pragma mark tableview代理方法
/** 返回cell行数*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _statesTableview) {
        return 2;
    }
    return 3;
}
/** 获取cell*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _statesTableview) {
        NSString *cellid = @"statecellid";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
        }
#pragma mark - ios9.1文本内容不显示 -
        //cell选择样式
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell内容
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = self.states[indexPath.row];
        [cell.textLabel sizeToFit];
        //顺时针旋转90度
        cell.transform = CGAffineTransformMakeRotation(M_PI_2);
        return cell;
    } else {
        NSString *cellid = @"ordercellid";
        OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[OrderCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid andFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 8)];
        }
        //cell选择样式
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //设置cell的内容
        [cell setOrderCellWithOrder:nil];
        
        return cell;
    }

}
/** cell高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _statesTableview) {
        return self.view.frame.size.width / 2;
    }
    return self.view.frame.size.height / 8;
}
/** 返回头视图高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}
/** 返回脚视图高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}
/** 选择cell*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //如果是状态tableview
    if (tableView == _statesTableview) {
        NSLog(@"%@",[tableView cellForRowAtIndexPath:indexPath].textLabel.text);
        //切换所要显示的状态的订单
        [self.orderTableview reloadData];
    } else if (tableView == _orderTableview) {  //如果是订单tableview
        //跳转订单详情页面
        
        OrderDetailController *subvc = [[OrderDetailController alloc] init];
        //正向传值
        if (self.statesTableview.indexPathForSelectedRow.row == 0) {  //进行中
            subvc.orderDetail = self.ongoingOrders[indexPath.row];
        } else {  //已完成
            subvc.orderDetail = self.completedOrders[indexPath.row];
        }
        
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:subvc animated:true];
        
    }
}

#pragma mark 自定义方法


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
