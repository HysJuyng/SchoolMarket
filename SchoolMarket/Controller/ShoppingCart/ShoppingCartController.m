/*
 购物车
 */

#import "ShoppingCartController.h"
#import "SCBottomTool.h"
#import "SCCommCell.h"
#import "CommDetailViewController.h"
#import "ShoppingCart.h"

@interface ShoppingCartController () <UITableViewDataSource, UITableViewDelegate, SCCommCellDelegate, SCBottomToolDelegate>

/**  空购物车视图 */
@property (nonatomic, weak) ShoppingCart *emptySC;
/**  购物车商品视图（非空） */
@property (nonatomic, weak) UIView *detailSC;
/**  底部工具栏 */
@property (nonatomic, weak) SCBottomTool *bottomTool;
/**  商品 */
@property (nonatomic, weak) UITableView *comms;
/**  总价 */
@property (nonatomic, assign) int sumPrice;

@end

@implementation ShoppingCartController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"购物车";

//    CGFloat emptySCY = self.view.bounds.size.height * 0.18;
//    CGFloat emptySCW = self.view.bounds.size.width;
//    CGFloat emptySCH = self.view.bounds.size.height * 0.6;
//    [self emptyShoppingCartWithFrame:CGRectMake(0, emptySCY, emptySCW, emptySCH)];
    
    CGFloat detailSCY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat detailSCW = self.view.bounds.size.width;
    CGFloat detailSCH = CGRectGetMinY(self.tabBarController.tabBar.frame) - detailSCY;
    
    [self detailShoppingCartWithFrame:CGRectMake(0, detailSCY, detailSCW, detailSCH)];
    
}

#pragma mark - 购物车详情视图
/**  初始化购物车商品视图 */
- (void)detailShoppingCartWithFrame:(CGRect)frame
{
    if (self.detailSC == nil) {
        UIView *detailSC = [[UIView alloc] initWithFrame:frame];
        detailSC.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.06];
        
        // 设置导航栏右侧Item
        [self setupNavigationItem];

        // 商品
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
    }
}

#pragma mark 导航栏Item
/**  设置导航栏右侧Item */
- (void)setupNavigationItem
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editClick)];
}

/**  进入编辑模式 */
- (void)editClick
{
    if ([self.navigationItem.rightBarButtonItem.title  isEqual: @"编辑"]) {
        self.comms.editing = YES;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(editClick)];
    } else {
        self.comms.editing = NO;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editClick)];
    }
}

#pragma mark 商品表格
/**  初始化商品表格 */
- (void)commsWithView:(UIView *)view andFrame:(CGRect)frame
{
    if (self.comms == nil) {
        UITableView *comms = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
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
    return 20;
}

/**  设置Cell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCCommCell *cell = [SCCommCell cellWithTableView:tableView andFrame:self.view.bounds];
    
    return cell;
}

/**  实现拖拽删除 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark 代理方法
/**  Cell被选中 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommDetailViewController *commDetail = [CommDetailViewController alloc];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
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
    }
    return self.emptySC;
}

#pragma mark - 点击事件
/** 跳转到超市页面 */
- (void)goToSuperMarket
{
    self.tabBarController.selectedIndex = 1;
}

@end
