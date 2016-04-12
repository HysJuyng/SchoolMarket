/*
 购物车
 */

#import "ShoppingCartController.h"
#import "ShoppingCart.h"
#import "BottomTool.h"

@interface ShoppingCartController ()

/**  空购物车视图 */
@property (nonatomic, weak) ShoppingCart *emptySC;
/**  购物车商品视图（非空） */
@property (nonatomic, weak) UIView *detailSC;
/**  底部工具栏 */
@property (nonatomic, weak) BottomTool *bottomTool;
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
        
        // 底部工具栏
        CGFloat bottomToolW = frame.size.width;
        CGFloat bottomToolH = self.tabBarController.tabBar.frame.size.height;
        CGFloat bottomToolY = frame.size.height - bottomToolH;
        
        [self bottomToolWithView:detailSC andFrame:CGRectMake(0, bottomToolY, bottomToolW, bottomToolH)];

        // 商品
        CGFloat commsW = frame.size.width;
        CGFloat commsH = frame.size.height - bottomToolH;
        
        [self commsWithView:detailSC andFrame:CGRectMake(0, 0, commsW, commsH)];
        
        self.detailSC = detailSC;
        [self.view addSubview:self.detailSC];
    }
}

- (void)commsWithView:(UIView *)view andFrame:(CGRect)frame
{
    if (self.comms == nil) {
        UITableView *comms = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        comms.backgroundColor = [UIColor yellowColor];
        self.comms = comms;
        [view addSubview:self.comms];
    }
}

/**  初始化底部工具栏 */
- (void)bottomToolWithView:(UIView *)view andFrame:(CGRect)frame
{
    if (self.bottomTool == nil) {
        BottomTool *bottomTool = [[BottomTool alloc] initWithFrame:frame];
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

#pragma mark 点击事件
/** 跳转到超市页面 */
- (void)goToSuperMarket
{
    self.tabBarController.selectedIndex = 1;
}

@end
