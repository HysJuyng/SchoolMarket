/*
 购物车
 */

#import "ShoppingCartController.h"
#import "SCBottomTool.h"
#import "SCCommCell.h"
#import "CommDetailViewController.h"
#import "ShoppingCart.h"
#import "ConfirmOrderViewController.h"
#import "Commodity.h"
#import "FMDBsql.h"
#import "NotifitionSender.h"

@interface ShoppingCartController () <UITableViewDataSource, UITableViewDelegate, SCCommCellDelegate, SCBottomToolDelegate, ShoppingCartDelegate>

/**  空购物车视图 */
@property (nonatomic, weak) ShoppingCart *emptySC;
/**  购物车商品视图（非空） */
@property (nonatomic, weak) UIView *detailSC;
/**  底部工具栏 */
@property (nonatomic, weak) SCBottomTool *bottomTool;
/**  商品 */
@property (nonatomic, weak) UITableView *comms;
/**  总价 */
@property (nonatomic, copy) NSString *sumPrice;
/**  购物车里商品数组 */
@property (nonatomic, strong) NSMutableArray *commsNum;

@end

@implementation ShoppingCartController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"购物车";
    
    // 接受数据库更新消息
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(updateShopcart) name:@"shopcartIsUpdate" object:nil];
    // 更新购物车视图
    [self updateShopcart];
}

#pragma mark - 懒加载
- (NSMutableArray *)commsNum {
    if (_commsNum == nil) {
        _commsNum = [NSMutableArray array];
    }
    return _commsNum;
}

- (NSString *)sumPrice {
    if (_sumPrice == nil) {
        for (Commodity *comm in self.commsNum) {
            _sumPrice = [NSString stringWithFormat:@"%.2f", (comm.price.floatValue * comm.selectedNum + _sumPrice.floatValue)];
        }
    }
    return _sumPrice;
}

#pragma mark - 更新购物车视图
/**  接收到通知后调用此方法，更新购物车视图 */
- (void)updateShopcart {
    [self.commsNum removeAllObjects];
    [self.commsNum addObjectsFromArray:[FMDBsql getShopcartComms]];
    self.sumPrice = nil;
    self.bottomTool.sumPriceLbl.text = self.sumPrice;
    if (self.commsNum.count != 0) {
        [self.comms reloadData];
    }

    // 更新购物车状态
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] init];
    [userDefaults setValue:@"false" forKey:@"shopCartIsUpdate"];
    
    if (self.detailSC == nil && self.commsNum.count != 0) {
        [self.emptySC removeFromSuperview];

        // 如果有添加商品则创建商品展示视图
        CGFloat detailSCY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
        CGFloat detailSCW = self.view.bounds.size.width;
        CGFloat detailSCH = CGRectGetMinY(self.tabBarController.tabBar.frame) - detailSCY;
        
        [self detailShoppingCartWithFrame:CGRectMake(0, detailSCY, detailSCW, detailSCH)];
    } else if (self.emptySC == nil && self.commsNum.count == 0){
        [self.detailSC removeFromSuperview];
        self.comms = nil;
        
        // 如果没有添加商品则创建空购物车视图
        CGFloat emptySCY = self.view.bounds.size.height * 0.18;
        CGFloat emptySCW = self.view.bounds.size.width;
        CGFloat emptySCH = self.view.bounds.size.height * 0.6;
        [self emptyShoppingCartWithFrame:CGRectMake(0, emptySCY, emptySCW, emptySCH)];
    }
}

#pragma mark - 购物车详情视图
/**  初始化购物车商品视图 */
- (UIView *)detailShoppingCartWithFrame:(CGRect)frame
{
    if (self.detailSC == nil) {
        UIView *detailSC = [[UIView alloc] initWithFrame:frame];
        
        // 商品条目
        self.automaticallyAdjustsScrollViewInsets = NO;
        CGFloat commsW = frame.size.width;
        CGFloat commsH = frame.size.height - self.tabBarController.tabBar.frame.size.height;
        
        [self commsWithView:detailSC andFrame:CGRectMake(0, 0, commsW, commsH)];
        
        // 底部工具栏
        CGFloat bottomToolW = frame.size.width;
        CGFloat bottomToolH = self.tabBarController.tabBar.frame.size.height;
        CGFloat bottomToolY = frame.size.height - bottomToolH;
        
        [self bottomToolWithView:detailSC andFrame:CGRectMake(0, bottomToolY, bottomToolW, bottomToolH)];
        
        self.detailSC = detailSC;
        [self.view addSubview:self.detailSC];

        // 设置导航栏右侧Item
        [self setupNavigationItemWith:self.detailSC];
    }
    return self.detailSC;
}

#pragma mark 导航栏Item
/**  设置导航栏右侧Item */
- (void)setupNavigationItemWith:(UIView *)view
{
    if ([view isEqual:self.detailSC]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editClick)];
    } else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] init];
    }
}

/**  进入编辑模式 */
- (void)editClick
{
    if ([self.navigationItem.rightBarButtonItem.title  isEqual: @"编辑"]) {
        [self.comms setEditing:YES animated:YES];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(editClick)];
    } else {
        [self.comms setEditing:NO animated:YES];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editClick)];
    }
}

#pragma mark 商品表格
/**  初始化商品表格 */
- (void)commsWithView:(UIView *)view andFrame:(CGRect)frame
{
    if (self.comms == nil) {
        UITableView *comms = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        comms.rowHeight = 80;
        comms.dataSource = self;
        comms.delegate = self;
        self.comms = comms;
        [view addSubview:self.comms];
    }
}

#pragma mark 数据源方法
/**  返回Cell数量 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commsNum.count;
}

/**  设置Cell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCCommCell *cell = [SCCommCell cellWithTableView:tableView andFrame:self.view.bounds];
    cell.comm = self.commsNum[indexPath.row];
    return cell;
}

/**  实现拖拽删除 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Commodity *comm = self.commsNum[indexPath.row];
    comm.selectedNum = 0;
    // 发送通知
    [NotifitionSender updateSelectedNumNotification:comm];
    // 将数据库中对应的商品删除
    [FMDBsql deleteShopcartComm:comm.commodityId];
    
    // 删除数组中对应的模型
    [self.commsNum removeObject:comm];
    if (self.commsNum.count == 0) {
        [self updateShopcart];
    } else {
        // 动态删除指定的cell
        [self.comms deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }
    // 更改购物车总价格
    self.sumPrice = nil;
    self.bottomTool.sumPriceLbl.text = self.sumPrice;
}

#pragma mark 代理方法
/**  返回头视图高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 2.0f;
}

/**  返回脚视图高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 2.0f;
}

/**  Cell被选中 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommDetailViewController *commDetail = [[CommDetailViewController alloc] init];
    commDetail.comm = self.commsNum[indexPath.row];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:commDetail animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark 底部工具栏
/**  初始化底部工具栏 */
- (void)bottomToolWithView:(UIView *)view andFrame:(CGRect)frame
{
    if (self.bottomTool == nil) {
        SCBottomTool *bottomTool = [[SCBottomTool alloc] initWithFrame:frame];
        bottomTool.sumPriceLbl.text = self.sumPrice;
        self.bottomTool = bottomTool;
        [view addSubview:self.bottomTool];
    }
}

#pragma mark - 空购物车视图
/**  初始化空购物车视图 */
- (UIView *)emptyShoppingCartWithFrame:(CGRect)frame
{
    if (self.emptySC == nil) {
        ShoppingCart *emptySC = [[ShoppingCart alloc] initWithFrame:frame];
        self.emptySC = emptySC;
        [self.view addSubview:self.emptySC];
        [self setupNavigationItemWith:self.emptySC];
    }
    return self.emptySC;
}

#pragma mark - 点击事件
/** 跳转到超市页面 */
- (void)goToSuperMarket
{
    self.tabBarController.selectedIndex = 1;
}

/**  跳转到确认订单页面 */
- (void)goToConfirmOrder
{
    ConfirmOrderViewController *confirmOrder = [[ConfirmOrderViewController alloc] init];
    confirmOrder.commsNum = self.commsNum;
    confirmOrder.commSumPrice = self.sumPrice;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:confirmOrder animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

/**
 *  添加或减少商品数量时调用的方法
 *
 *  @param btn 点击的按钮
 */
- (void)increaseOrDecreaseButtonDidClickWith:(UIButton *)btn {
    // 取出对应cell
    SCCommCell *currentCell = (SCCommCell *)btn.superview.superview;
    // 取出对应商品模型
    NSIndexPath *indexPath = [self.comms indexPathForCell:currentCell];
    Commodity *currentComm = self.commsNum[indexPath.row];
    if ([btn.currentTitle isEqualToString:@"+"]) {
        // 判断库存
        if (currentComm.selectedNum == currentComm.stock.intValue) {
            NSLog(@"库存不足");
            UIAlertView *error = [[UIAlertView alloc] initWithTitle:nil message:@"库存不足" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [error show];
            return;
        }
        
        currentComm.selectedNum += 1;
    } else if ([btn.currentTitle isEqualToString:@"-"]) {
        currentComm.selectedNum -= 1;
    }
    
    // 更新数据库对应的数据
    [FMDBsql updateShopcartComm:currentComm.commodityId andSelectedNum:currentComm.selectedNum];
    
    if (currentComm.selectedNum == 0) {
        [self.commsNum removeObject:currentComm];
        [self.comms deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        if (self.commsNum.count == 0) {
            [self updateShopcart];
        }
    } else {
        currentCell.comm = currentComm;
    }
    // 更改购物车总价格
    self.sumPrice = nil;
    self.bottomTool.sumPriceLbl.text = self.sumPrice;
    
    // 发送通知
    [NotifitionSender updateSelectedNumNotification:currentComm];
}
@end
